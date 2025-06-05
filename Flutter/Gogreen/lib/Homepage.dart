import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Community.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
                        _currentPage = 3;
                      });
                      _pageController.jumpToPage(3);
                    },
                    child: buildSmallContainerWithSelected(
                      'images/img_20.png',
                      'Care',
                      _currentPage == 3,
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
                   SizedBox(width: 5.w),
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
        ),

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
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: 350.h,
                    width: 376.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBF3F1),
                      borderRadius: BorderRadius.circular(20),
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
                                ),
                              ),
                              SizedBox(width: 5.w),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  print(value);
                                },
                                offset: Offset(0, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on, color: Colors.black),
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

                        Positioned.fill(
                          top: 50.h, 
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: _buildBox("images/img_43.png", "Fri, 20 Jul 2026", "Event Aim To Plant 50 Trees", "Zagazig", "120", "100")),
                                      SizedBox(width: 10.w),
                                      Expanded(child: _buildBox("images/img_44.png", "Fri, 20 Jul 2026", "Event Aim To Plant 50 Trees", "Zagazig", "120", "100")),
                                    ],
                                  ),

                                  SizedBox(height: 10.h), 

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: _buildBox("images/img_45.png", "Fri, 20 Jul 2026", "Event Aim To Plant 50 Trees", "Zagazig", "120", "100")),
                                      SizedBox(width: 10.w),
                                      Expanded(child: _buildBox("images/img_46.png", "Fri, 20 Jul 2026", "Event Aim To Plant 50 Trees", "Zagazig", "120", "100")),
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
                ),
    SingleChildScrollView(
    physics: ClampingScrollPhysics(),
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
    Text('Search By', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black)),
    SizedBox(width: 10.w),
    Icon(Icons.location_on, color: Colors.black, size: 18.sp),
    SizedBox(width: 5.w),
    Text("My Location", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
    ],
    ),
    SizedBox(height: 15.h),

    NurseryCard(imagePath: "images/img_38.png", title: "Egypt Green Nursery", location: "Cairo, Egypt", rating: 4.5, latitude: 30.0444, longitude: 31.2357),
    SizedBox(height: 10.h),

    NurseryCard(imagePath: "images/img_39.png", title: "Farming Nursery", location: "Alexandria, Egypt", rating: 4.0, latitude: 31.2001, longitude: 29.9187),
    SizedBox(height: 10.h),

    NurseryCard(imagePath: "images/img_40.png", title: "Flower & Plants Nursery", location: "Giza, Egypt", rating: 5.0, latitude: 29.9784, longitude: 31.1313),
    SizedBox(height: 10.h),

    ],
    ),
    ),
    ],
    ),
    ),



    SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
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

                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: 350,
                    width: 376,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBF3F1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [

                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FlutterMap(
                              options: MapOptions(
                                center: LatLng(30.0444, 31.2357),
                                zoom: 13.0,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c'],
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: LatLng(30.0444, 31.2357),
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),



                        Positioned(
                          top: 10,
                          left: 15,
                          child: Row(
                            children: [
                              Text(
                                'Search By',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  print(value);
                                },
                                offset: Offset(0, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: "All Nurseries",
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_city, color: Colors.green),
                                        SizedBox(width: 10),
                                        Text("All Nurseries"),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "My Location",
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on, color: Colors.green),
                                        SizedBox(width: 10),
                                        Text("My Location"),
                                      ],
                                    ),
                                  ),
                                ],
                                child: Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on, color: Colors.black),
                                          SizedBox(width: 8),
                                          Text(
                                            'My Location',
                                            style: TextStyle(
                                              fontSize: 16,
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
                        Positioned(
                          top: 30.h,
                          right: 30.w,
                          child: GestureDetector(

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
                  ),


                ),
              ],
            ),
          )

        ],

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
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF147351)),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: const Color(0xFF147351), size: 18.sp),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            widget.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11.sp, color: Colors.grey),
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
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                    Spacer(),
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
                              style: TextStyle(fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.bold),
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

        if (_showMap) _buildMapContainer(widget.latitude, widget.longitude),
      ],
    );
  }

  Widget _buildMapContainer(double latitude, double longitude) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      height: 350.h,
      width: 376.w,
      decoration: BoxDecoration(
        color: Color(0xFFEBF3F1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(latitude, longitude),
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://tile.openstreetmap.de/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),

                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(latitude, longitude),
                        width: 40.w,
                        height: 40.h,
                        child: Icon(Icons.location_pin, color: Colors.red, size: 40.sp),
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
Widget _buildBox(String imagePath, String date, String title, String location, String interested, String going, {double? width}) {
  return Container(
    width: width ?? 0.44.sw,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          spreadRadius: 2,
          offset: Offset(2, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 100.h,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: TextStyle(fontSize: 10.sp, color: Colors.grey[700])),
              SizedBox(height: 2.h),
              Text(
                title,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(0xFF013D26)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
                  Expanded(
                    child: Text(
                      location,
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey[700]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                "$interested interested. $going going",
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEBF3F1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_border, color: Color(0xFF013D26), size: 16),
                      SizedBox(width: 5.w),
                      Text(
                        "Interested",
                        style: TextStyle(fontSize: 12.sp, color: Color(0xFF013D26),),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 8.w),
              Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Color(0xFFEBF3F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Transform.flip(
                    flipX: true,
                    child: Icon(Icons.reply, size: 18, color: Colors.green[900]),
                  ),
                  onPressed: () {
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
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
      mainAxisSize: MainAxisSize.min,
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