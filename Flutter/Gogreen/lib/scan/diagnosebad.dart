import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagnoseBad extends StatelessWidget {
  final String? imagePath;

  const DiagnoseBad({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
    );

    return Scaffold(
      body: Container(
        width: 390.w,
        height: 844.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFE5F5EF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r),
          ),
        ),
        child: Stack(
          children: [
            // Status bar
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 390.w,
                height: 44.h,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 21.w,
                      top: 12.h,
                      child: Container(
                        width: 54.w,
                        height: 21.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                        ),
                        child: const Stack(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Small image
            Positioned(
              left: 10.w,
              top: 155.h,
              child: Container(
                width: 129.w,
                height: 170.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('images/img_68.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Title text with close 'X' icon
            Positioned(
              left: 17.w,
              top: 65.h,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/VerificationTree');
                    },
                    child: Container(
                      width: 47.w,
                      height: 47.h,
                      child: Icon(
                        Icons.close,
                        color: const Color(0xFF003C26),
                        size: 30.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Text(
                    'Diagnose identification',
                    style: TextStyle(
                      color: const Color(0xFF003C26),
                      fontSize: 22.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Placeholder stack
            Positioned(
              left: 17.w,
              top: 54.h,
              child: Container(
                width: 47.w,
                height: 47.h,
                child: const Stack(),
              ),
            ),
            // Main image with text and button
            Positioned(
              left: 69.w,
              top: 249.h,
              child: Container(
                width: 253.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 211.w,
                            height: 258.h,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: imagePath != null
                                    ? FileImage(File(imagePath!))
                                    : const AssetImage('assets/large_image.png'),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 350.w,
                                child: Text(
                                  'The tree is not in good Health',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 290.w,
                                child: Text(
                                  'Rust disease',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFFD51619),
                                    fontSize: 24.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      width: 200.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/VerificationTree');
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF147351),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Ok',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontFamily: '18 Khebrat Musamim',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/scanPage');
                            },
                            child: Text(
                              'Scan another Image',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF444444),
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}