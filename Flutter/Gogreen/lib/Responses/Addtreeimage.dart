import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class Addtreeimage extends StatefulWidget {
  const Addtreeimage({super.key});

  @override
  State<Addtreeimage> createState() => _AddtreeimageState();
}

class _AddtreeimageState extends State<Addtreeimage> {
  File? _selectedImage;
  List<AssetEntity> _galleryImages = [];
  bool _isLoading = false;

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
        _showSnackBar("تم رفض الإذن للوصول إلى المعرض. من فضلك، اسمح بالوصول يدويًا.");
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
      _showSnackBar("خطأ في تحميل المعرض: ${e.toString()}");
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isLoading = true);

      final status = await _requestPermission(source);
      if (!status) {
        _showSnackBar("تم رفض الإذن لـ $source. من فضلك، اسمح بالوصول يدويًا.");
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
        _showSnackBar("لم يتم اختيار صورة من $source");
      }
    } catch (e) {
      _showSnackBar("خطأ في اختيار الصورة: ${e.toString()}");
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
        _showSnackBar("لم يتم منح الإذن لـ $source. من فضلك، اسمح بالوصول يدويًا.");
      }
      return result.isGranted;
    } catch (e) {
      _showSnackBar("فشل طلب الإذن: ${e.toString()}");
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Color(0xFF003C26),
                        size: 55,
                      ),
                    ),
                    const Text(
                      'Add Tree Photo',
                      style: TextStyle(
                        color: Color(0xFF003C26),
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 30), // لموازنة الـ Row
                  ],
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    if (_selectedImage != null) {
                      Navigator.pop(context, _selectedImage);
                    } else {
                      _showSnackBar("من فضلك، اختر صورة أولاً");
                    }
                  },
                  child: Container(
                    width: 240,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF147351),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Done',
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