// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:blueberry/states/user_provider.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/src/provider.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _phoneNumber = TextEditingController(text: "010");

  TextEditingController _verifyCode = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus ver = VerificationStatus.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double mediaWidth = MediaQuery.of(context).size.width;

      return IgnorePointer(
        ignoring: ver == VerificationStatus.verifying,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(),
              title: Text("전화번호 로그인"),
            ),
            body: Padding(
              padding: EdgeInsets.all(mediaWidth * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: mediaWidth * 0.02),
                          child: ExtendedImage.asset(
                            'assets/imgs/padlock.png',
                            width: mediaWidth * 0.16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "블루베리 마켓은 휴대폰 번호로 가입해요. 번호는 안전하게 보관 되며, 어디에도 공개되지 않아요.",
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: mediaWidth * 0.04,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: mediaWidth * 0.08,
                    ),
                    TextFormField(
                      controller: _phoneNumber,
                      inputFormatters: [MaskedInputFormatter("000 0000 0000")],
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple))),
                      validator: (phoneNumber) {
                        if (phoneNumber != null && phoneNumber.length == 13) {
                          return null;
                        } else {
                          return "전화번호를 정확히 입력해주세요.";
                        }
                      },
                    ),
                    SizedBox(
                      height: mediaWidth * 0.02,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(mediaWidth * 0.12),
                          elevation: 0.0
                          // fromHeight use double.infinity as width and 40 is the height
                          ),
                      label: const Text(' 인증번호 요청',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      icon: const Icon(Icons.confirmation_number),
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          bool passed = _formKey.currentState!.validate();
                          logger.d(passed);
                          if (passed)
                            setState(() {
                              ver = VerificationStatus.codeSent;
                            });
                        }
                      },
                    ),
                    SizedBox(
                      height: mediaWidth * 0.08,
                    ),
                    AnimatedOpacity(
                      duration: Duration(microseconds: 300),
                      opacity: (ver == VerificationStatus.none) ? 0 : 1,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: (ver == VerificationStatus.none) ? 0 : 60,
                        curve: Curves.easeInOut,
                        child: TextFormField(
                          controller: _verifyCode,
                          inputFormatters: [MaskedInputFormatter("000000")],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaWidth * 0.02,
                    ),
                    AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: (ver == VerificationStatus.none)
                            ? 0
                            : mediaWidth * 0.12,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(mediaWidth * 0.12),
                                elevation: 0.0
                                // fromHeight use double.infinity as width and 40 is the height
                                ),
                            onPressed: () {
                              ving();
                            },
                            child: (ver == VerificationStatus.verifying)
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(' 인증',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void ving() async {
    setState(() {
      ver = VerificationStatus.verifying;
    });

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      ver = VerificationStatus.verificationDone;
      context.read<UserProvider>().setUserAuth(true);
    });
  }
}

enum VerificationStatus { none, codeSent, verifying, verificationDone }
