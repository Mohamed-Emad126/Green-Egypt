import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Community.dart';

bool showNurseryContent = false;



class Homepage extends StatefulWidget {
  const Homepage({super.key});


  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage()));
    }

     else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }


  late List<bool> _isSelected;
  late int _currentIndex;
  int _currentPage = 0;
  bool _isNotificationPressed = false;
  bool isTreePlantingSelected = false;
  bool isCareSelected = false;
  bool isTreeNurserySelected = false;

  bool isEventsSelected = false;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(5, (_) => false);
    _currentIndex = 0;
    _isSelected[_currentIndex] = true;
  }
  void _onIconTap(int index) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = true;
      _currentIndex = index;
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                      color: const Color(0xFF147351),
                      width: 40.w,
                      height: 40.h,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Go Green',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF147351),
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
                color: const Color(0xFFEBF3F1),
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
          SizedBox(height: 20.h),
  Padding( padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _currentPage = 0;
            });
            _pageController.jumpToPage(0);
          },
          child: buildSmallContainerWithSelected(
            'images/img_1.png',
            'The planting guide',
            _currentPage == 0,
          ),
        ),
        SizedBox(width: 10.w),

        GestureDetector(
          onTap: () {
            setState(() {
              _currentPage = 2;
            });
            _pageController.jumpToPage(2);
          },
          child: buildSmallContainerWithSelected(
            'images/img_20.png',
            'Care',
            _currentPage == 2,
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentPage = 1;
            });
            _pageController.jumpToPage(1);
          },
          child: buildSmallContainerWithSelected(
            'images/img_33.png',
            'Events',
            _currentPage == 1,
          ),
        ),

        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            showNurseryContent = true;

            setState(() {
              _currentPage = 4;
            });
            _pageController.jumpToPage(4);
          },
          child: buildSmallContainerWithSelected(
            'images/img_8.png',
            'Planting Location',
            _currentPage == 4,
          ),
        ),
        /*  SizedBox(width: 5.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentPage = 2;
            });
            _pageController.jumpToPage(2);
          },
          child: buildSmallContainerWithSelected(
            'images/img_8.png',
            'Tree Nursery',
            _currentPage == 2,
          ),
        ),*/

      ],
    ),
  ),
),

    // PageView
          const SizedBox(height: 20),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [


                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 470.h,
                    width: 376.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3F1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: GridView.builder(
                        shrinkWrap: true,
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
                ),


    GestureDetector(
    child: Container(
    margin: EdgeInsets.symmetric(horizontal: 15.w),
    height: 350.h,
    width: 376.w,
    decoration: BoxDecoration(
    color: Color(0xFFEBF3F1),
    borderRadius: BorderRadius.circular(20.r),
    ),
    child: Stack(
    children: [
    Positioned(
    top: 0,
    bottom: 0,
    left: 0,
    right: 0,
    child: ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Image.asset(
    'images/img_36.png',
    fit: BoxFit.cover,
    height: 350.h,
    width: 376.w,
    ),
    ),
    ),
    Positioned(
    top: 10.h,
    left: 15.w,
    child: Row(
    children: [
    Text(
    'Search By',
    style: TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(width: 5.w),
    PopupMenuButton<String>(
    onSelected: (value) {
    print(value);
    },
    offset: Offset(0, 40.h),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.r),
    ),
    itemBuilder: (context) => [
    PopupMenuItem(
    value: "All Nurseries",
    child: Row(
    children: [
    Icon(Icons.location_city, color: Colors.green),
    SizedBox(width: 10.w),
    Text("All Nurseries"),
    ],
    ),
    ),
    PopupMenuItem(
    value: "My Location",
    child: Row(
    children: [
    Icon(Icons.location_on, color: Colors.green),
    SizedBox(width: 10.w),
    Text("My Location"),
    ],
    ),
    ),
    ],
    child: Row(
    children: [
    SizedBox(width: 5.w),
    Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(8.r),
    ),
    child: Row(
    children: [
    Icon(
    Icons.location_on,
    color: Colors.black,
    ),
    SizedBox(width: 8.w),
    Text(
    'My Location',
    style: TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),

    ),



    SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        height: 430.h,
                        width: 376.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3F1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Column(
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
                                color: Colors.green[800],
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
                                  color: Colors.green[900],
                                  fontSize: 13.sp,
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
    GestureDetector(
    child: Container(
    margin: EdgeInsets.symmetric(horizontal: 15.w),
    height: 350.h,
    width: 376.w,
    decoration: BoxDecoration(
    color: Color(0xFFEBF3F1),
    borderRadius: BorderRadius.circular(20.r),
    ),
    child: Stack(
    children: [
    Positioned(
    top: 0,
    bottom: 0,
    left: 0,
    right: 0,
    child: ClipRRect(
    borderRadius: BorderRadius.circular(20.r),
    child: Image.asset(
    'images/img_41.png',
    fit: BoxFit.cover,
    height: 350.h,
    width: 376.w,
    ),
    ),
    ),
    Positioned(
    top: 10.h,
    left: 15.w,
    child: Row(
    children: [
    Text(
    'Search By',
    style: TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(width: 5.w),
    PopupMenuButton<String>(
    onSelected: (value) {
    print(value);
    },
    offset: Offset(0, 40.h),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.r),
    ),
    itemBuilder: (context) => [
    PopupMenuItem(
    value: "All Nurseries",
    child: Row(
    children: [
    Icon(Icons.location_city, color: Colors.green),
    SizedBox(width: 10.w),
    Text("All Nurseries"),
    ],
    ),
    ),
    PopupMenuItem(
    value: "My Location",
    child: Row(
    children: [
    Icon(Icons.location_on, color: Colors.green),
    SizedBox(width: 10.w),
    Text("My Location"),
    ],
    ),
    ),
    ],
    child: Row(
    children: [
    SizedBox(width: 5.w),
    Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(8.r),
    ),
    child: Row(
    children: [
    Icon(
    Icons.location_on,
    color: Colors.black,
    ),
    SizedBox(width: 8.w),
    Text(
    'My Location',
    style: TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    )
    ],
            ),
          )

        ],

      ),



      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF147351),
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
                _selectedIndex == 0 ? const Color(0xFF147351) : Colors.black,
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
                _selectedIndex == 1 ? const Color(0xFF147351) : Colors.black,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'images/img_25.png',
                width: 24.w,
              ),
            ),
            label: 'Comunity',
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
                    color: const Color(0xFF147351).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
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
                _selectedIndex == 3 ? const Color(0xFF147351) : Colors.black,
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
                _selectedIndex == 4 ? const Color(0xFF147351) : Colors.black,
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


Widget buildSmallContainer(String imagePath, String text, bool isSelected, Function onTapAction) {
  return GestureDetector(
    onTap: () => onTapAction(),
    child: Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF147351) : const Color(0xFFEBF3F1),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF147351),
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
        color: isSelected ? const Color(0xFFADCEC2) : const Color(0xFFEBF3F1),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.black : const Color(0xFF147351),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5.w),
          Image.asset(imagePath, width: 30.w, height: 30.h),
        ],
      ));
}
Widget buildSmallContainerWithTitleDescriptionAndImage(String imagePath, String title, String description) {
  return Container(
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: Colors.green, width: 2.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min, // السماح للحاوية بأن تأخذ الحجم المناسب
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imagePath, width: 100.w, height: 100.h),
        SizedBox(height: 10.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          description,
          style: TextStyle(
            fontSize: 10.sp,

            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

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
