import 'package:blueberry/screens/start/address_page.dart';
import 'package:blueberry/screens/start/intro_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  //PageView를 컨트롤,설정하기위해서 인스턴스 생성
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            IntroPage(_pageController), //파라미터로 넣어주어서 사용
            AddressPage(),
            Container(
              color: Colors.accents[5],
            ),
          ]),
    );
  }
}
