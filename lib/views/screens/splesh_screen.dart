import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:spadvieww/controller/loginscreen_controller.dart';
import 'package:spadvieww/utility/colors.dart';
import 'package:spadvieww/views/screens/home_page.dart';
import 'package:spadvieww/views/screens/intro_screen.dart';
import 'package:spadvieww/views/screens/login_page.dart';



class SpleshScreen extends StatefulWidget {
  @override
  _SpleshScreenState createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        a = true;
      });
    });
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        b = true;
      });
    });
    Timer(const Duration(milliseconds: 1300), () {
      setState(() {
        c = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        e = true;
      });
    });
    Timer(const Duration(milliseconds: 3400), () {
      setState(() {
        d = true;
      });
    });
    Timer(const Duration(milliseconds: 3850), () {
      setState(() {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade, child: Provider.of<LoginScreenController>(context,listen: false).isIntro && Provider.of<LoginScreenController>(context,listen: false).isLogin? const HomePage():Provider.of<LoginScreenController>(context,listen: false).isIntro? LoginPage():Provider.of<LoginScreenController>(context,listen: false).isLogin?const HomePage():const IntroPage(),
          ),
        );
      });
    });
  }

  bool a = false;
  bool b = false;
  bool c = false;
  bool d = false;
  bool e = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: d ? 900 : 2500),
              curve: d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: d
                  ? 0
                  : a
                  ? h / 2
                  : 20,
              width: 20,
              // color: Colors.deepPurpleAccent,
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: d
                      ? 1
                      : c
                      ? 2
                      : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: d
                  ? h
                  : c
                  ? 80
                  : 20,
              width: d
                  ? w
                  : c
                  ? 200
                  : 20,
              decoration: BoxDecoration(
                  color: b ? Colors.white : Colors.transparent,
                  // shape: c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius:
                  d ? const BorderRadius.only() : BorderRadius.circular(30)),
              child: Center(
                child: e
                    ? AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    FadeAnimatedText(
                      'SpandView',
                      duration: const Duration(milliseconds: 1700),
                      textStyle: const TextStyle(
                        fontSize: 30,
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

