import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/line_md.dart';

class CommunityPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildAppBar(),
                  _buildLocationSection(),
                  _buildCategoryTabs(),
                  _buildPostHeader(),
                  _buildPostContent(),
                  _buildPostActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Text(
                    'GoGreen',
                    style: TextStyle(
                      color: const Color(0xFF147351),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Positioned(
                    right: -5,
                    top: 5,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF147351),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'images/img_54.png',  // المسار الصحيح لصورة الإشعار
                    width: 33,
                    height: 33,
                  ),

                ],
              ),
              SizedBox(width: 10),  // المسافة بين الأيقونات
              Icon(
                Icons.search,
                color: const Color(0xFF147351),  // اللون الأخضر
                size: 35,
              ),
            ],
          )

        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 20, top: 5, bottom: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: TextStyle(
                color: const Color(0xFF709283),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,  // يمكنك تغيير الأيقونة إذا أردت
                  color: const Color(0xFF003C26),  // اللون الأخضر
                  size: 20,
                ),
                Text(
                  'Zagazig',
                  style: TextStyle(
                    color: const Color(0xFF003C26),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF147351),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF3F1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDADADA), width: 0.5),
              ),
              child: Text(
                'Tree Planters',
                style: TextStyle(
                  color: const Color(0xFF003C26),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF3F1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDADADA), width: 0.5),
              ),
              child: Text(
                'Tree Care & Issues',
                style: TextStyle(
                  color: const Color(0xFF003C26),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة الجديدة في أقصى اليسار
          Image.asset(
            'images/img_53.png',
            width: 47,
            height: 47,
          ),
          SizedBox(width: 12),

          // صورة البروفايل

          // الاسم والمعلومات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adham Ehab',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '3h',
                      style: TextStyle(
                        color: const Color(0xFF98A09C),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFF98A09C),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.public,
                      size: 14,
                      color: const Color(0xFF98A09C),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // زر المزيد
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'There is a tree that needs some care!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Al-Rawda Mosque',
            style: TextStyle(
              color: const Color(0xFF147351),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 327,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("images/img_50.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPostActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up, size: 16, color: const Color(0xFF0F6848)),
                    SizedBox(width: 5),
                    Text(
                      '65',
                      style: TextStyle(
                        color: const Color(0xFF0F6848),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Icon(Icons.comment, size: 16, color: const Color(0xFF0F6848)),
                    SizedBox(width: 5),
                    Text(
                      '18',
                      style: TextStyle(
                        color: const Color(0xFF0F6848),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: const Color(0xFFE8EAEA), height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Row(
                    children: [
                      Image.asset(
                        'images/img_52.png',
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                  label: Text(
                    'Support',
                    style: TextStyle(
                      color: const Color(0xFF0F6848),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF147351),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text(
                    'Response',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.comment_outlined, color: const Color(0xFF0F6848)),
                  label: Text(
                    'Comment',
                    style: TextStyle(
                      color: const Color(0xFF0F6848),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: const Color(0xFFE9EBEA), height: 1),
        ],
      ),
    );
  }
}