import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:gogreen/onboarding_state.dart';

class Onboarding1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onboardingState = Provider.of<Onboarding_State>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(5.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Container(
                width: 323.w,
                height: 321.h,
                child: Image.asset(
                  'images/img.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Join us in making Egypt greener!',
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 120.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: onboardingState.currentIndex == index
                        ? Colors.green[800]
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: 50.h),
            InkWell(
              onTap: () {


                onboardingState.updateCurrentPage(1);

              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 12.h),
                decoration: BoxDecoration(
                  //  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8.w),
                    Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Splashscreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                decoration: BoxDecoration(),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Onboarding2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(412, 892), minTextAdapt: true);

    final onboardingState = Provider.of<Onboarding_State>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.all(5.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Container(
                width: 323.w,
                height: 249.h,
                child: Image.asset(
                  'images/img_3.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Learn how to plant and care for trees',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF147351),
              ),
            ),
            SizedBox(height: 200.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: onboardingState.currentIndex == index
                        ? Colors.green[800]
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                onboardingState.updateCurrentPage(2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 12.h),
                decoration: BoxDecoration(
                  //  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8.w),
                    Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Splashscreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                decoration: BoxDecoration(),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Onboarding3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(412, 892), minTextAdapt: true);

    final onboardingState = Provider.of<Onboarding_State>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.all(5.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Container(
                width: 247.w,
                height: 247.h,
                child: Image.asset(
                  'images/img_5.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Mark trees that need care or ',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF147351),
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'join community events',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF147351),
              ),
            ),
            SizedBox(height: 150.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: onboardingState.currentIndex == index
                        ? Colors.green[800]
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                onboardingState.updateCurrentPage(3);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 12.h),
                decoration: BoxDecoration(
                  // color: Colors.green[800],
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8.w),
                    Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Splashscreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                decoration: BoxDecoration(),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Onboarding4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(412, 892), minTextAdapt: true);

    final onboardingState = Provider.of<Onboarding_State>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      //
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              Padding(
                padding: EdgeInsets.all(5.0.w),
                child: Container(
                  width: 193.w,
                  height: 247.h,
                  child: Image.asset(
                    'images/img_7.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Earn points and join challenges to',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF147351),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'promote greening',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF147351),
                ),
              ),
              SizedBox(height: 150.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: onboardingState.currentIndex == index
                          ? Colors.green[800]
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              SizedBox(height: 70.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Splashscreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 8.w),
                      Text(
                        'Get start ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
