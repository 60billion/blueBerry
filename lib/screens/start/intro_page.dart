// ignore_for_file: prefer_const_constructors

import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "블루베리 마켓",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            ExtendedImage.asset("assets/imgs/carrot_intro.png"),
            Text('우리 동네 중고 직거래 블루베리마켓',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            Text("블루베리 마켓은 직거래 마켓이에요.\n내 동네를 성정하고 시작해보세요.",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    logger.d("on text button clicked!");
                  },
                  child: Text(
                    '내 동네 설정하고 시작하기',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.purple),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
