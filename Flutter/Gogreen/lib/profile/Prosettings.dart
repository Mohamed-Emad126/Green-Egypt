import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:gogreen/password/UpdatePassword.dart'; // تأكد من المسار حسب موقع الملف

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool isLanguageExpanded = false;
  String selectedLanguage = 'English';
  bool isNotificationsExpanded = false;
  bool isCommunityExpanded = false;
  bool isPlantCareExpanded = false;

  void toggleLanguageDropdown() {
    setState(() {
      isLanguageExpanded = !isLanguageExpanded;
    });
  }

  void selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
      isLanguageExpanded = false;
    });
  }

  void toggleNotificationsDropdown() {
    setState(() {
      isNotificationsExpanded = !isNotificationsExpanded;
    });
  }

  void toggleCommunityDropdown() {
    setState(() {
      isCommunityExpanded = !isCommunityExpanded;
    });
  }

  void togglePlantCareDropdown() {
    setState(() {
      isPlantCareExpanded = !isPlantCareExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 345,
          height: 747,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.80, color: const Color(0xFFDADADA)),
              borderRadius: BorderRadius.circular(35),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 3),
                spreadRadius: 4,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: 20,
                top: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE0E0E0),
                    ),
                    child: Center(
                      child: Icon(Icons.close, color: Color(0xFF003C26), size: 20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 159,
                child: Container(
                  width: 264,
                  height: 548,
                  child: ListView(
                    children: [
                      buildSettingItem(
                        icon: Icons.language,
                        title: 'Language',
                        isExpanded: isLanguageExpanded,
                        onTap: toggleLanguageDropdown,
                      ),
                      if (isLanguageExpanded) buildLanguageOptions(),

                      SizedBox(height: 30),
                      buildSettingItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        isExpanded: isNotificationsExpanded,
                        onTap: toggleNotificationsDropdown,
                      ),
                      if (isNotificationsExpanded) buildNotificationOptions(),

                      SizedBox(height: 30),
                      buildSettingItem(
                        icon: Icons.nightlight_round_outlined,
                        title: 'Dark Mode',
                        trailing: FontistoToggleOff(),
                      ),

                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => UpdatePassword()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEBF3F1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(CarbonIcons.logout, color: Color(0xFF147351)),
                              SizedBox(width: 8),
                              Text(
                                'Update password',
                                style: TextStyle(
                                  color: Color(0xFF147351),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          // Handle logout
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEBF3F1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Color(0xFF147351)),
                              SizedBox(width: 8),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Color(0xFF147351),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          // Handle delete account
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEBF3F1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Delete Account',
                                style: TextStyle(
                                  color: Color(0xFF147351),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 52,
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Color(0xFF003C26),
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingItem({
    required IconData icon,
    required String title,
    bool isExpanded = false,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEBF3F1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Color(0xFF147351)),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF147351),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            trailing ??
                Icon(
                  isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                  color: Color(0xFF147351),
                ),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageOptions() {
    return Container(
      color: Color(0xFFEBF3F1),
      child: Column(
        children: [
          ListTile(
            title: Text('English'),
            leading: Radio<String>(
              value: 'English',
              groupValue: selectedLanguage,
              onChanged: (value) {
                if (value != null) selectLanguage(value);
              },
            ),
          ),
          ListTile(
            title: Text('Arabic'),
            leading: Radio<String>(
              value: 'Arabic',
              groupValue: selectedLanguage,
              onChanged: (value) {
                if (value != null) selectLanguage(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationOptions() {
    return Container(
      color: Color(0xFFEBF3F1),
      child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('images/img_49.png', width: 24, height: 24),
                    SizedBox(width: 8),
                    Text('Community', style: TextStyle(color: Color(0xFF003C26), fontSize: 16)),
                  ],
                ),
                Icon(
                  isCommunityExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                  color: Color(0xFF147351),
                ),
              ],
            ),
            onTap: toggleCommunityDropdown,
          ),
          if (isCommunityExpanded)
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEBF3F1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCommunityItem('Events'),
                  _buildCommunityItem('Comments'),
                ],
              ),
            ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('PlantCare', style: TextStyle(color: Color(0xFF003C26), fontSize: 16)),
                Icon(
                  isPlantCareExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                  color: Color(0xFF147351),
                ),
              ],
            ),
            onTap: togglePlantCareDropdown,
          ),
          if (isPlantCareExpanded)
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEBF3F1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Plants care reminder', style: TextStyle(color: Color(0xFF003C26), fontSize: 16)),
                  FontistoToggleOff(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCommunityItem(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Color(0xFF003C26), fontSize: 16)),
          FontistoToggleOff(),
        ],
      ),
    );
  }
}

class FontistoToggleOff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.toggle_off, color: Colors.green, size: 34);
  }
}
