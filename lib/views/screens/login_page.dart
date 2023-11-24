
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:spadvieww/views/screens/sign_page.dart';

import '../../controller/loginscreen_controller.dart';
import '../../controller/transactioncontroller.dart';
import '../../controller/usercontroller.dart';
import '../../helper/database_helper.dart';
import '../../utility/animation/fade controller.dart';
import '../../utility/animation/loop_controller.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            FadeAnimation(
                0.8,
                50,
                SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/lbg4.png',
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
                      'assets/images/lbg1.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: FadeAnimation(
                1.4,
                -50,
                Positioned(
                  top: 100,
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/lbg3.png',
                      fit: BoxFit.fitWidth,
                    ),
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
                         'assets/images/lbg2.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.9, 0.3),
              child: Form(
                key: formKey,
                child: Container(
                  height: size.height * 1,
                  padding: EdgeInsets.all(28),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.46,
                        ),
                        FadeAnimation(
                          1.0,
                          -30,
                          Text(
                            'LOG IN',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.060,
                        ),
                        FadeAnimation(
                          1.2,
                          30,
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: userController,
                              autocorrect: true,
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
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeAnimation(
                          1.4,
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
                          height: 50,
                        ),
                        FadeAnimation(
                          1.6,
                          30,
                          LoadingBtn(
                            height: 45,
                            borderRadius: 24,
                            roundLoadingShape: false,
                            color: Color(0xff7adcfc),
                            width: MediaQuery.of(context).size.width * 0.25,
                            minWidth: MediaQuery.of(context).size.width * 0.20,
                            loader: const CircularProgressIndicator(color: Colors.white,),
                            child: const Text(
                              'LOG IN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 2),
                            ),
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.idle) {
                                startLoading();
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                if (formKey.currentState!.validate()) {
                                  bool isAuthenticated = await DbHelper.dbHelper
                                      .loginUser(
                                          username: userController.text,
                                          password: passwordController.text);

                                  if (isAuthenticated) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'valid username or password.')));
                                    await DbHelper.dbHelper.getUserByUsername(username: userController.text);
                                    await Provider.of<UserController>(context,listen: false).init();
                                    await DbHelper.dbHelper.initDB();
                                    await Provider.of<TransactionController>(context,listen: false).init();
                                    await Provider.of<LoginScreenController>(context,listen: false).islogin();
                                    Navigator.of(context).pushReplacement(
                                      PageTransition(
                                        type: PageTransitionType.scale,
                                        alignment: Alignment
                                            .bottomCenter, // or any other alignment
                                        child: HomePage(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'invalid username or password.')));
                                    stopLoading();
                                  }
                                }

                                stopLoading();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.072,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New to spandvieww ? ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: SingUpPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Register now",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.85),
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: size.height * 0.13,
                  padding: EdgeInsets.only(left: 20),
                  child: Stack(
                    children: [
                      Positioned(
                          left: 13,
                          child: FadeAnimation(
                              1.2,
                              -30,
                              Image.asset(
                                "assets/images/circal.png",
                                height: size.height * 0.045,
                              ))),
                      Positioned(
                          top: 21,
                          child: FadeAnimation(
                              1.2,
                              10,
                              Image.asset(
                                "assets/images/pig.png",
                                height: size.height * 0.075,
                              ))),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment(-0.8, -0.55),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Spandview',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 500),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
