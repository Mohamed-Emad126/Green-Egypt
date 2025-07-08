import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _selectedCategory = 'All';

  void _clearAllNotifications() {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All notifications cleared!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 60, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left,
                            size: 45,
                            color: const Color(0xFF013D26)),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          color: Color(0xFF003C26),
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _clearAllNotifications,
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        color: Color(0xFF98A09C),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Categories Tabs
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildCategoryChip('All'),
                  const SizedBox(width: 4),
                  _buildCategoryChip('Care'),
                  const SizedBox(width: 4),
                  _buildCategoryChip('Events'),
                  const SizedBox(width: 4),
                  _buildCategoryChip('Community'),
                ],
              ),
            ),

            // Notifications List with Scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          color: Color(0xFF003C26),
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    _buildNotification(
                      title: "Don't forget to water your tree today!",
                      description: "A little care goes a long way in making your city greener.",
                      time: "20 min",
                      icon: Icons.water_drop,
                    ),
                    const SizedBox(height: 16),
                    _buildNotification(
                      title: "A new GoGreen event is happening near you!",
                      description: "Join us and help make Egypt greener",
                      time: "30 min",
                      icon: Icons.event,
                      adjustIconPosition: true, // تعديل هنا للإشعار الثاني
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 32, bottom: 16),
                      child: Text(
                        'Earlier',
                        style: TextStyle(
                          color: Color(0xFF003C26),
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    _buildNotification(
                      title: "There is a new post in community from Ahmed Khaled",
                      description: "There is a tree need care...",
                      time: "30 min",
                      icon: Icons.people,
                      adjustIconPosition: true, // تعديل هنا للإشعار الثالث
                    ),
                    const SizedBox(height: 16),
                    _buildNotification(
                      title: "You've done a great job lately",
                      description: "You can earn a new coupon by your points, check the rewards section",
                      time: "34 min",
                      icon: Icons.card_giftcard,
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

  Widget _buildCategoryChip(String category) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: _selectedCategory == category ? const Color(0xFF147351) : const Color(0xFFEBF3F1),
          borderRadius: BorderRadius.circular(20),
          border: _selectedCategory == category
              ? null
              : Border.all(color: const Color(0xFFDADADA)),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: _selectedCategory == category ? Colors.white : const Color(0xFF003C26),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNotification({
    required String title,
    required String description,
    required String time,
    required IconData icon,
    bool adjustIconPosition = false, // بارامتر اختياري
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F5EF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Green Dot
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF1BA52B),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Text Content
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF003C26),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF709283),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF147351),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Right Icon
          Positioned(
            right: 0,
            top: adjustIconPosition ? 16 : 0, // تعديل الموضع حسب البارامتر
            child: Icon(
              icon,
              color: const Color(0xFF147351),
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}