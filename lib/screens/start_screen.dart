import 'package:blueberry/screens/start/address_page.dart';
import 'package:blueberry/screens/start/auth_page.dart';
import 'package:blueberry/screens/start/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  //PageView를 컨트롤,설정하기위해서 인스턴스 생성
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider<PageController>.value(
      value: _pageController,
      child: Scaffold(
        body: PageView(controller: _pageController,
            //physics: NeverScrollableScrollPhysics(), //페이지뷰에서 스와이프 잠금
            children: [
              IntroPage(), //파라미터로 넣어주어서 사용
              AddressPage(),
              AuthPage(),
            ]),
      ),
    );
  }
}
