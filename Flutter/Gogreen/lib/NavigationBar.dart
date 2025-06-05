import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gogreen/CommunityPage.dart';
import 'package:gogreen/Homepage.dart';
import 'package:gogreen/Profile/ProfilePage.dart';
import 'package:gogreen/RwardsPage.dart';

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    CommunityPostScreen(),
    RewardsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print('Image path: ${pickedFile.path}');
      // هنا ممكن تعرض الصورة في Dialog أو تبعتها لأي صفحة حسب ما تحب
    } else {
      print('لم يتم اختيار صورة');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              if (index == 2) return; // تجاهل الضغط على الزر الأوسط
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

          // الزر الأوسط (كاميرا)
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 30,
            bottom: 25,
            child: GestureDetector(
              onTap: _openCamera,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    width: 40,
                    height: 40,
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
        width: 24,
        height: 24,
        cacheWidth: 24,
        cacheHeight: 24,
      ),
    );
  }
}
