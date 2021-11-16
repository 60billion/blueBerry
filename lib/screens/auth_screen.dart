import 'package:blueberry/screens/start/intro_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: [
        Center(child: IntroPage()),
        Container(
          color: Colors.accents[3],
        ),
        Container(
          color: Colors.accents[5],
        ),
      ]),
    );
  }
}
