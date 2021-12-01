// ignore_for_file: prefer_const_constructors

import 'package:beamer/src/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

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
            Row(
              children: [
                Container(
                  child: ExtendedImage.network(
                      'https://picsum.photos/100/100?random=1',
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                ),
                MultiImageSelect(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
          child: ListView.builder(
            padding: EdgeInsets.all(14.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ExtendedImage.network(
                  'https://picsum.photos/100/100?random={$index+1}',
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(14.0)));
            },
            itemCount: 10,
          ));
    });
  }
}
