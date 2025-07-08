import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ResponsePosted.dart';
import 'respondes_post_model.dart';
import 'response_data.dart';

class SelectResponse extends StatefulWidget {
  const SelectResponse({super.key});

  @override
  State<SelectResponse> createState() => _SelectResponseState();
}

class _SelectResponseState extends State<SelectResponse> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  List<File> _recentImages = [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _loadRecentImages();
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
        // removed _loadRecentImages() to prevent auto-opening
      });
    }
  }

  Future<void> _loadRecentImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _recentImages = images.map((xFile) => File(xFile.path)).take(6).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // removed _loadRecentImages() to prevent auto-opening
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 390,
        height: 844,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF003C26),
                    size: 30,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 48,
              top: 60,
              child: Text(
                'Response',
                style: TextStyle(
                  color: Color(0xFF003C26),
                  fontSize: 26,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 119,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 330,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const NetworkImage("https://placehold.co/330x270") as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: _selectedImage == null
                      ? const Center(
                    child: Icon(Icons.camera_alt, color: Colors.white, size: 50),
                  )
                      : null,
                ),
              ),
            ),
            const Positioned(
              left: 24,
              top: 417,
              child: Text(
                'Recent',
                style: TextStyle(
                  color: Color(0xFF003C26),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 462,
              child: Container(
                width: 350,
                height: 231,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    ..._recentImages.asMap().entries.map((entry) {
                      final index = entry.key;
                      final image = entry.value;
                      return Positioned(
                        left: index % 3 * 118,
                        top: index ~/ 3 * 115,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImage = image;
                            });
                          },
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    Positioned(
                      left: 300,
                      top: 0,
                      child: GestureDetector(
                        onTap: _takePhoto,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF147351),
                            shape: OvalBorder(),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 250,
                      top: 0,
                      child: GestureDetector(
                        onTap: () async {
                          await _loadRecentImages();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFEBF3F1),
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 0.50,
                                color: Color(0xFFDADADA),
                              ),
                            ),
                          ),
                          child: const Icon(Icons.photo, color: Color(0xFF003C26), size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 75,
              top: 720,
              child: GestureDetector(
                onTap: () {
                  if (_selectedImage != null) {
                    final newPost = RespondesPost(
                      userName: 'Current User',
                      userImage: 'images/img_53.png',
                      timeAgo: 'Just now',
                      imagePath: _selectedImage!.path,
                      postText: '',
                      location: 'Unknown',
                      likes: 0,
                      comments: 0,
                    );

                    ResponseData.posts.add(newPost);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResponsePosted(),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 240,
                  padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF147351),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, -1),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Post',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: '18 Khebrat Musamim',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}