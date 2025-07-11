import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:gogreen/scan/Verficationtree.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  String? _imagePath;

  // تأكد من تغيير هذا إلى رابط ngrok الخاص بك
  final String _baseUrl = "https://c7f4a211929c.ngrok-free.app";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا توجد كاميرا متاحة')),
        );
        return;
      }
      _cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _cameraController!.initialize();
      await _initializeControllerFuture;
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e')),
      );
    }
  }

  Future<void> _detectObjects(String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/api/object/detect-objects'), // مهم: مطابق للـ route في Express
      );
      request.files.add(await http.MultipartFile.fromPath('image', imagePath)); // مهم: اسم الحقل

      request.headers['ngrok-skip-browser-warning'] = 'true';

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        var detections = data['data']['detections'] as List;

        // شوف إذا فيه شجرة بثقة عالية
        bool isTree = detections.any(
              (d) => (d['label'].toString().toLowerCase() == 'tree') && (d['confidence'] > 0.5),
        );

        if (isTree) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم التعرف على شجرة بنجاح')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationTree(imagePath: imagePath),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('الصورة ليست لشجرة، أعد المحاولة')),
          );
          setState(() {
            _imagePath = null;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في الاستجابة: ${response.statusCode}')),
        );
        setState(() {
          _imagePath = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء الكشف: $e')),
      );
      setState(() {
        _imagePath = null;
      });
    }
  }

  Future<void> _takePicture() async {
    try {
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        await _initializeControllerFuture;
        final image = await _cameraController!.takePicture();
        setState(() {
          _imagePath = image.path;
        });
        await _detectObjects(_imagePath!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الكاميرا غير جاهزة')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء التقاط الصورة: $e')),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
        await _detectObjects(_imagePath!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء اختيار الصورة: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
    );

    return Scaffold(
      body: Container(
        width: 390.w,
        height: 844.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFEBF3F1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 390.w,
                height: 687.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                ),
                child: _imagePath != null
                    ? Image.file(
                  File(_imagePath!),
                  fit: BoxFit.cover,
                )
                    : FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (_cameraController != null &&
                          _cameraController!.value.isInitialized) {
                        return CameraPreview(_cameraController!);
                      } else {
                        return const Center(child: Text('فشل تحميل الكاميرا'));
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text('خطأ: ${snapshot.error}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            Positioned(
              left: 32.w,
              top: 106.h,
              child: Container(
                width: 327.w,
                height: 470.h,
                decoration: ShapeDecoration(
                  color: const Color(0x26D9D9D9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 3.w,
                      color: const Color(0xFF58BD64),
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 159.w,
              top: 708.h,
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 93.w,
                  height: 87.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF147351),
                    shape: const OvalBorder(),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 45.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 296.w,
              top: 723.h,
              child: GestureDetector(
                onTap: _pickImageFromGallery,
                child: Container(
                  width: 48.w,
                  height: 45.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFADCEC2),
                    shape: const OvalBorder(),
                  ),
                  child: Icon(
                    Icons.photo_library,
                    size: 24.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
