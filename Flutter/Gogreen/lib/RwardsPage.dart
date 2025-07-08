import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/NotificationPage.dart'; // تأكد من إنشاء هذا الملف
import 'package:gogreen/SearchScreen.dart';
class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _selectedTab = 0;
  int _points = 25;
  bool _isNotificationPressed = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Column(
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NotificationsPage()),
                                  );
                                },
                                child: Image.asset(
                                  'images/img_54.png',
                                  width: 33,
                                  height: 33,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SearchScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: Color(0xFF147351),
                                  size: 35,
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
                              '$_points points',
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
                  ],
                ),
              ),

              Positioned(
                left: 18,
                top: 280,
                right: 18,
                bottom: 60,
                child: Container(
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE4F5EF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 0;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedTab == 0 ? const Color(0xFF499077) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'History',
                                      style: TextStyle(
                                        color: _selectedTab == 0 ? const Color(0xFFEBF3F1) : const Color(0xFF41584E),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _selectedTab == 1 ? const Color(0xFF499077) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Coupons',
                                      style: TextStyle(
                                        color: _selectedTab == 1 ? const Color(0xFFEBF3F1) : const Color(0xFF41584E),
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _selectedTab == 0 ? _buildHistoryTab() : _buildCouponTab(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistoryTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildRewardItem(title: 'Locate New Tree', date: '1/2/2025', points: '+5 Pts', imagePath: 'images/img_55.png'),
        _buildRewardItem(title: 'Care Of Trees', date: '2/2/2025', points: '+10 Pts', imagePath: 'images/img_56.png'),
        _buildRewardItem(title: 'Interact With Posts', date: '6/2/2025', points: '+3 Pts', imagePath: 'images/img_57.png'),
        _buildRewardItem(title: 'Check Response', date: '6/2/2025', points: '+5 Pts', imagePath: 'images/img_61.png'),
      ],
    );
  }

  Widget _buildCouponTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildCouponItem(
          store: 'From Noon',
          discount: '30% Off',
          pointsCost: 30,
          imagePath: 'images/img_59.png',
        ),
        _buildCouponItem(
          store: 'From Farming Nursery',
          discount: '20% off',
          pointsCost: 20,
          imagePath: 'images/img_60.png',
        ),
      ],
    );
  }

  Widget _buildRewardItem({
    required String title,
    required String date,
    required String points,
    required String imagePath,
  }) {
    return Container(
      width: double.infinity,
      height: 75,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFDADADA)),
        boxShadow: [
          BoxShadow(color: Color(0x3F000000), blurRadius: 1, offset: Offset(0, 0)),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 42,
              height: 42,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(),
              ),
              child: Image.asset(
                imagePath,
                width: 42,
                height: 42,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF147351),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: const Color(0xFF709283),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              points,
              style: TextStyle(
                color: points.startsWith('+') ? const Color(0xFF499077) : const Color(0xFFD95D48),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponItem({
    required String store,
    required String discount,
    required int pointsCost,
    required String imagePath,
  }) {
    return Container(
      width: double.infinity,
      height: 170,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFFDADADA)),
        boxShadow: [
          BoxShadow(color: Color(0x3F000000), blurRadius: 1, offset: Offset(0, 0)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Container(
              width: 60,
              color: const Color(0xFF147351),
              child: Center(
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    'Discount Coupon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF147351),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 4),
                  Text(
                    discount,
                    style: TextStyle(
                      color: Color(0xFF709283),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    'images/img_58.png',
                    width: 131,
                    height: 43,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(imagePath),
                    radius: 30,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _points -= pointsCost;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF499077),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Redeem"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}