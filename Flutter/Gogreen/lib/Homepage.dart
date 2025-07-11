import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gogreen/EventDetails.dart';
import 'package:gogreen/NotificationPage.dart';
import 'package:gogreen/SearchScreen.dart';
import 'package:gogreen/TreeDetails.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  int _currentPage = 0;
  bool _isNotificationPressed = false;
  bool showNurseryContent = false;

  late List<bool> _isSelected;
  late int _currentIndex;
  final PageController _pageController = PageController();

  @override

  void initState() {
    super.initState();
    _isSelected = List.generate(5, (_) => false);
    _currentIndex = 0;
    _isSelected[_currentIndex] = true;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onIconTap(int index) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = true;
      _currentIndex = index;
      _currentPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
    );

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationsPage(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'images/img_28.png',
                        width: 40.w,
                        height: 40.h,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'images/img_29.png',
                        width: 31.w,
                        height: 31.h,
                      ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _onIconTap(0),
                    child: buildSmallContainerWithSelected(
                      'images/img_63.png',
                      'Khedr Chatbot',
                      _currentPage == 0,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => _onIconTap(3),
                    child: buildSmallContainerWithSelected(
                      'images/img_20.png',
                      'Care',
                      _currentPage == 3,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => _onIconTap(1),
                    child: buildSmallContainerWithSelected(
                      'images/img_33.png',
                      'Events',
                      _currentPage == 1,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => _onIconTap(4),
                    child: buildSmallContainerWithSelected(
                      'images/img_8.png',
                      'Planting Location',
                      _currentPage == 4,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => _onIconTap(2),
                    child: buildSmallContainerWithSelected(
                      'images/img_8.png',
                      'Tree Nursery',
                      _currentPage == 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                  _currentPage = index;
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = i == index;
                  }
                  _currentIndex = index;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF3F1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: const ChatBotScreen(),
                ),
                // Page 1: Events
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  height: 350.h,
                  width: 376.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF3F1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Stack(
                    children: [
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
                                fontFamily: 'Roboto',
                              ),
                            ),
                            SizedBox(width: 5.w),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                // Handle selection if needed
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
                                      const Icon(Icons.location_city, color: Colors.green),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "All Nurseries",
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "My Location",
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on, color: Colors.green),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "My Location",
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              child: Container(
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
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'My Location',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        top: 50.h,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: EventBox(
                                        key: const ValueKey('event1'),
                                        imagePath: "images/img_43.png",
                                        date: "Fri, 20 Jul 2026",
                                        title: "Event Aim To Plant 50 Trees",
                                        location: "Zagazig",
                                        interested: "120",
                                        going: "100",
                                        eventId: "event1",
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: EventBox(
                                        key: const ValueKey('event2'),
                                        imagePath: "images/img_44.png",
                                        date: "Fri, 20 Jul 2026",
                                        title: "Event Aim To Plant 50 Trees",
                                        location: "Zagazig",
                                        interested: "120",
                                        going: "100",
                                        eventId: "event2",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: EventBox(
                                        key: const ValueKey('event3'),
                                        imagePath: "images/img_45.png",
                                        date: "Fri, 20 Jul 2026",
                                        title: "Event Aim To Plant 50 Trees",
                                        location: "Zagazig",
                                        interested: "120",
                                        going: "100",
                                        eventId: "event3",
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: EventBox(
                                        key: const ValueKey('event4'),
                                        imagePath: "images/img_46.png",
                                        date: "Fri, 20 Jul 2026",
                                        title: "Event Aim To Plant 50 Trees",
                                        location: "Zagazig",
                                        interested: "120",
                                        going: "100",
                                        eventId: "event4",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Page 2: Tree Nursery
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                        width: 385.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3F1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Search By',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "My Location",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            NurseryCard(
                              imagePath: "images/img_38.png",
                              title: "Egypt Green Nursery",
                              location: "Cairo, Egypt",
                              rating: 4.5,
                              latitude: 30.0444,
                              longitude: 31.2357,
                            ),
                            SizedBox(height: 10.h),
                            NurseryCard(
                              imagePath: "images/img_39.png",
                              title: "Farming Nursery",
                              location: "Alexandria, Egypt",
                              rating: 4.0,
                              latitude: 31.2001,
                              longitude: 29.9187,
                            ),
                            SizedBox(height: 10.h),
                            NurseryCard(
                              imagePath: "images/img_40.png",
                              title: "Flower & Plants Nursery",
                              location: "Giza, Egypt",
                              rating: 5.0,
                              latitude: 29.9784,
                              longitude: 31.1313,
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Page 3: Care
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
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
                                  'No plants to care of yet!',
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
                          Positioned(
                            top: 30.h,
                            right: 30.w,
                            child: GestureDetector(
                              onTap: () {
                                // Handle add button tap
                              },
                              child: Container(
                                width: 44.w,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF147351),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 26.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Page 4: Planting Location
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  height: 350.h,
                  width: 376.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF3F1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: FlutterMap(
                            options: const MapOptions(
                              center: LatLng(30.0444, 31.2357),
                              zoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                userAgentPackageName: 'com.example.gogreen',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: const LatLng(30.0444, 31.2357),
                                    width: 80.w,
                                    height: 40.h,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 40.sp,
                                        ),
                                        SizedBox(width: 5.w),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const TreeDetails(),
                                              ),
                                            );
                                          },
                                          child: Image.asset(
                                            'images/img_64.png',
                                            color: const Color(0xFF147351),
                                            width: 32.w,
                                            height: 40.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                // Handle selection if needed
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
                                      const Icon(Icons.location_city, color: Colors.green),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "All Nurseries",
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "My Location",
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on, color: Colors.green),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "My Location",
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              child: Container(
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
                                      size: 18.sp,
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
          Image.asset(
            imagePath,
            width: 30.w,
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class EventBox extends StatefulWidget {
  final String imagePath;
  final String date;
  final String title;
  final String location;
  final String interested;
  final String going;
  final String eventId;

  const EventBox({
    super.key,
    required this.imagePath,
    required this.date,
    required this.title,
    required this.location,
    required this.interested,
    required this.going,
    required this.eventId,
  });

  @override
  _EventBoxState createState() => _EventBoxState();
}

class _EventBoxState extends State<EventBox> {
  bool isInterested = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(eventId: widget.eventId),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160.h,
              width: 182.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.date,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF003C26),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF003C26),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14.sp,
                  color: const Color(0xFF003C26),
                ),
                SizedBox(width: 4.w),
                Text(
                  widget.location,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF6F9283),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              '${widget.interested} interested. ${widget.going} going',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF709283),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  isInterested = !isInterested;
                });
              },
              child: Container(
                width: 110.w,
                height: 30.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: ShapeDecoration(
                  color: const Color(0xFFDCECE8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                  shadows: [
                    BoxShadow(
                      color: const Color(0xFF003C26),
                      blurRadius: 1,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      isInterested ? Icons.star : Icons.star_border,
                      size: 14.sp,
                      color: const Color(0xFF013D26),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Interested',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF013D26),
                        fontSize: 12.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NurseryCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String location;
  final double rating;
  final double latitude;
  final double longitude;

  const NurseryCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  @override
  _NurseryCardState createState() => _NurseryCardState();
}

class _NurseryCardState extends State<NurseryCard> {
  bool _showMap = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320.w,
          height: 110.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  widget.imagePath,
                  width: 90.w,
                  height: 90.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF147351),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: const Color(0xFF147351),
                          size: 18.sp,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            widget.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        for (int i = 1; i <= 5; i++)
                          Icon(
                            Icons.star,
                            color: i <= widget.rating ? Colors.amber : Colors.grey[300],
                            size: 16.sp,
                          ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.rating.toString(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showMap = !_showMap;
                          });
                        },
                        child: Container(
                          width: 96.3.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF147351),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              _showMap ? "Hide Location" : "View Location",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_showMap) _buildMapContainer(context),
      ],
    );
  }

  Widget _buildMapContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      height: 350.h,
      width: 376.w,
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3F1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(widget.latitude, widget.longitude),
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.gogreen',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(widget.latitude, widget.longitude),
                        width: 80.w,
                        height: 40.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40.sp,
                            ),
                            SizedBox(width: 5.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TreeDetails(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 31.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://placehold.co/31x32"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  // ✅ غيّر ده بـ رابط ngrok الحالي
  final String _baseUrl = "https://ffbf56b9b1bb.ngrok-free.app";

  final List<Map<String, String>> _messages = [
    {'sender': 'bot', 'text': 'مرحبا بك أنا خِضر'},
  ];

  final TextEditingController _controller = TextEditingController();
  bool _isSending = false;
  final String user_id = "67da4fd880c2917bff17a47f";

  @override
  void initState() {
    super.initState();
    _fetchChatHistory();
  }

  Future<void> _fetchChatHistory() async {
    setState(() {
      _isSending = true;
    });

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/history/$user_id'),
        headers: {
          'ngrok-skip-browser-warning': 'true',
        },
      ).timeout(const Duration(seconds: 60));

      print('History status: ${response.statusCode}');
      print('History body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> history = data['data'];

        setState(() {
          _messages.clear();
          _messages.add({'sender': 'bot', 'text': 'مرحبا بك أنا خِضر'});
          for (final item in history) {
            _messages.add({'sender': 'user', 'text': item['text'] ?? ''});
            _messages.add({
              'sender': 'bot',
              'text': 'تصنيف الرسالة: ${item['label'] ?? 'غير معروف'}',
            });
          }
        });
      } else {
        print('فشل في جلب السجل: ${response.body}');
      }
    } catch (e) {
      print('حدث خطأ في جلب السجل: $e');
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  Future<String> _sendMessageToBot(String message) async {
    setState(() {
      _isSending = true;
    });

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode({
          'text': message,
          'user_id': user_id,
        }),
      ).timeout(const Duration(seconds: 60));

      print('Chat API status: ${response.statusCode}');
      print('Chat API body: ${response.body}');

      if (!response.headers['content-type']!.contains('application/json')) {
        return '⚠️ السيرفر رد بـ HTML أو غير JSON:\n\n${response.body}';
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? 'لا يوجد رد';
      } else {
        return 'خطأ: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      print('خطأ أثناء إرسال الرسالة: $e');
      return 'فشل الاتصال: $e';
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }
/*
  Future<String> _classifyIntent(String message) async {
    try {
      print('Calling classifyIntent...');
      final response = await http.post(
        Uri.parse('$_baseUrl/intent'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode({
          'text': message,
          'user_id': user_id,
        }),
      ).timeout(const Duration(seconds: 60));

      print('Intent API status: ${response.statusCode}');
      print('Intent API body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final intent = data['data']?['intent'];
        return intent ?? 'Intent غير معروف';
      } else {
        return 'فشل تحديد النية: ${response.body}';
      }
    } catch (e) {
      print('Error in classifyIntent: $e');
      return 'خطأ في تحليل النية: $e';
    }
  }*/

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text.trim();

    setState(() {
      _messages.add({'sender': 'user', 'text': userMessage});
      _messages.add({'sender': 'bot', 'text': 'جارٍ معالجة رسالتك...'});
    });
    _controller.clear();

    final botResponse = await _sendMessageToBot(userMessage);
    //final intentResponse = await _classifyIntent(userMessage);

    setState(() {
      _messages.removeLast();
      _messages.add({'sender': 'bot', 'text': botResponse});
      //_messages.add({'sender': 'bot', 'text': 'نية الرسالة: $intentResponse'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3F1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF147351) : Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECF0EE),
                      border: Border.all(
                          color: const Color(0xFFD7DAD9), width: 0.5.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'اكتب رسالة إلى خِضر',
                        hintStyle: TextStyle(
                            color: Color(0xFF939896), fontSize: 13),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: _isSending ? null : _sendMessage,
                  child: Container(
                    width: 49.w,
                    height: 49.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF147351),
                      shape: BoxShape.circle,
                    ),
                    child: _isSending
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
