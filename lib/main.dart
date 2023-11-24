import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spadvieww/utility/colors.dart';
import 'package:spadvieww/views/screens/splesh_screen.dart';
import 'controller/api_controller.dart';
import 'controller/categorycontroller.dart';
import 'controller/heatmapcontroller.dart';
import 'controller/loginscreen_controller.dart';
import 'controller/pageindex_page.dart';
import 'controller/savings_controller.dart';
import 'controller/transactioncontroller.dart';
import 'controller/usercontroller.dart';
import 'helper/database_helper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDB();
  SharedPreferences Pref = await SharedPreferences.getInstance();
  bool isLogin = Pref.getBool("isLogin") ?? false;
  bool isIntro = Pref.getBool("isIntro") ?? false;
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserController(),),
      ChangeNotifierProvider(create: (context) => CategoryController(),),
      ChangeNotifierProvider(create: (context) => HeatmapController(),),
      ChangeNotifierProvider(create: (context) => Apicontroller(),),
      ChangeNotifierProvider(create: (context) => SavingsController(),),
      ChangeNotifierProvider(create: (context) => PageIndexController(),),
      ChangeNotifierProvider(create: (context) => TransactionController(),),
      ChangeNotifierProvider(
        create: (context) => LoginScreenController(isLogin: isLogin, isIntro: isIntro),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: primary,
        useMaterial3: true,

      ),
      title: 'Spandview',
      routes: {
        '/': (context) =>  SpleshScreen(),
      },
    );
  }
}
