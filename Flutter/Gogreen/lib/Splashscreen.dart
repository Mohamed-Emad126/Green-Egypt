import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Loginpage.dart';
import 'package:gogreen/Registerpage.dart';

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF147351),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 60.w, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Color(0xFF147351),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Padding(
                padding: EdgeInsets.all(5.0.w),
                child: Container(
                  width: 250.w,
                  height: 250.h,
                  child: Image.asset(
                    'images/img_9.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registerpage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Color(0xFF0f6043),
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: Color(0xFF013D26),
                      width: 1.5.w,
                    ),
                  ),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 75.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Color(0xFF147351),
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: Color(0xFF013D26),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2.w,
                        blurRadius: 5.w,
                        offset: Offset(0, 3.h),
                      ),
                    ],
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
