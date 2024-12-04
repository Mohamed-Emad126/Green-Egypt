  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  class TreePlantingGuide extends StatefulWidget {
    @override
    _TreePlantingGuideState createState() => _TreePlantingGuideState();
  }

  class _TreePlantingGuideState extends State<TreePlantingGuide> {
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
              SizedBox(height: 30.h),
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
              SizedBox(height: 10.h),
              Center(
                child: Container(
                  width: 300.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFEBF3F1),
                    borderRadius: BorderRadius.circular(10.r),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCarePressed = !_isCarePressed;
                          });
                        },
                        child: buildSmallContainerWithSelected('images/img_31.png', 'Care', _isCarePressed),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 10.w),
                height: 450.h,
                width: 380.w,
                decoration: BoxDecoration(
                  color: Color(0xFFEBF3F1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 25.h,
                        crossAxisSpacing: 20.w,
                        childAspectRatio: 0.5,
                      ),
                      itemCount: 6,  // زيادة العدد إلى 6 بسبب إضافة العنصر الجديد
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return buildSmallContainerWithTitleDescriptionAndImage(
                            'images/img_2.png',
                            'How Choose Suitable Tree?',
                            'details on selecting type of tree suitable for the local climate and soil..',
                          );
                        } else if (index == 1) {
                          return buildSmallContainerWithTitleDescriptionAndImage(
                            'images/img_4.png',
                            'Tree Benefits',
                            'Learn about the environmental and health benefits of planting trees.',
                          );
                        } else if (index == 2) {
                          return buildSmallContainerWithTitleDescriptionAndImage(
                            'images/img_6.png',
                            'What Are the Essential Needs of Tree for Healthy Growth?',
                            'tips on watering, fertilizing, and protecting trees from pests.',
                          );
                        } else if (index == 3) {
                          return buildSmallContainerWithTitleDescriptionAndImage(
                            'images/img_6.png',
                            'What Are the Essential Needs of Tree for Healthy Growth?',
                            'tips on watering, fertilizing, and protecting trees from pests.',
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(child: Text('Item $index')),
                          );
                        }
                      },
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
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
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

    Widget buildSmallContainer(String imagePath, String text, bool isSelected, Function onTapAction) {
      return GestureDetector(
        onTap: () => onTapAction(),
        child: Container(
          padding: EdgeInsets.all(8.w),
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

    Widget buildSmallContainerWithTitleDescriptionAndImage(String imagePath, String title, String description) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, width: 100.w, height: 100.h),
            SizedBox(height: 10.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:Color(0xFF147351),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }
  }
