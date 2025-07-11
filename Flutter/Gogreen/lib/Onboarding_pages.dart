import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/profile/Registerpage.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:provider/provider.dart';
import 'provider/onboarding_state.dart';

class OnboardingPages extends StatelessWidget {
  final PageController _controller = PageController();

  OnboardingPages({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<OnboardingState>(
        builder: (context, onboardingState, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Expanded( // استخدام Expanded عشان الـ PageView ياخد المساحة المتاحة
                  child: SizedBox(
                    height: 420.h, // ارتفاع ثابت نسبي
                    width: double.infinity,
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (int page) {
                        onboardingState.setPage(page);
                      },
                      children: [
                        _buildPage('images/img.png', 'Join us in making Egypt greener!'),
                        _buildPage('images/img_3.png', 'Learn how to plant and care for trees'),
                        _buildPage('images/img_5.png', 'Mark trees that need care or join community events.'),
                        _buildPage('images/img_7.png', 'Earn points and join challenges to promote greening'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 10.h,
                      width: onboardingState.currentPage == index ? 20.w : 10.w,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: onboardingState.currentPage == index ? Colors.green[800] : Colors.grey,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    if (onboardingState.currentPage == 3) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  RegisterPage()),
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
                  ),
                  child: Text(
                    onboardingState.currentPage == 3 ? 'Get Started' : 'Next',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  RegisterPage()),
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPage(String imagePath, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 323.h,
          width: 321.w,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 18.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OnboardingState with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setPage(int page) {
    if (_currentPage != page) {
      _currentPage = page;
      notifyListeners();
    }
  }

  void reset() {
    _currentPage = 0;
    notifyListeners();
  }
}