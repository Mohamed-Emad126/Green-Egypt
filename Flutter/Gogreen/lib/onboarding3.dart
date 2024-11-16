import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:gogreen/onboarding4.dart';

class Onboarding3 extends StatefulWidget {
  @override
  _Onboarding3State createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3> {
  final PageController _pageController = PageController();
  int _currentIndex = 2;
  bool _isPressed = false;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Container(
                width: 100.w,
                height: 100.h,
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.green[800] : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: 4,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                },
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Onboarding4()),
                );
              },
              onLongPress: () {
                setState(() {
                  _isPressed = !_isPressed;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: _isPressed ? Colors.green[700] : Colors.green[800],
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
