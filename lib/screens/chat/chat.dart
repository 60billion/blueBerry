import 'package:blueberry/data/chat_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

const roundedCorner = Radius.circular(20);

class Chat extends StatelessWidget {
  final Size size;
  final bool isMine;
  final ChatModel chatModel;
  const Chat(
      {Key? key,
      required this.size,
      required this.isMine,
      required this.chatModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMine ? _myMsg() : _otherMsg();
  }

  Row _otherMsg() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ExtendedImage.network(
          "https://minimaltoolkit.com/images/randomdata/male/79.jpg",
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          shape: BoxShape.circle,
        ),
        SizedBox(width: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                chatModel.msg,
                style: TextStyle(color: Colors.black),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              constraints:
                  BoxConstraints(minHeight: 40, maxWidth: size.width * 0.55),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: roundedCorner,
                      bottomRight: roundedCorner,
                      topRight: roundedCorner)),
            ),
            SizedBox(width: 6),
            Text("오전 10:25"),
          ],
        ),
      ],
    );
  }

  Row _myMsg() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("오전 10:25"),
        SizedBox(width: 6),
        Container(
          child: Text(
            chatModel.msg,
            style: TextStyle(color: Colors.white),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          constraints:
              BoxConstraints(minHeight: 40, maxWidth: size.width * 0.6),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(3, 3),
                ),
              ],
              color: Colors.purple[300],
              borderRadius: BorderRadius.only(
                  topLeft: roundedCorner,
                  bottomLeft: roundedCorner,
                  bottomRight: roundedCorner,
                  topRight: Radius.circular(2))),
        ),
      ],
    );
  }
}
