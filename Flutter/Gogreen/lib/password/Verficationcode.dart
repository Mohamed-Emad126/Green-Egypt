import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/password/Validverfication.dart';

class Verficationcode extends StatefulWidget {
  final String verificationCode;

  const Verficationcode({super.key, required this.verificationCode});

  @override
  _VerficationState createState() => _VerficationState();
}

class _VerficationState extends State<Verficationcode> {
  final List<TextEditingController> _codeControllers = List.generate(4, (_) => TextEditingController());
  String? _errorMessage;

  void _verifyCode() {
    String enteredCode = _codeControllers.map((controller) => controller.text).join();
    if (enteredCode == widget.verificationCode) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ValidVerification()),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid code. Please try again.';
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      backgroundColor: Colors.black,
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
                border: Border.all(color: const Color(0xFF147351), width: 3.w),
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
                        color: const Color(0xFF013D26),
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
                              color: const Color(0xFF147351),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) => _buildCodeField(_codeControllers[index])),
                    ),
                    if (_errorMessage != null) ...[
                      SizedBox(height: 10.h),
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    ],
                    SizedBox(height: 30.h),
                    ElevatedButton(
                      onPressed: _verifyCode,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 60.w),
                        backgroundColor: const Color(0xFF147351),
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
                        children: const [
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

  Widget _buildCodeField(TextEditingController controller) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3F1),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, color: Colors.black),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
            hintText: "–",
            hintStyle: TextStyle(color: Colors.green),
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}