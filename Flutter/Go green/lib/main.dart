import 'package:flutter/material.dart';
import 'package:gogreen/Forgetpassword2.dart';
import 'package:gogreen/Loginpage.dart';
import 'package:gogreen/Registerpage.dart';
import 'package:gogreen/onboarding1.dart';
import 'package:gogreen/onboarding2.dart';
import 'package:gogreen/onboarding3.dart';
import 'package:gogreen/onboarding3.dart';
import 'package:gogreen/onboarding4.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:gogreen/Registerpage.dart';
import 'package:gogreen/Loginpage.dart' ;
import 'package:gogreen/Signingoogle.dart' ;
import 'package:gogreen/Signingup.dart' ;
import 'package:gogreen/Verfication.dart' ;
import 'package:gogreen/Validverfication.dart' ;
import 'package:gogreen/Forgetpasword.dart' ;
import 'package:gogreen/Forgetpassword2.dart' ;
import 'package:gogreen/Homepage.dart' ;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Homepage()
    );
  }
}
