import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/imgs/60Logo.png',
            height: 150.0,
          ),
          const SizedBox(
            height: 40.0,
          ),
          const CircularProgressIndicator(
            color: Colors.blue,
          ),
        ],
      )),
    );
  }
}
