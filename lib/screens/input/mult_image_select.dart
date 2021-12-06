import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImageSelect extends StatefulWidget {
  const MultiImageSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<MultiImageSelect> createState() => _MultiImageSelectState();
}

class _MultiImageSelectState extends State<MultiImageSelect> {
  List<Uint8List> _images = [];
  bool _isPickingImages = false;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double width = MediaQuery.of(context).size.width;
      return SizedBox(
        height: width / 3,
        width: width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () async {
                  _isPickingImages = true;
                  setState(() {});
                  final List<XFile>? images =
                      await picker.pickMultiImage(imageQuality: 10);
                  if (images != null && images.isNotEmpty) {
                    _images.clear();
                    images.forEach((XFile) async {
                      _images.add(await XFile.readAsBytes());
                    });
                  }
                  _isPickingImages = false;
                  setState(() {});
                },
                child: Container(
                  child: _isPickingImages
                      ? Container(
                          child: CircularProgressIndicator(),
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(30),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.grey,
                            ),
                            Text(
                              "0/10",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                  width: width / 3 - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                ),
              ),
            ),
            ...List.generate(
                _images.length,
                (index) => Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 16, top: 16, bottom: 20),
                            child: ExtendedImage.memory(_images[index],
                                shape: BoxShape.rectangle,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover, loadStateChanged: (state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return Container(
                                    child: CircularProgressIndicator(),
                                    width: 30,
                                    height: 30,
                                    padding: EdgeInsets.all(30),
                                  );
                                case LoadState.completed:
                                  return null;
                                case LoadState.failed:
                                  return Icon(Icons.cancel);
                              }
                            },
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)))),
                        IconButton(
                          onPressed: () {
                            _images.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(Icons.remove_circle),
                          color: Colors.black87,
                        )
                      ],
                    ))
          ],
        ),
      );
    });
  }
}
