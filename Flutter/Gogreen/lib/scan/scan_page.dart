import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:gogreen/scan/Verficationtree.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // تهيئة الكاميرا
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
        cameras[0], // اختيار الكاميرا الخلفية
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _cameraController!.initialize();
      await _initializeControllerFuture; // انتظر اكتمال التهيئة
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e. تأكد من تثبيت الإضافة وإعادة بناء التطبيق')),
      );
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
        // الانتقال إلى صفحة VerificationTree بعد التقاط الصورة
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationTree(imagePath: _imagePath!),
          ),
        );
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
                    child: Container(
                      width: 93.w,
                      height: 87.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Icon(
                        Icons.camera_alt,
                        size: 45.sp, // تكبير حجم الأيقونة لتتناسب مع 93w × 87h
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 296.w,
              top: 723.h,
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
                child: IconButton(
                  onPressed: () async {
                    // يمكن إضافة دالة لفتح المعرض هنا إذا لزم الأمر
                  },
                  icon: Icon(
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
}