// ignore_for_file: prefer_const_constructors

import 'package:beamer/src/beamer.dart';
import 'package:flutter/material.dart';

import 'mult_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
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
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
            ),
            _divider,
            ListTile(
              dense: true,
              title: Text('선택'),
              trailing: Icon(Icons.navigate_next),
            ),
            _divider,
          ],
        ),
      ),
    );
  }
}
