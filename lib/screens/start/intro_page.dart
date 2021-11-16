// ignore_for_file: prefer_const_constructors

import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("블루베리 마켓"),
        ExtendedImage.asset("assets/imgs/carrot_intro.png"),
        Text('우리 동네 중고 직거래 블루베리마켓'),
        Text("블루베리 마켓은 직거래 마켓이에요.\n내 동네를 성정하고 시작해보세요."),
        TextButton(
          onPressed: () {
            logger.d("on text button clicked!");
          },
          child: Text(
            '내 동네 설정하고 시작하기',
          ),
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.blue),
        )
      ],
    );
  }
}
