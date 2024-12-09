import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Home_event.dart';
import 'package:gogreen/Home_treee.dart';
import 'package:gogreen/Homepage.dart';
import 'package:gogreen/selection_provider.dart';

class TreeplantingGuide extends StatefulWidget {
  @override
  _TreeplantingGuideState createState() => _TreeplantingGuideState();
}

class _TreeplantingGuideState extends State<TreeplantingGuide> {
  int _selectedIndex = 0;
  bool _isNotificationPressed = false;
  bool isCareSelected = false;
  bool isTreePlantingSelected = true;
  bool isCharitySelected = false;
  bool isEventsSelected = false;
  bool isTreeNurserySelected =false;

  final List<Map<String, String>> gridItems = [
    {
      'image': 'images/img_2.png',
      'title': 'How Choose Suitable Tree?',
      'description': 'Details on selecting a type of tree suitable for the local climate and soil.',
    },
    {
      'image': 'images/img_4.png',
      'title': 'Tree Benefits',
      'description': 'Learn about the environmental and health benefits of planting trees.',
    },
    {
      'image': 'images/img_6.png',
      'title': 'What Are the Essential Needs of Tree for Healthy Growth?',
      'description': 'Tips on watering, fertilizing, and protecting trees from pests.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
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
              SizedBox(height: 17.h),
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
                      buildSmallContainer(
                        imagePath: 'images/img_1.png',
                        text: 'Tree Planting Guide',
                        isSelected: isTreePlantingSelected,
                        onTap: () {
                          setState(() {
                            isTreePlantingSelected = true;
                            isCareSelected = false;
                            isCharitySelected = false;
                            isEventsSelected = false;
                          });

                        },
                      ),

                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeEvent()),
                          );
                        },
                        child: buildSmallContainerWithSelected('images/img_33.png', 'Event', isEventsSelected),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeTreee()),
                          );
                        },
                        child: buildSmallContainerWithSelected('images/img_8.png', 'Tree Nursery', isTreeNurserySelected),
                      ),
                      SizedBox(width: 2.w),
                      buildSmallContainer(
                        imagePath: 'images/img_20.png',
                        text: 'Care',
                        isSelected: isCareSelected,
                        onTap: () {
                          setState(() {
                            isTreePlantingSelected = false;
                            isTreeNurserySelected=false;
                            isCareSelected = true;
                            isCharitySelected = false;
                            isEventsSelected = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                height: 470.h,
                width: 376.w,
                decoration: BoxDecoration(
                  color: Color(0xFFEBF3F1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 25.h,
                      crossAxisSpacing: 20.w,
                      childAspectRatio: 0.5,
                    ),
                    itemCount: gridItems.length,
                    itemBuilder: (context, index) {
                      return buildSmallContainerWithTitleDescriptionAndImage(
                        gridItems[index]['image']!,
                        gridItems[index]['title']!,
                        gridItems[index]['description']!,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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


  }


Widget buildSmallContainer({
  required String imagePath,
  required String text,
  required bool isSelected,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF147351) : Color(0xFFEBF3F1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF147351),
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5.w),
          Image.asset(imagePath, width: 30.w, height: 30.h),
        ],
      ),
    ),
  );
}

Widget buildSmallContainerWithTitleDescriptionAndImage(String imagePath, String title, String description) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, width: 100.w, height: 100.h),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}


Widget buildSmallContainerWithSelected(String imagePath, String text, bool isSelected) {
  return Container(
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      color: isSelected ? Color(0xFF147351) : Color(0xFFEBF3F1),
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 4,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Color(0xFF147351),
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5.w),
        Image.asset(imagePath, width: 30.w, height: 30.h),
      ],
    ),
  );
}
