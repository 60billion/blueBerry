// ignore_for_file: prefer_const_constructors

import 'package:blueberry/screens/chat/chat.dart';
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
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                //Todo: 핸드폰을 옆으로 하면 이미지가 짤림...
                height: size.height / 7.5,
                color: Colors.white,
                constraints: BoxConstraints(
                  minHeight: size.width * 0.13,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(size.width / 24, size.width / 34,
                      size.width / 24, size.width / 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          ExtendedImage.network(
                            "https://randomuser.me/api/portraits/lego/6.jpg",
                            width: 50,
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width / 50),
                            child: SizedBox(
                              height: size.width / 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(children: [
                                    Text(
                                      "거래완료",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("이케아 소르테라 분리수거함 5개",
                                        style: TextStyle(fontSize: 14)),
                                  ]),
                                  Row(children: [
                                    Text("30,000원",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("(가격제안불가)",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.rate_review_outlined),
                        label: Text("후기 남기기"),
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 6)),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 4,
                thickness: 0,
                color: Colors.grey[400],
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        bool isMine = (index % 2) == 0;
                        return Chat(size: size, isMine: isMine);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12.0);
                      },
                      itemCount: 30),
                ),
              ),
              _bottomInputBar(size)
            ],
          ),
        ),
      );
    });
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