import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/password/Verficationcode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  // Validate email format
  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
    );
    return emailRegex.hasMatch(email);
  }

  // Send reset request to API
  Future<void> _sendResetRequest(String email) async {
    final url = Uri.parse('https://your-api-domain.com/api/auth/forgotPassword');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verficationcode(verificationCode: ''),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Failed to send reset link. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  // Handle form submission
  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();

      if (!_isValidEmail(email)) {
        setState(() {
          _errorMessage = 'Please enter a valid Gmail address';
        });
        return;
      }

      _sendResetRequest(email);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFF147351),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'images/img_11.png',
                width: 120.w,
                height: 120.h,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
                border: Border.all(color: const Color(0xFF147351), width: 3),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.chevron_left, size: 45.w, color: const Color(0xFF013D26)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Forget Password",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF013D26),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Please enter the email address associated\nwith your account.",
                              style: TextStyle(fontSize: 16.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3F1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10.w),
                            Image.asset(
                              'images/img_14.png',
                              width: 18.w,
                              height: 18.h,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email address',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF147351),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_errorMessage != null) ...[
                        SizedBox(height: 10.h),
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        ),
                      ],
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: _handleSubmit,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
}