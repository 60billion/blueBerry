// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:typed_data';

import 'package:beamer/src/beamer.dart';
import 'package:blueberry/constants/data_keys.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/repo/image_storage.dart';
import 'package:blueberry/repo/item_service.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/states/category_notifier.dart';
import 'package:blueberry/states/select_image_notifier.dart';
import 'package:blueberry/states/user_provider.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:location/location.dart';
import 'package:provider/src/provider.dart';

import 'mult_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool _suggestPriceSelected = false;

  void attemptCreateItem() async {
    if (FirebaseAuth.instance.currentUser == null) return;
    _isCreatingItem = true;
    setState(() {});

    final String userKey = FirebaseAuth.instance.currentUser!.uid;
    final String itemKey = ItemModel.getitemKey(userKey);

    List<Uint8List> images = context.read<SelectImageNotifier>().images;
    List<String> downloadUrls =
        await ImageStorage.uploadImages(images, itemKey) ?? [];

    if (context.read<UserProvider>().userModel == null) return;

    String title = _titleController.text;
    String category = context.read<CategoryNotifier>().currentCategoryInEng;
    int price = int.parse(_priceController.text.replaceAll(',', ''));
    String detail = _detailController.text;
    bool negotiable = _suggestPriceSelected;
    String address = context.read<UserProvider>().userModel!.address;
    DateTime createdDate = DateTime.now().toUtc();

    ItemModel itemModel = ItemModel(
        itemKey: itemKey,
        userKey: userKey,
        imageDownloadUrls: downloadUrls,
        title: title,
        category: category,
        price: price,
        negotiable: negotiable,
        detail: detail,
        address: address,
        geoFirePoint: context.read<UserProvider>().userModel!.geoFirePoint,
        createdDate: createdDate);

    logger.d(downloadUrls);
    await ItemService().createNewItem(itemModel.toJson(), itemKey);
    _isCreatingItem = false;
    setState(() {});
    context.beamBack();
  }

  TextEditingController _priceController = TextEditingController();
  UnderlineInputBorder _border =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  var _divider = Divider(
    height: 1.0,
    thickness: 1.0,
    color: Colors.grey[350],
    indent: 16.0,
    endIndent: 16.0,
  );

  bool _isCreatingItem = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double width = MediaQuery.of(context).size.width;
      return IgnorePointer(
        ignoring: _isCreatingItem,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: Size(width, 2),
                child: _isCreatingItem
                    ? LinearProgressIndicator(
                        minHeight: 2,
                      )
                    : Container(),
              ),
              actions: [
                TextButton(
                  onPressed: attemptCreateItem,
                  child: Text(
                    '완료',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(primary: Colors.black87),
                ),
              ],
              leading: TextButton(
                onPressed: () {
                  context.beamBack();
                },
                child: Text(
                  '뒤로',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(primary: Colors.black87),
              ),
              title: Text('중고거래 글쓰기'),
              centerTitle: true,
            ),
            body: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                MultiImageSelect(),
                _divider,
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: '글 제목',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                  ),
                ),
                _divider,
                ListTile(
                  dense: true,
                  onTap: () {
                    context.beamToNamed(
                        '/$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT');
                  },
                  title: Text(
                    context.watch<CategoryNotifier>().currentCategoryInKor,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  trailing: Icon(Icons.navigate_next),
                ),
                _divider,
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _priceController,
                          inputFormatters: [
                            MoneyInputFormatter(mantissaLength: 0)
                          ],
                          onChanged: (value) {
                            if (_priceController.text == "0") {
                              _priceController.clear();
                            }
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            icon: Icon(
                              Icons.payment,
                              color: _priceController.text.isNotEmpty
                                  ? Colors.purple
                                  : Colors.black54,
                              size: 24,
                            ),
                            hintText: '얼마에 파시겠어요?',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            border: _border,
                            enabledBorder: _border,
                            focusedBorder: _border,
                          )),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _suggestPriceSelected = !_suggestPriceSelected;
                          });
                        },
                        icon: Icon(
                          _suggestPriceSelected
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: _suggestPriceSelected
                              ? Colors.purple
                              : Colors.black54,
                        ),
                        label: Text(
                          '가격제안 받기',
                          style: TextStyle(
                              color: _suggestPriceSelected
                                  ? Colors.purple
                                  : Colors.black54),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent),
                      ),
                    ),
                  ],
                ),
                _divider,
                TextFormField(
                  controller: _detailController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: '게시글 내용을 작성해주세요',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
