import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/profile/Loginpage.dart';
import 'package:provider/provider.dart';
import 'package:gogreen/provider/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            color: Color(0xFF147351),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/img_11.png',
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Create your new account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildIconContainer('images/img_13.png', 'Full Name', Provider.of<AuthProvider>(context, listen: false).usernameController),
                      SizedBox(height: 20.h),
                      _buildIconContainer('images/img_14.png', 'Email Address', Provider.of<AuthProvider>(context, listen: false).emailController, isEmail: true),
                      SizedBox(height: 20.h),
                      _buildIconContainer(
                        'images/img_12.png',
                        'Password',
                        Provider.of<AuthProvider>(context, listen: false).passwordController,
                        isPassword: true,
                        obscureText: _obscurePassword,
                        toggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      SizedBox(height: 20.h),
                      _buildIconContainer(
                        'images/img_12.png',
                        'Confirm Password',
                        Provider.of<AuthProvider>(context, listen: false).passwordConfirmationController,
                        isPassword: true,
                        obscureText: _obscureConfirmPassword,
                        toggleObscure: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                      SizedBox(height: 10.h),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) => authProvider.isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF147351),
                            padding: EdgeInsets.symmetric(horizontal: 90.w, vertical: 13.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authProvider.signUp(context);
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEAF3F0),
                          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 13.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          side: BorderSide(color: const Color(0xFF147351)),
                        ),
                        onPressed: () {
                          // إضافة وظيفة تسجيل الدخول باستخدام جوجل هنا
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'images/img_15.png',
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Sign Up with Google',
                              style: TextStyle(
                                color: Color(0xFF147351),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildLoginRedirect(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconContainer(
      String imagePath,
      String label,
      TextEditingController controller, {
        bool isPassword = false,
        bool obscureText = false,
        VoidCallback? toggleObscure,
        bool isEmail = false,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3F0),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 20.w, height: 20.h, fit: BoxFit.cover),
          SizedBox(width: 15.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
                suffixIcon: isPassword
                    ? IconButton(
                  icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: toggleObscure,
                )
                    : null,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "$label is required";
                }
                if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return "Enter a valid email";
                }
                if (isPassword && value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginRedirect(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
        ),
        GestureDetector(
          onTap: () {
            // الانتقال مباشرة إلى صفحة LoginPage باستخدام Navigator.push
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text(
            'Sign in',
            style: TextStyle(
              color: const Color(0xFF147351),
              fontSize: 16, // استخدم الحجم المناسب للخط
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
