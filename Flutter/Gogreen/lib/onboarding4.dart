import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:gogreen/Splashscreen.dart';
import 'onboarding_state.dart';

class Onboarding4 extends StatefulWidget {
  @override
  _Onboarding4State createState() => _Onboarding4State();
}

class _Onboarding4State extends State<Onboarding4> {
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    Provider.of<Onboarding_State>(context, listen: false).updateCurrentPage(index);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(412, 892), minTextAdapt: true);

    final onboardingState = Provider.of<Onboarding_State>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.green[900],
            size: 55.w,
          ),
          onPressed: () {
            onboardingState.updateCurrentPage(2);
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.all(5.0.w),
                child: Container(
                  width: 193.w,
                  height: 247.h,
                  child: Image.asset(
                    'images/img_7.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Earn points and join challenges to',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF147351),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'promote greening',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF147351),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0.w),
                child: Container(
                  width: 100.w,
                  height: 100.h,
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: onboardingState.currentIndex == index
                          ? Colors.green[800]
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 4,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    return Center();
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  if (onboardingState.currentIndex < 3) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Splashscreen()),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 192.h),
            ],
          ),
        ),
      ),
    );
  }
}
