import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Onboarding_pages.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPages()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      backgroundColor: const Color(0xFF147351),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  Padding(
                    padding: EdgeInsets.all(5.0.w),
                    child: SizedBox(
                      width: 250.w,
                      height: 250.h,
                      child: Image.asset(
                        'images/imgg.png',
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 138.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1F845A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 138.h / 2 - 54.h / 2,
            left: 0,
            right: 20.w,
            child: Container(
              height: 54.h,
              width: 340.w,
              decoration: BoxDecoration(
                color: const Color(0xFF147351),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
