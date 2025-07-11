import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class VerificationTree extends StatelessWidget {
  final String? imagePath;

  const VerificationTree({Key? key, this.imagePath}) : super(key: key);

  String _getImageMimeSubtype(String filePath) {
    final ext = path.extension(filePath).toLowerCase();
    if (ext == '.png') return 'png';
    return 'jpeg';
  }

  Future<String> _diagnoseTree(String? imagePath, BuildContext context) async {
    if (imagePath == null || !File(imagePath).existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الصورة غير موجودة أو غير صالحة')),
      );
      return '/DiagnoseGood0';
    }

    try {
      print('--- IMAGE DEBUG ---');
      print('Path: $imagePath');
      print('Exists: ${File(imagePath).existsSync()}');
      print('Size: ${File(imagePath).lengthSync()} bytes');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://fd2d0818a39b.ngrok-free.app/api/model/detect-disease'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imagePath,
          contentType: MediaType('image', _getImageMimeSubtype(imagePath)),
        ),
      );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print('API Response: $responseBody');
      var data = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        final className = data['data']['class']?.toString().toLowerCase() ?? 'unclear';
        final confidence = data['data']['confidence']?.toDouble() ?? 0.0;

        if (confidence < 0.5 || className.contains('unclear')) {
          return '/DiagnoseGood0';
        } else if (className.contains('healthy') || className.contains('good')) {
          return '/DiagnoseGood';
        } else if (className.contains('blight') || className.contains('rust')) {
          return '/DiagnoseBad';
        } else {
          return '/DiagnoseGood0';
        }
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: ${data['errors']?.first['msg'] ?? 'صورة غير صالحة'}')),
        );
        return '/DiagnoseGood0';
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('غير مصرح، تحقق من الـ API')),
        );
        return '/DiagnoseGood0';
      } else if (response.statusCode == 503) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الخدمة غير متاحة حاليًا')),
        );
        return '/DiagnoseGood0';
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: ${response.statusCode} - $responseBody')),
        );
        return '/DiagnoseGood0';
      }
    } catch (e) {
      print('Exception Details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل إرسال الصورة: $e')),
      );
      return '/DiagnoseGood0';
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));

    return Scaffold(
      body: Container(
        width: 390.w,
        height: 844.h,
        decoration: ShapeDecoration(
          color: const Color(0xFFE5F5EF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 17.w,
              top: 65.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close, size: 30.sp, color: const Color(0xFF003C26)),
              ),
            ),
            Positioned(
              left: 64.w,
              top: 148.h,
              child: Container(
                width: 263.w,
                height: 322.h,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: imagePath != null
                        ? FileImage(File(imagePath!))
                        : const AssetImage("assets/images/img_verification_tree.png") as ImageProvider,
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 64.90.w,
              top: 148.h,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: 262.10.w,
                  height: 322.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 63.5.w,
              top: 503.h,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final result = await _diagnoseTree(imagePath, context);
                      Navigator.pushNamed(context, result, arguments: imagePath);
                    },
                    child: Container(
                      width: 263.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF147351),
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Diagnose Tree',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: '18 Khebrat Musamim',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/createPost');
                    },
                    child: Container(
                      width: 263.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF147351),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Center(
                        child: Text(
                          'Post In Community',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: '18 Khebrat Musamim',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/scanPage');
                    },
                    child: Container(
                      width: 263.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF147351),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Center(
                        child: Text(
                          'Add a new Tree',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: '18 Khebrat Musamim',
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
      ),
    );
  }
}
