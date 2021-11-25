// ignore_for_file: prefer_const_constructors

import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //사용자 기기 사이즈를 들고오는 방법: 사용자 디바이스는 전부 사이즈가 다르기 때문에
      //숫지로 사이즈를 설정하면, 디바이스마다 디자인이 다르게 표현될수있다.
      //따라서, 디바이스 사이즈에 비율을 곱하여 사용하면,
      //각기 다른 디바이스에 같은 비율로 디자인을 표시할수있다.
      Size size = MediaQuery.of(context).size;
      final userDeviceWidth = size.width;

      //MediaQuery로 사이즈를 가지고 올수 없는 기기의 경우의 대응도 필요함. 아래 내용 참조
      // MediaQueryData? mediaQuery = MediaQuery.maybeOf(context);
      // if (mediaQuery == null) {
      //   //지원하지 않는 기기라고 메시지를 띄운다?
      // } else {
      //   Size size = MediaQuery.of(context).size;
      // }

      return SafeArea(
        child: Center(
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
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ExtendedImage.asset("assets/imgs/carrot_intro.png"),
                    ExtendedImage.asset(
                      "assets/imgs/carrot_intro_pos.png",
                      width: userDeviceWidth * 0.12,
                    ),
                  ],
                ),
                Text('우리 동네 중고 직거래 블루베리마켓',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                Text("블루베리 마켓은 직거래 마켓이에요.\n내 동네를 성정하고 시작해보세요.",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<PageController>().animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                        logger.d("on text button clicked!");
                      },
                      child: Text(
                        '내 동네 설정하고 시작하기',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.purple),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
