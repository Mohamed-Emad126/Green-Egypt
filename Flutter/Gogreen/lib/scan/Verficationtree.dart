import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationTree extends StatelessWidget {
  final String? imagePath;

  const VerificationTree({Key? key, this.imagePath}) : super(key: key);

  // Placeholder function لتحليل الصورة (هنستبدلها بالـ API لما يجهز)
  Future<String> _diagnoseTree(String? imagePath, BuildContext context) async {
    // لو مفيش صورة أو الصورة مش موجودة، يعتبرها غير واضحة
    if (imagePath == null || !File(imagePath).existsSync()) {
      return '/DiagnoseGood0'; // صورة غير واضحة
    }

    // هنا المفروض ندعو الـ API لتحليل الصورة
    // مثال مؤقت: نفترض إن الصورة سليمة أو مريضة بناءً على شرط عشوائي
    // استبدل المنطق ده بالـ API response
    bool isHealthy = DateTime.now().second % 2 == 0; // مثال عشوائي
    bool isClear = DateTime.now().second % 3 != 0; // مثال عشوائي للتحقق من الوضوح

    if (!isClear) {
      return '/DiagnoseGood0'; // صورة غير واضحة
    } else if (isHealthy) {
      return '/DiagnoseGood'; // شجرة سليمة
    } else {
      return '/DiagnoseBad'; // شجرة مريضة
    }
  }

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
            // Close 'X' icon
            Positioned(
              left: 17.w,
              top: 65.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
            ),
            // Main image
            Positioned(
              left: 64.w,
              top: 148.h,
              child: Container(
                width: 263.w,
                height: 322.h,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: imagePath != null
                        ? FileImage(File(imagePath!))
                        : const AssetImage("images/img_verification_tree.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
            // Dark overlay
            Positioned(
              left: 64.90.w,
              top: 148.h,
              child: Opacity(
                opacity: 0.50,
                child: Container(
                  width: 262.10.w,
                  height: 322.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ),
            // Circular gradient button
            Positioned(
              left: 148.w,
              top: 260.h,
              child: Container(
                width: 94.w,
                height: 94.h,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.50, 0.15),
                    end: Alignment(0.19, 0.68),
                    colors: [Color(0xFF147351), Color(0xFFD9D9D9)],
                  ),
                  shape: const OvalBorder(),
                ),
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
            // Action buttons
            Positioned(
              left: 63.5.w, // Centered to match design
              top: 503.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // تشخيص الصورة وتحديد الصفحة المناسبة
                      final result = await _diagnoseTree(imagePath, context);
                      Navigator.pushNamed(context, result, arguments: imagePath);
                    },
                    child: Container(
                      width: 263.w,
                      height: 60.h, // Fixed height for consistency
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF147351),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Diagnose Tree',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: '18 Khebrat Musamim',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/createPost');
                    },
                    child: Container(
                      width: 263.w,
                      height: 60.h, // Fixed height for consistency
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF147351),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Post In Community',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: '18 Khebrat Musamim',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/VerificationTree');
                    },
                    child: Container(
                      width: 263.w,
                      height: 60.h, // Fixed height for consistency
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF147351),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Add a new Tree',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: '18 Khebrat Musamim',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}