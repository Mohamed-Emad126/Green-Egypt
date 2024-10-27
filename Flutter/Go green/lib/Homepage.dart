import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  bool _isNotificationPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Color(0xFF147351),
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          'images/img_11.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Go Green',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF147351),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isNotificationPressed = !_isNotificationPressed;
                          });
                        },
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            _isNotificationPressed ? Color(0xFF147351) : Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'images/img_28.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          'images/img_29.png',
                          width: 38,
                          height: 38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFEBF3F1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black.withOpacity(0.01),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You have',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    'images/img_30.png',
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '25 points',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSmallContainer('images/img_31.png', 'Care'),
                  buildSmallContainer('images/img_32.png', 'Charity'),
                  buildSmallContainer('images/img_33.png', 'Events'),
                ],
              ),
            ),

            SizedBox(height: 10),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              height: 400,
              width: 380,
              decoration: BoxDecoration(
                color: Color(0xFFEBF3F1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 0),
                  Image.asset(
                    'images/img_34.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add your first plant!',
                    style: TextStyle(
                      color: Color(0xFF013D26),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Visit the Community page to find plants that need care. Start helping today, Earn points, And make a positive impact with your Charity!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF013D26),
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF147351),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? Color(0xFF147351) : Colors.black,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'images/img_35.png',
                width: 24,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? Color(0xFF147351) : Colors.black,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'images/img_25.png',
                width: 24,
              ),
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF147351).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'images/img_23.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? Color(0xFF147351) : Colors.black,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'images/img_26.png',
                width: 24,
              ),
            ),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 4 ? Color(0xFF147351) : Colors.black,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'images/img_27.png',
                width: 24,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildSmallContainer(String imagePath, String text) {
    return Container(
      width: 120,
      height: 50,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Color(0xFFEBF3F1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF147351),
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}
