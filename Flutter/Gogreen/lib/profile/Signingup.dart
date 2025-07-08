import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signingup extends StatelessWidget {
  const Signingup({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF147351),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 60.w, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            color: const Color(0xFF147351),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 70.h),
                  Image.asset(
                    'images/img_11.png',
                    width: 150.w,
                    height: 150.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/img_15.png',
                        width: 35.w,
                        height: 35.h,
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        "Sign Up with Google",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Choose an account",
                      style: TextStyle(fontSize: 36.sp, color: Colors.black),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "to continue to ",
                          style: TextStyle(fontSize: 20.sp, color: Colors.black),
                        ),
                        Text(
                          'Go Green ',
                          style: TextStyle(
                            color: const Color(0xFF147351),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 0.w),
                        Image.asset(
                          'images/img_17.png',
                          width: 35.w,
                          height: 35.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text("R", style: TextStyle(color: Colors.white)),
                  ),
                  title: Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "username158@gmail.com",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40.w,
                  ),
                  title: Text(
                    "Use another account",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
