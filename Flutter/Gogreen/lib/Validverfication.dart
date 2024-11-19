import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Homepage.dart';

class ValidVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Color(0xFF147351),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 15.w,
            right: 15.w,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.62,
              decoration: BoxDecoration(
                color: Color(0xFFEBF3F1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.w),
                  topRight: Radius.circular(40.w),
                  bottomLeft: Radius.circular(40.w),
                  bottomRight: Radius.circular(40.w),
                ),
                border: Border.all(color: Color(0xFF147351), width: 3.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "Email Verified Successfully",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF013D26),
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'images/img_19.png',
                              width: 140.w,
                              height: 140.h,
                            ),
                            Image.asset(
                              'images/img_18.png',
                              width: 180.w,
                              height: 180.h,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Homepage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 60.w),
                            backgroundColor: Color(0xFF147351),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.w),
                            ),
                          ),
                          child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeField() {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Color(0xFFEBF3F1),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, color: Colors.black),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            hintText: "–",
            hintStyle: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
