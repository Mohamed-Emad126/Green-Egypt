import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Homepage.dart';
import 'package:gogreen/selection_provider.dart';

class PlantingLocation extends StatefulWidget {
  @override
  _PlantingLocationState createState() => _PlantingLocationState();
}

class _PlantingLocationState extends State<PlantingLocation> {
  int _selectedIndex = 0;
  bool _isNotificationPressed = false;
  bool isCareSelected = false;
  bool isTreePlantingSelected = false;
  bool isCharitySelected = false;
  bool isEventsSelected = false;
  bool PlantingLocationSelected = true;


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
                      buildSmallContainer(
                        imagePath: 'images/img_1.png',
                        text: 'Planting Location',
                        isSelected: PlantingLocationSelected,
                        onTap: () {
                          setState(() {
                            PlantingLocationSelected=true;

                            isTreePlantingSelected = false;
                            isCareSelected = false;
                            isCharitySelected = false;
                            isEventsSelected = false;
                          });

                        },
                      ),
                      SizedBox(width: 2.w),
                      buildSmallContainer(
                        imagePath: 'images/img_32.png',
                        text: 'Charity',
                        isSelected: isCharitySelected,
                        onTap: () {
                          setState(() {
                            isCharitySelected = true;
                            isTreePlantingSelected = false;
                            isCareSelected = false;
                            isEventsSelected = false;
                          });
                        },
                      ),
                      SizedBox(width: 2.w),
                      buildSmallContainer(
                        imagePath: 'images/img_33.png',
                        text: 'Events',
                        isSelected: isEventsSelected,
                        onTap: () {
                          setState(() {
                            isEventsSelected = true;
                            isTreePlantingSelected = false;
                            isCharitySelected = false;
                          });
                        },
                      ),

                      SizedBox(width: 2.w),
                      buildSmallContainer(
                        imagePath: 'images/img_1.png',
                        text: 'Care',
                        isSelected: isTreePlantingSelected,
                        onTap: () {
                          setState(() {
                            isTreePlantingSelected = false;
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
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 430.h,
                    width: 376.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBF3F1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                      ),
                      child: Image.asset(
                        'images/img_37.png',
                        fit: BoxFit.cover,
                        height: 420.h,
                        width: 376.w,
                      ),
                    ),
                  ),

                ],
              )




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
