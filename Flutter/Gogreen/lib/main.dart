import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Forgetpassword2.dart';
import 'package:gogreen/Loginpage.dart';
import 'package:gogreen/Registerpage.dart';
import 'package:gogreen/homepage_provider.dart';
import 'package:gogreen/Onboarding_pages.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:gogreen/Signingoogle.dart';
import 'package:gogreen/Signingup.dart';
import 'package:gogreen/Verfication.dart';
import 'package:gogreen/Validverfication.dart';
import 'package:gogreen/Forgetpasword.dart';
import 'package:gogreen/Homepage.dart';
import 'package:gogreen/selection_provider.dart';
import 'package:gogreen/onboarding_state.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomepageProvider()),

        ChangeNotifierProvider(create: (_) => OnboardingState()),
        ChangeNotifierProvider(create: (_) => SelectionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GoGreen',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home:OnboardingPages()
        );
      },
    );
  }
}
