// ignore_for_file: prefer_const_constructors

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatroomScreen extends StatefulWidget {
  final String chatroomKey;

  const ChatroomScreen({Key? key, required this.chatroomKey}) : super(key: key);

  @override
  _ChatroomScreenState createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height / 6,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.only(top: 1),
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 90,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            // MaterialBanner(
            //   actions: [Container()],
            //   content: Column(
            //     children: [
            //       ListTile(
            //         leading:
            //             ExtendedImage.network("https://picsum.photos/50"),
            //         title: RichText(
            //           text: TextSpan(
            //               text: "거래완료",
            //               style: TextStyle(fontSize: 12, color: Colors.black),
            //               // ignore: prefer_const_literals_to_create_immutables
            //               children: [
            //                 TextSpan(
            //                     text: '이케아 분리수거함 5개',
            //                     style: TextStyle(
            //                         fontSize: 10.0, color: Colors.black))
            //               ]),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
            _bottomInputBar(size)
          ],
        ),
      ),
    );
  }

  SizedBox _bottomInputBar(Size size) {
    return SizedBox(
      height: 48,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.purple,
              ),
              onPressed: () {},
            ),
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                  hintText: '메시지를 입력하세요.',
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.purple)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.purple)),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.purple,
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints.tight(Size(40, 40))),
            )),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.purple,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
