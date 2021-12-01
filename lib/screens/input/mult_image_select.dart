import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MultiImageSelect extends StatelessWidget {
  const MultiImageSelect({
    Key? key,
  }) : super(key: key);

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
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
            ...List.generate(
                20,
                (index) => Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 16, bottom: 20),
                          child: ExtendedImage.network(
                              'https://picsum.photos/100/100?random={$index+1}',
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.remove_circle),
                          color: Colors.black54,
                        )
                      ],
                    ))
          ],
        ),
      );
    });
  }
}
