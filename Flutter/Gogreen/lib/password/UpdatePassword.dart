import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/password/Verficationcode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  // Send update request to API (you will need to customize this endpoint and body)
  Future<void> _sendUpdateRequest(String oldPassword) async {
    final url = Uri.parse('https://your-api-domain.com/api/auth/updatePassword');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'oldPassword': oldPassword}),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verficationcode(verificationCode: ''), // Or another screen
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Failed to update password. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      String oldPassword = _oldPasswordController.text.trim();
      _sendUpdateRequest(oldPassword);
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
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
                        "Update Password",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF013D26),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Please enter your current password to continue.",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3F1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w),
                            Icon(Icons.lock, color: const Color(0xFF147351), size: 20.w),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: TextFormField(
                                controller: _oldPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Old Password',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF147351),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your current password';
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
