import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Forgetpassword2.dart';
import 'package:gogreen/Loginpage.dart';
import 'package:gogreen/Registerpage.dart';
import 'package:gogreen/onboarding1.dart';
import 'package:gogreen/onboarding2.dart';
import 'package:gogreen/onboarding3.dart';
import 'package:gogreen/onboarding4.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:gogreen/Signingoogle.dart';
import 'package:gogreen/Signingup.dart';
import 'package:gogreen/Verfication.dart';
import 'package:gogreen/Validverfication.dart';
import 'package:gogreen/Forgetpasword.dart';
import 'package:gogreen/Homepage.dart';
import 'package:gogreen/TreeplantingGuide.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GoGreen',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: OnboardingPages(),
        );
      },
    );
  }
}

class OnboardingPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Onboarding1(),
          Onboarding2(),
          Onboarding3(),
          Onboarding4(),
        ],
      ),
    );
  }
}
