import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _selectedTab = 0; // 0 for History, 1 for Coupons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Stack(
          children: [
            // Notification indicator
            Positioned(
              right: 40,
              top: 66,
              child: Container(
                width: 32.91,
                height: 33,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 5.50,
                      child: Container(
                        width: 8.23,
                        height: 8.25,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF1BA52B),
                          shape: OvalBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Points card
            Positioned(
              left: 26,
              top: 125,
              child: Container(
                width: MediaQuery.of(context).size.width - 52,
                height: 76,
                decoration: ShapeDecoration(
                  color: const Color(0xFFEBF3F1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: const Color(0x19383F3C),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.star, size: 41, color: const Color(0xFFE3B62D)),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You Have',
                            style: TextStyle(
                              color: const Color(0xAF383F3C),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '25',
                            style: TextStyle(
                              color: const Color(0xFFE3B62D),
                              fontSize: 36,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Points',
                            style: TextStyle(
                              color: const Color(0xAF383F3C),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // App logo and title
            Positioned(
              left: 53,
              top: 76,
              child: Row(
                children: [
                  Container(
                    width: 6.30,
                    height: 6.30,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF147351),
                      shape: OvalBorder(
                        side: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'GoGreen',
                    style: TextStyle(
                      color: const Color(0xFF147351),
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Main content area
            Positioned(
              left: 18,
              top: 220,
              right: 18,
              bottom: 100,
              child: Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFFE4F5EF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    // Tab bar
                    Container(
                      height: 50,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          // History tab
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
                          // Coupons tab
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

                    // Content based on selected tab
                    Expanded(
                      child: _selectedTab == 0 ? _buildHistoryTab() : _buildCouponsTab(),
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

  Widget _buildHistoryTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildRewardItem(
          title: 'Locate New Tree',
          date: '1/2/2025',
          points: '+5 Pts',
          icon: Icons.location_on,
        ),
        _buildRewardItem(
          title: 'Care Of Trees',
          date: '2/2/2025',
          points: '+10 Pts',
          icon: Icons.nature,
        ),
        _buildRewardItem(
          title: 'Interact With Posts',
          date: '6/2/2025',
          points: '+3 Pts',
          icon: Icons.comment,
        ),
        _buildRewardItem(
          title: 'Check Response',
          date: '6/2/2025',
          points: '+5 Pts',
          icon: Icons.check_circle,
        ),
      ],
    );
  }

  Widget _buildCouponsTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildCouponItem(
          store: 'From Noon',
          discount: '30% Off',
          points: '-30 Pts',
          imageUrl: 'https://placehold.co/54x54',
        ),
        // المستطيل العلوي الجديد بارتفاع 160
        Container(
          width: double.infinity,  // لجعل العرض يتناسب مع العرض الكامل
          height: 160,  // تعديل الارتفاع إلى 160
          margin: EdgeInsets.only(bottom: 16), // نفس الهامش السفلي
          decoration: ShapeDecoration(
            color: Colors.white,  // يمكن تغيير اللون كما تريد
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: const Color(0xFFDADADA),  // نفس لون الحافة
              ),
              borderRadius: BorderRadius.circular(10), // نفس الحواف المدورة
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 1,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network('https://placehold.co/54x54', width: 40, height: 40),  // صورة مماثلة
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discount Store',
                      style: TextStyle(
                        color: const Color(0xFF147351),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '20% off on your next purchase!',
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
                  '-20 Pts',
                  style: TextStyle(
                    color: const Color(0xFFD95D48),  // اللون حسب القيم السلبية
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRewardItem({
    required String title,
    required String date,
    required String points,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      height: 75,  // تم تخفيض الارتفاع هنا إلى 120 للمستطيلات في History
      margin: EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFDADADA),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
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
                color: const Color(0xFF147351),
                shape: OvalBorder(),
              ),
              child: Icon(icon, color: Colors.white),
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
    required String points,
    required String imageUrl,
  }) {
    return Container(
      width: double.infinity,
      height: 160,  // الاحتفاظ بارتفاع 160 للمستطيلات في Coupons
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFDADADA)),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.network(imageUrl, width: 40, height: 40),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store,
                  style: TextStyle(
                    color: const Color(0xFF147351),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  discount,
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
}
