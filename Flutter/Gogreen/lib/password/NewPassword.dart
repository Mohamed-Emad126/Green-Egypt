import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/password/Verficationcode.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Verficationcode(verificationCode: ''),
        ),
      );
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "New Password",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF013D26),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Please enter your new password below.",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30.h),

                      // Password field
                      _buildPasswordField("New Password", _newPasswordController),

                      SizedBox(height: 20.h),

                      // Confirm password field
                      _buildPasswordField("Confirm Password", _confirmPasswordController, isConfirmation: true),

                      if (_errorMessage != null) ...[
                        SizedBox(height: 10.h),
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        ),
                      ],
                      SizedBox(height: 30.h),

                      // Confirm button
                      InkWell(
                        onTap: _handleSubmit,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Text(
                            'Confirm',
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

  Widget _buildPasswordField(String hint, TextEditingController controller, {bool isConfirmation = false}) {
    return Container(
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
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: const Color(0xFF147351),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (isConfirmation && value != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
