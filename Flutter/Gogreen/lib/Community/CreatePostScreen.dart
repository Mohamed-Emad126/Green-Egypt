import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gogreen/Community/community_post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:gogreen/Community/CreatePost2.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File? _selectedImage;
  List<AssetEntity> _galleryImages = [];
  bool _isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGalleryImages();
  }

  Future<void> _loadGalleryImages() async {
    try {
      final permission = await PhotoManager.requestPermissionExtend();
      if (!permission.isAuth) {
        if (!mounted) return;
        _showSnackBar("Permission denied to access gallery. Please allow access in settings.");
        await openAppSettings();
        return;
      }

      final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );

      if (albums.isEmpty) return;

      final recentAlbum = albums.first;
      final images = await recentAlbum.getAssetListPaged(page: 0, size: 100);

      if (mounted) setState(() => _galleryImages = images);
    } catch (e) {
      _showSnackBar("Error loading gallery: ${e.toString()}");
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isLoading = true);

      final status = await _requestPermission(source);
      if (!status) {
        _showSnackBar("Permission denied for $source. Please allow access in settings.");
        await openAppSettings();
        return;
      }

      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        if (mounted) setState(() => _selectedImage = File(pickedFile.path));
      } else {
        _showSnackBar("No image selected from $source");
      }
    } catch (e) {
      _showSnackBar("Error picking image: ${e.toString()}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<bool> _requestPermission(ImageSource source) async {
    try {
      Permission permission;
      if (Platform.isIOS) {
        permission = source == ImageSource.camera
            ? Permission.camera
            : Permission.photos;
      } else {
        permission = source == ImageSource.camera
            ? Permission.camera
            : Permission.storage;
      }
      final result = await permission.request();
      if (!result.isGranted) {
        _showSnackBar("Permission not granted for $source. Opening settings...");
        await openAppSettings();
      }
      return result.isGranted;
    } catch (e) {
      _showSnackBar("Permission request failed: ${e.toString()}");
      return false;
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> _navigateToCreatePost2() async {
    if (_selectedImage == null) {
      _showSnackBar("Please select an image first");
      return;
    }

    try {
      final newPost = await Navigator.push<CommunityPost>(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePost2(selectedImage: _selectedImage!),
        ),
      );

      if (newPost != null && mounted) {
        Navigator.pop(context, newPost);
      }
    } catch (e) {
      _showSnackBar("Navigation error: ${e.toString()}");
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'New Post',
                style: TextStyle(
                  color: Color(0xFF003C26),
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 330,
                height: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : const AssetImage('assets/placeholder.png')
                    as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => _pickImage(ImageSource.gallery),
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0xFF147351),
                        child: Icon(Icons.image, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => _pickImage(ImageSource.camera),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFEBF3F1),
                        child: Icon(Icons.camera_alt, color: Color(0xFF147351)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (_galleryImages.isNotEmpty)
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _galleryImages.length > 6 ? 6 : _galleryImages.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<File?>(
                        future: _galleryImages[index].file,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox(
                              width: 70,
                              height: 70,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          return GestureDetector(
                            onTap: () => setState(() => _selectedImage = snapshot.data!),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.file(
                                snapshot.data!,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _galleryImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    return FutureBuilder<File?>(
                      future: _galleryImages[index].file,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return GestureDetector(
                          onTap: () => setState(() => _selectedImage = snapshot.data!),
                          child: Image.file(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: _navigateToCreatePost2,
                  child: Container(
                    width: 240,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF147351),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      shadows: [
                        const BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, -1),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
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
      ),
    );
  }
}