import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Community/CommunityPage.dart';
import 'package:gogreen/Homepage.dart';
import 'package:gogreen/Profile/ProfilePage.dart';
import 'package:gogreen/RwardsPage.dart';
import 'package:gogreen/scan/Scan_Page.dart';

class BottomNavBarExample extends StatefulWidget {
  const BottomNavBarExample({Key? key}) : super(key: key);

  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Homepage(),
     CommunityPostScreen(),
     RewardsScreen(),
     ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
    );

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF147351),
            unselectedItemColor: Colors.black,
            currentIndex: _selectedIndex > 2 ? 3 : _selectedIndex,
            onTap: (index) {
              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanPage(),
                  ),
                );
                return;
              }
              _onItemTapped(index > 2 ? index - 1 : index);
            },
            items: [
              BottomNavigationBarItem(
                icon: _NavIcon('images/img_35.png', _selectedIndex == 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _NavIcon('images/img_25.png', _selectedIndex == 1),
                label: 'Community',
              ),
              const BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _NavIcon('images/img_26.png', _selectedIndex == 2),
                label: 'Rewards',
              ),
              BottomNavigationBarItem(
                icon: _NavIcon('images/img_27.png', _selectedIndex == 3),
                label: 'Profile',
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 30.w,
            bottom: 25.h,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanPage(),
                  ),
                );
              },
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF147351),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'images/img_23.png',
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
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

class _NavIcon extends StatelessWidget {
  final String path;
  final bool isSelected;

  const _NavIcon(this.path, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isSelected ? const Color(0xFF147351) : Colors.black,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        path,
        width: 24.w,
        height: 24.h,
        cacheWidth: 24,
        cacheHeight: 24,
      ),
    );
  }
}