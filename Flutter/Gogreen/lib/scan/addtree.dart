import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/Responses/Addtreeimage.dart';

class AddTree extends StatefulWidget {
  const AddTree({Key? key}) : super(key: key);

  @override
  _AddTreeState createState() => _AddTreeState();
}

class _AddTreeState extends State<AddTree> {
  String selectedStatus = 'Tree Status';
  File? _selectedImage;

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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.r),
        ),
        child: Stack(
          children: [
            // ✅ Back Arrow + Title
            Positioned(
              left: 20.w,
              top: 60.h,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: const Color(0xFF003C26),
                      size: 23.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Add Tree',
                    style: TextStyle(
                      color: const Color(0xFF003C26),
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Form Fields
            Positioned(
              left: 30.w,
              top: 120.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Tree Photo Section
                  Text(
                    'Tree Photo',
                    style: TextStyle(
                      color: const Color(0xFF003C26),
                      fontSize: 18.sp,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () async {
                      final pickedImage = await Navigator.push<File?>(
                        context,
                        MaterialPageRoute(builder: (context) => const Addtreeimage()),
                      );
                      if (pickedImage != null) {
                        setState(() {
                          _selectedImage = pickedImage;
                        });
                      }
                    },
                    child: Container(
                      width: 330.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF3F1),
                        border: Border.all(color: const Color(0xFF98A09C)),
                        borderRadius: BorderRadius.circular(10.r),
                        image: _selectedImage != null
                            ? DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: _selectedImage == null
                          ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'images/img_69.png',
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'add photo',
                              style: TextStyle(
                                color: const Color(0xFF003C26),
                                fontSize: 16.sp,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      )
                          : null,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // ✅ Location Section
                  Text(
                    'Location',
                    style: TextStyle(
                      color: const Color(0xFF003C26),
                      fontSize: 18.sp,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 300.w,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3F1),
                      border: Border.all(color: const Color(0xFF98A09C), width: 0.2.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      'Enter location or use current',
                      style: TextStyle(
                        color: const Color(0xFF709283),
                        fontSize: 16.sp,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // ✅ Health Status Section
                  Text(
                    'Health Status',
                    style: TextStyle(
                      color: const Color(0xFF003C26),
                      fontSize: 18.sp,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTapDown: (details) async {
                      final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

                      final selected = await showMenu<String>(
                        context: context,
                        position: RelativeRect.fromRect(
                          details.globalPosition & const Size(40, 40),
                          Offset.zero & overlay.size,
                        ),
                        items: [
                          PopupMenuItem(
                            enabled: false,
                            child: Container(
                              width: 251.w,
                              height: 91.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFDFE7E5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                shadows: [
                                  const BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context, 'Healthy');
                                    },
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Healthy',
                                          groupValue: selectedStatus,
                                          onChanged: (_) {},
                                        ),
                                        const Text('Healthy'),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context, 'Need Care');
                                    },
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Need Care',
                                          groupValue: selectedStatus,
                                          onChanged: (_) {},
                                        ),
                                        const Text('Need Care'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );

                      if (selected != null) {
                        setState(() {
                          selectedStatus = selected;
                        });
                      }
                    },
                    child: Container(
                      width: 300.w,
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF3F1),
                        border: Border.all(color: const Color(0xFF98A09C), width: 0.2.w),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedStatus,
                            style: TextStyle(
                              color: const Color(0xFF709283),
                              fontSize: 16.sp,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: const Color(0xFF709283),
                            size: 24.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // ✅ Register Tree button
                  Container(
                    width: 270.w,
                    margin: EdgeInsets.only(left: 15.w),
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF147351),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    child: Text(
                      'Register Tree',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
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
