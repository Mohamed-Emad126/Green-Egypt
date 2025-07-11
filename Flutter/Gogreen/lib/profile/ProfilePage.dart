import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gogreen/profile/Editprofile.dart';
import 'package:gogreen/Profile/Prosettings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadImageFromPreferences();
  }

  Future<void> _loadImageFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image_path');

    if (imagePath != null && await File(imagePath).exists()) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', pickedFile.path);

      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Color(0xFF003C26),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : NetworkImage("https://placehold.co/65x65") as ImageProvider,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ahmed Mouhammed',
                            style: TextStyle(
                              color: Color(0xFF003C26),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Zagazig - Egypt',
                            style: TextStyle(
                              color: Color(0xFF147351),
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditProfile()),
                              ).then((_) {
                                _loadImageFromPreferences();
                              });
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0x3F147351),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Color(0xFF147351),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
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
                SizedBox(height: 30),
                Divider(color: Color(0xFFDADADA), thickness: 2),
                SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2.5,
                  children: [
                    _buildProfileOption('Saved', Icons.bookmark),
                    _buildProfileOption('Events', Icons.event),
                  ],
                ),
                Spacer(),
              ],
            ),
            Positioned(
              right: 20,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileSettings()),
                  );
                },
                child: Container(
                  width: 37,
                  height: 37,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF147351),
                  ),
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEBF3F1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFD9D9D9)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFF147351)),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF147351),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
