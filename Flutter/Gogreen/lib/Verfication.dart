import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/ValidVerfication.dart';

class Verfication extends StatelessWidget {
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
            top: MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'images/img_11.png',
                width: 150.w,
                height: 150.h,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.w),
                  topRight: Radius.circular(40.w),
                ),
                border: Border.all(color: Color(0xFF147351), width: 3.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.chevron_left, size: 55.w, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Get your Code",
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF013D26),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "         Please enter the code that was \nsent to your email ",
                            style: TextStyle(fontSize: 17.sp, color: Colors.black),
                          ),
                          TextSpan(
                            text: "example@gmail.com",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xFF147351),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCodeField(),
                        _buildCodeField(),
                        _buildCodeField(),
                        _buildCodeField(),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ValidVerification()),
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
                        "Confirm Code",
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    RichText(
                      text: TextSpan(
                        text: "If you didn't receive ",
                        style: TextStyle(color: Colors.black, fontSize: 17.sp),
                        children: [
                          TextSpan(
                            text: "resend code",
                            style: TextStyle(
                              color: Color(0xFF147351),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
