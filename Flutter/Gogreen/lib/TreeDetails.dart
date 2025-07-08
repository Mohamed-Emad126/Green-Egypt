import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TreeDetails extends StatelessWidget {
  const TreeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
    );

    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: 390.w,
          // Removed fixed height to allow scrolling
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status bar
              Container(
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
              // Header with back button and title
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: 30.sp,
                        color: const Color(0xFF003C26),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Tree Details',
                      style: TextStyle(
                        color: const Color(0xFF003C26),
                        fontSize: 24.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Main image
              Container(
                width: 390.w,
                height: 252.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("images/img_65.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // Details section
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Added
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 338.w,
                          child: Text(
                            'Date Added',
                            style: TextStyle(
                              color: const Color(0xFF003C26),
                              fontSize: 28.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: 338.w,
                          child: Text(
                            '13/5/2025',
                            style: TextStyle(
                              color: const Color(0xFF247D5E),
                              fontSize: 22.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Tree Location
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 338.w,
                          child: Text(
                            'Tree Location',
                            style: TextStyle(
                              color: const Color(0xFF003C26),
                              fontSize: 28.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: 252.w,
                          child: Text(
                            'Al-Rawda Street, Zagazig',
                            style: TextStyle(
                              color: const Color(0xFF247D5E),
                              fontSize: 22.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Tree Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 338.w,
                          child: Text(
                            'Tree Status',
                            style: TextStyle(
                              color: const Color(0xFF003C26),
                              fontSize: 28.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: 338.w,
                          child: Text(
                            'Needs care',
                            style: TextStyle(
                              color: const Color(0xFF247D5E),
                              fontSize: 22.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Report Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 338.w,
                          child: Text(
                            'Report Status',
                            style: TextStyle(
                              color: const Color(0xFF003C26),
                              fontSize: 28.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: 338.w,
                          child: Text(
                            'Solved',
                            style: TextStyle(
                              color: const Color(0xFF247D5E),
                              fontSize: 22.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Resolved Tree Images
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 338.w,
                          child: Text(
                            'Resolved Tree Images',
                            style: TextStyle(
                              color: const Color(0xFF003C26),
                              fontSize: 28.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 123.w,
                              height: 115.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: Container(
                                width: 123.w,
                                height: 115.h,
                                decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage("images/img_65.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              width: 123.w,
                              height: 115.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                              child: Container(
                                width: 123.w,
                                height: 115.h,
                                decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage("images/img_65.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
              // Bottom bar
              Center(
                child: Container(
                  width: 151.w,
                  height: 6.h,
                  margin: EdgeInsets.only(bottom: 14.h),
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
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