import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:gogreen/scan/Verficationtree.dart';
import 'package:permission_handler/permission_handler.dart';
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
  final String _baseUrl = "https://647aef618e72.ngrok-free.app"; // تأكد إن الرابط شغال

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
          SnackBar(content: Text('لا توجد كاميرا متاحة')),
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
        SnackBar(content: Text('خطأ: $e. تأكد من تثبيت الإضافة وإعادة بناء التطبيق')),
      );
    }
  }

  Future<void> _detectObjects(String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/api/object/detect-objects'),
      );
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      request.headers['ngrok-skip-browser-warning'] = 'true';

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        var detections = data['data']['detections'] as List;
        bool isTree = detections.any((d) => d['label'] == 'tree' && d['confidence'] > 0.5);

        if (isTree) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Object detection completed successfully')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationTree(imagePath: imagePath),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('الكائن ليس شجرة، أعد المحاولة')),
          );
          setState(() {
            _imagePath = null; // مسح الصورة
          });
        }
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: ${data['errors'][0]['msg']}')),
        );
        setState(() {
          _imagePath = null;
        });
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('غير مخول: ${data['message']}')),
        );
        setState(() {
          _imagePath = null;
        });
      } else if (response.statusCode == 503) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الخدمة غير متوفرة حاليًا')),
        );
        setState(() {
          _imagePath = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: ${response.statusCode}')),
        );
        setState(() {
          _imagePath = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء الكشف عن الأشياء: $e')),
      );
      setState(() {
        _imagePath = null;
      });
    }
  }

  // دالة لالتقاط الصورة
  Future<void> _takePicture() async {
    try {
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        await _initializeControllerFuture;
        final image = await _cameraController!.takePicture();
        setState(() {
          _imagePath = image.path;
        });
        await _detectObjects(_imagePath!); // استدعاء الكشف عن الأشياء
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الكاميرا غير جاهزة')),
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
                      if (_cameraController != null && _cameraController!.value.isInitialized) {
                        return CameraPreview(_cameraController!);
                      } else {
                        return Center(child: Text('فشل تحميل الكاميرا'));
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
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 0.50.w,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: const Color(0xFFDADADA),
                      ),
                    ),
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
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 0.50.w,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: const Color(0xFFDADADA),
                      ),
                    ),
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