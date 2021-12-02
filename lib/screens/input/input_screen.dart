// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:beamer/src/beamer.dart';
import 'package:blueberry/states/category_notifier.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/src/provider.dart';

import 'mult_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool _suggestPriceSelected = false;
  TextEditingController _priceController = TextEditingController();
  UnderlineInputBorder _border =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  var _divider = Divider(
    height: 1.0,
    thickness: 1.0,
    color: Colors.grey[350],
    indent: 16.0,
    endIndent: 16.0,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  context.beamBack();
                },
                child: Text(
                  '완료',
                  style: TextStyle(color: Colors.white),
                )),
          ],
          leading: TextButton(
              onPressed: () {
                context.beamBack();
              },
              child: Text(
                '뒤로',
                style: TextStyle(color: Colors.white),
              )),
          title: Text('중고거래 글쓰기'),
          centerTitle: true,
        ),
        body: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            MultiImageSelect(),
            _divider,
            TextFormField(
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
                context.beamToNamed('/input/category_input');
              },
              title: Text(
                context.watch<CategoryNotifier>().currentCategoryInKor,
                // style: TextStyle(fontSize: 16, color: Colors.black54),
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
                      inputFormatters: [MoneyInputFormatter()],
                      onChanged: (value) {
                        if (_priceController.text == "0.00") {
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
    );
  }
}
