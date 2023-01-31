import 'package:flutter/material.dart';
import 'package:login_page/view/access_page.dart';
import 'package:login_page/view/inactiveView.dart';
import 'package:login_page/view/user_home_page.dart';
import 'package:login_page/view/registerFleet.dart';
import 'auth.dart';

import 'view/login_page.dart';
import 'view/sign_up_page.dart';
import 'controller/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/admin_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/admin_home': (context) => AdminHomePage(),
        '/register_fleet': (context) => RegisterFleet(),
        '/access': (context) => AccessPage(),
        '/inactive': (context) => InactivePage(),
        '/user_home': (context) => UserHomePage()
      },
    );
  }
}
