import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:gogreen/onboarding4.dart';
import 'package:provider/provider.dart';
import 'package:gogreen/onboarding_state.dart';

class Onboarding3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(412, 892), minTextAdapt: true);

    final onboardingState = Provider.of<Onboarding_State>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.green[900],
            size: 70.w,
          ),
          onPressed: () {
            onboardingState.updateCurrentPage(1);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
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
            SizedBox(height: 95.h),
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
            Expanded(
              child: PageView.builder(
                controller: onboardingState.pageController,
                itemCount: 4,
                onPageChanged: (index) {
                  onboardingState.updateCurrentPage(index);
                },
                itemBuilder: (context, index) {
                  return Center();
                },
              ),
            ),
            InkWell(
              onTap: () {
                onboardingState.updateCurrentPage(3);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Onboarding4()),
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
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
