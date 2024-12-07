import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:gogreen/onboarding3.dart';
import 'package:provider/provider.dart';
import 'package:gogreen/onboarding_state.dart';

class Onboarding2 extends StatelessWidget {
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
            size: 70,
          ),
          onPressed: () {
            onboardingState.updateCurrentPage(0);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70.h),
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
            SizedBox(height: 15.h),
            Text(
              'Learn how to plant and care for trees',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF147351),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Container(
                width: 100.w,
                height: 100.h,
              ),
            ),
            SizedBox(height: 20.h),
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
                  return SizedBox();
                },
              ),
            ),
            InkWell(
              onTap: () {
                onboardingState.updateCurrentPage(2);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Onboarding3()),
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
