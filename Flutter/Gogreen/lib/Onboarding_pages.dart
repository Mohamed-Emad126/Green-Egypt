import 'package:flutter/material.dart';
import 'package:gogreen/profile/Registerpage.dart';
import 'package:gogreen/Splashscreen.dart';
import 'package:provider/provider.dart';
import 'provider/onboarding_state.dart';

class OnboardingPages extends StatelessWidget {
  final PageController _controller = PageController();

  OnboardingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<OnboardingState>(
        builder: (context, onboardingState, child) {
          return Column(
            children: [
              const SizedBox(height: 80),
              SizedBox(
                height: 420,
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
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 10,
                    width: onboardingState.currentPage == index ? 20 : 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: onboardingState.currentPage == index ? Colors.green[800] : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (onboardingState.currentPage == 3) {
                    Navigator.push(
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  onboardingState.currentPage == 3 ? 'Get Started' : 'Next',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  RegisterPage()),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 150),
            ],
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
          height: 323,
          width: 321,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
