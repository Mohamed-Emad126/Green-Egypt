import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Loginpage.dart';
import 'package:gogreen/Registerpage.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

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
      backgroundColor: const Color(0xFF147351),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Padding(
                padding: EdgeInsets.all(5.0.w),
                child: SizedBox(
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
              // ElevatedButton (Create Account)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0f6043), // لون الخلفية
                  foregroundColor: Colors.white, // لون النص
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r), // جعل الزر زاويته دائرية
                    side: BorderSide(
                      color: const Color(0xFF013D26),
                      width: 1.5.w, // عرض الحد
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h), // المسافة داخل الزر
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              // InkWell (Login)
              ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF147351), // لون الخلفية
    foregroundColor: Colors.white, // لون النص
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.r), // جعل الزر زاويته دائرية
      side: BorderSide(
        color: const Color(0xFF013D26),
        width: 1.w, // عرض الحد
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 75.w, vertical: 10.h), // المسافة داخل الزر
    shadowColor: Colors.black.withOpacity(0.3), // تأثير الظل
    elevation: 5.w, // قوة الظل
  ),
  child: Text(
    'Login',
    style: TextStyle(
      fontSize: 25.sp,
      fontWeight: FontWeight.bold,
    ),
  ),
)

            ],
          ),
        ),
      ),
    );
  }
}
