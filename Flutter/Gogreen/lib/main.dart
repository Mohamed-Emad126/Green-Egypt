import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Community/CreatePost2.dart';
import 'package:gogreen/Community/CreatePostScreen.dart';
import 'package:gogreen/Community/comments_screen.dart';
import 'package:gogreen/Responses/Addtreeimage.dart';
import 'package:gogreen/Responses/SelectResponse.dart';
import 'package:gogreen/Responses/UploadImages.dart';
import 'package:gogreen/profile/Loginpage.dart';
import 'package:gogreen/Profile/ProfilePage.dart';
import 'package:gogreen/Onboarding_pages.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:gogreen/password/Verficationcode.dart';
import 'package:gogreen/password/Validverfication.dart';
import 'package:gogreen/Homepage.dart';
import 'package:gogreen/profile/Registerpage.dart';
import 'package:gogreen/profile/Signingoogle.dart';
import 'package:gogreen/profile/Signingup.dart';
import 'package:gogreen/provider/auth_provider.dart';
import 'package:gogreen/provider/homepage_provider.dart';
import 'package:gogreen/provider/onboarding_state.dart';
import 'package:gogreen/scan/Verficationtree.dart';
import 'package:gogreen/scan/addtree.dart';
import 'package:gogreen/scan/diagnosebad.dart';
import 'package:gogreen/scan/diagnosegood.dart';
import 'package:gogreen/scan/diagnosegood0.dart';
import 'package:gogreen/scan/scan_page.dart';
import 'package:provider/provider.dart';
import 'password/Forgetpasword.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomepageProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingState()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GoGreen',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/DiagnoseGood0': (context) {
            final args = ModalRoute.of(context)!.settings.arguments;
            return DiagnoseGood0(imagePath: args is String ? args : null);
          },
          '/DiagnoseBad': (context) {
            final args = ModalRoute.of(context)!.settings.arguments;
            return DiagnoseBad(imagePath: args is String ? args : null);
          },
          '/DiagnoseGood': (context) {
            final args = ModalRoute.of(context)!.settings.arguments;
            return DiagnoseGood(imagePath: args is String ? args : null);
          },
          '/createPost': (context) => const CreatePost(),
          '/comments': (context) => const CommentsScreen(),
          '/addTree': (context) => const AddTree(),
          '/scanPage': (context) => const ScanPage(),
          '/': (context) => const Splashscreen(),
          '/login': (context) => const Loginpage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => const Homepage(),
          '/forgot-password': (context) => const ForgetPassword(),
          '/valid-verification': (context) => const ValidVerification(),
          '/profile': (context) => ProfileScreen(),
          '/sign-in-google': (context) => const Signingoogle(),
          '/sign-up': (context) => const Signingup(),
          '/onboarding': (context) => OnboardingPages(),
          '/createPost2': (context) {
            final args = ModalRoute.of(context)!.settings.arguments;
            if (args is File) {
              return CreatePost2(selectedImage: args);
            } else if (args is String) {
              return CreatePost2(selectedImage: File(args));
            }
            return CreatePost2(selectedImage: null);
          },
          '/selectresponse': (context) => SelectResponse(),
          '/uploadResponse': (context) => const UploadResponse(),
          '/VerificationTree': (context) => const VerificationTree(),
        },
      ),
    );
  }
}
