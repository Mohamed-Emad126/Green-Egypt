import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/NavigationBar.dart';
import 'package:gogreen/Signingoogle.dart';
import 'package:gogreen/Forgetpasword.dart';
import 'package:gogreen/Homepage.dart';
import 'package:gogreen/Registerpage.dart';
import 'package:gogreen/main.dart';
import 'package:gogreen/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 0.35.sh,
            color: const Color(0xFF147351),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/img_11.png',
                        width: 80.w,
                        height: 80.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Login to your account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 20.w,
                  child: IconButton(
                    icon: Icon(Icons.chevron_left_outlined,
                        color: Colors.white, size: 40.w),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.h, right: 16.w),
                    child: Image.asset(
                      'images/img_10.png',
                      width: 180.w,
                      height: 180.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  _buildIconTextField(
                      'images/img_14.png', 'Email Address', emailController),
                  SizedBox(height: 20.h),
                  _buildPasswordContainer(),
                  const SizedBox(height: 0),
                  _buildRememberMeCheckbox(),
                  SizedBox(height: 60.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  BottomNavBarExample()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 90.w, vertical: 13.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF147351),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEAF3F0),
                          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 13.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          side: BorderSide(color: const Color(0xFF147351)),
                          shadowColor: Colors.black.withOpacity(0.2),
                          elevation: 1,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signingoogle()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'images/img_15.png',
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                color: const Color(0xFF147351),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text(
                          'Sign Up ',
                          style: TextStyle(
                            color: const Color(0xFF147351),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 90.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIconTextField('images/img_12.png', 'Password', passwordController,
            isPassword: true),
        SizedBox(height: 5.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgetPassword()),
              );
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  color: const Color(0xFF147351),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });
          },
          child: Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isChecked ? const Color(0xFF147351) : Colors.transparent,
              border: Border.all(
                color: const Color(0xFF147351),
                width: 2.w,
              ),
            ),
            child: _isChecked
                ? Icon(
              Icons.check,
              color: Colors.white,
              size: 8.w,
            )
                : const SizedBox.shrink(),
          ),
        ),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _isChecked = !_isChecked;
            });
          },
          child: Text(
            'Remember Me',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconTextField(
      String imagePath, String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3F0),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 20.w,
            height: 20.h,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
