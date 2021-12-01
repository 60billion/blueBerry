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
          children: [
            MultiImageSelect(),
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.grey,
              indent: 16.0,
              endIndent: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
