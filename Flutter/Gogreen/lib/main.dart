import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Forgetpassword2.dart';
import 'package:gogreen/Home_event.dart';
import 'package:gogreen/Home_treee.dart';
import 'package:gogreen/Loginpage.dart';
import 'package:gogreen/Registerpage.dart';
import 'package:gogreen/homepage_provider.dart';
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
import 'package:gogreen/selection_provider.dart';
import 'package:gogreen/Planting_location.dart';
import 'package:gogreen/onboarding_state.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomepageProvider()),

        ChangeNotifierProvider(create: (_) => Onboarding_State()),
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
          home:PlantingLocation()
        );
      },
    );
  }
}

class OnboardingPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onboardingState = Provider.of<Onboarding_State>(context);

    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          onboardingState.updateCurrentPage(index);
        },
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
