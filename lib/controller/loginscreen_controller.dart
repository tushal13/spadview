import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends ChangeNotifier {
  bool isLogin = false;
  bool isIntro = false;

  LoginScreenController({required this.isLogin, required this.isIntro});

   islogin() async {
    isLogin = true;

    SharedPreferences Pref = await SharedPreferences.getInstance();

    Pref.setBool("isLogin", isLogin);
    log(isLogin.toString());

    notifyListeners();
  }islogout() async {
    isLogin = false;

    SharedPreferences Pref = await SharedPreferences.getInstance();

    Pref.setBool("isLogin", isLogin);
    log(isLogin.toString());

    notifyListeners();
  }

  isintro() async {
    isIntro = true;

    SharedPreferences Pref = await SharedPreferences.getInstance();

    Pref.setBool("isIntro", isIntro);
    log(isIntro.toString());

    notifyListeners();
  }
}
