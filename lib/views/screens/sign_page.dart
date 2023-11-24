import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/usercontroller.dart';
import '../../helper/database_helper.dart';
import '../../modal/user_modal.dart';
import '../../utility/animation/fade controller.dart';
import '../../utility/animation/loop_controller.dart';
import '../../utility/avtar_list.dart';
import 'login_page.dart';
class SingUpPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  UserModal user = UserModal.init();
  Logger l = Logger();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          FadeAnimation(
              0.8,
              50,
              SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/sbg2.png',
                    fit: BoxFit.fitWidth,
                  ))),
          Container(
            child: FadeAnimation(
              1.2,
              -50,
              Positioned(
                top: 100,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/sbg4.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.4,
            -50,
            Positioned(
              top: 100,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/sbg1.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Container(
            child: FadeAnimation(
              1.6,
              50,
              Positioned(
                top: 100,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/sbg3.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.12,
                    ),
                    FadeAnimation(
                      1.6,
                      -30,
                      Text(
                        'CREATE ACCOUNT',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.060,
                    ),
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: size.height * 0.13,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 13,
                                child: FadeAnimation(
                                    1.8,
                                    -30,
                                    Image.asset(
                                      "assets/images/circal.png",
                                      height: size.height * 0.045,
                                    ))),
                            Positioned(
                                top: 21,
                                child: FadeAnimation(
                                    1.8,
                                    10,
                                    Image.asset(
                                      "assets/images/pig.png",
                                      height: size.height * 0.075,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      2.0,
                      30,
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: userController,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            helperText: 'Please enter your username',
                            helperStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            user.username = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 240,
                      child: FadeAnimation(
                        2.4,
                        30,
                        TextFormField(
                          controller: emailController,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            helperText: 'Please enter your email',
                            helperStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            user.email = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FadeAnimation(
                      2.6,
                      30,
                      SizedBox(
                        width: 275,
                        child: TextFormField(
                          controller: balanceController,
                          autocorrect: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Total Balance',
                            helperText:
                                'Please enter your estimated total balance.',
                          ),
                          onChanged: (val) {
                            user.balance = double.parse(val);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your total balance.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FadeAnimation(
                      2.8,
                      30,
                      SizedBox(
                        width: 295,
                        child: Consumer<UserController>(
                          builder: (context, pro, child) {
                            {
                              return TextFormField(
                                controller: passwordController,
                                autocorrect: true,
                                obscureText: !pro.isPasswordVisible,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  helperText: 'Please enter your password.',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      pro.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      pro.togglePasswordVisibility();
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Password';
                                  }
                                  return null;
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FadeAnimation(
                      3.0,
                      30,
                      Consumer<UserController>(builder: (context, pro, child) {
                        {
                          return TextFormField(
                            controller: confirmPasswordController,
                            autocorrect: true,
                            obscureText: !pro.isconfirmPasswordVisible,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              helperText: 'Please enter your confirm password.',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  pro.isconfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  pro.toggleconfirmPasswordVisibility();
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Password';
                              }
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              l.w('${val}');
                              if (val == passwordController.text) {
                                user.password = val;
                              }
                            },
                          );
                        }
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      3.2,
                      30,
                      LoadingBtn(
                        height: 45,
                        borderRadius: 24,
                        roundLoadingShape: false,
                        color: const Color(0xff66afc2),
                        width: MediaQuery.of(context).size.width * 0.25,
                        minWidth: MediaQuery.of(context).size.width * 0.20,
                        loader: const CircularProgressIndicator(),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              letterSpacing: 2),
                        ),
                        onTap: (startLoading, stopLoading, btnState) async {
                          if (btnState == ButtonState.idle) {
                            startLoading();
                            await Future.delayed(const Duration(seconds: 2));
                            if (formKey.currentState!.validate()) {
                              user.id = 0;
                              String image = avtarList[Random().nextInt(avtarList.length)];
                              List<int> assetData = await rootBundle.load(image).then((ByteData data) => data.buffer.asUint8List());
                              Uint8List bytes = Uint8List.fromList(assetData);
                              user.image = bytes;
                              print('${user.image} ');
                              await DbHelper.dbHelper.registerUser(user: user);
                              l.d("${user.id} \n ${user.username} \n ${user.email} \n ${user.password} \n ${user.balance}");
                              userController.clear();
                              emailController.clear();
                              passwordController.clear();
                              confirmPasswordController.clear();
                              balanceController.clear();
                              Navigator.of(context).pushReplacement(
                                  PageTransition(
                                    type: PageTransitionType.scale,
                                    alignment: Alignment
                                        .bottomCenter, // or any other alignment
                                    child: LoginPage(),
                                  ));
                            }
                            stopLoading();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.050,
                    ),
                    ReverseLoopAnimationWidget(
                        beginValue: -02,
                        endValue: 0,
                        duration: 1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have already an account ? ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login here",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
