import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/TreeplantingGuide.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  bool _isNotificationPressed = false;
  bool _isCarePressed = false;
  bool isTreePlantingSelected = false;
  bool isCharitySelected = false;
  bool isEventsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/img_11.png',
                        color: Color(0xFF147351),
                        width: 40.w,
                        height: 40.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Go Green',
                        style: TextStyle(
                          fontSize: 24.sp,
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
                        child: Image.asset(
                          'images/img_28.png',
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Image.asset(
                        'images/img_29.png',
                        width: 31.w,
                        height: 31.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Container(
                width: 300.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Color(0xFFEBF3F1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.01),
                    width: 1.w,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Image.asset(
                      'images/img_30.png',
                      width: 40.w,
                      height: 40.h,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      '25 points',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildSmallContainer('images/img_1.png', 'Tree Planting Guide', isTreePlantingSelected, () {
                      setState(() {
                        isTreePlantingSelected = !isTreePlantingSelected;
                        isCharitySelected = false;
                        isEventsSelected = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TreePlantingGuide()),  // انتقل إلى صفحة TreeplantingGuide
                      );
                    }),
                    SizedBox(width: 2.w),
                    buildSmallContainer('images/img_32.png', 'Charity', isCharitySelected, () {
                      setState(() {
                        isCharitySelected = !isCharitySelected;
                        isTreePlantingSelected = false;
                        isEventsSelected = false;
                      });
                    }),
                    SizedBox(width: 2.w),
                    buildSmallContainer('images/img_33.png', 'Events', isEventsSelected, () {
                      setState(() {
                        isEventsSelected = !isEventsSelected;
                        isTreePlantingSelected = false;
                        isCharitySelected = false;
                      });
                    }),
                    SizedBox(width: 2.w),
                    buildSmallContainerWithSelected('images/img_31.png', 'Care', _isCarePressed, () {
                      setState(() {
                        _isCarePressed = !_isCarePressed;
                        isTreePlantingSelected = false;
                        isCharitySelected = false;
                        isEventsSelected = false;
                      });
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 15.w, right: 10.w),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFEBF3F1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/img_34.png',
                        width: 200.w,
                        height: 200.h,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Add your first plant!',
                        style: TextStyle(
                          color: Color(0xFF013D26),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'Visit the Community page to find plants that need care. Start helping today, Earn points, And make a positive impact with your Charity!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF013D26),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                width: 24.w,
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
                width: 24.w,
              ),
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 70.w,
              height: 70.h,
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
                  width: 80.w,
                  height: 80.h,
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
                width: 24.w,
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
                width: 24.w,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildSmallContainer(String imagePath, String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 2.w),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF147351) : Color(0xFFEBF3F1),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? Color(0xFF147351) : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicWidth(
              child: Image.asset(
                imagePath,
                width: 40.w,
                height: 40.h,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF013D26),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSmallContainerWithSelected(String imagePath, String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 2.w),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF147351) : Color(0xFFEBF3F1),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? Color(0xFF147351) : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicWidth(
              child: Image.asset(
                imagePath,
                width: 40.w,
                height: 40.h,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF013D26),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
