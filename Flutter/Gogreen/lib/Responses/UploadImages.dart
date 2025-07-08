import 'package:flutter/material.dart';

class UploadResponse extends StatelessWidget {
  const UploadResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 40, // Increased from 20 to 40 to move down slightly
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
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
                  const SizedBox(width: 10), // Space between icon and text
                  Text(
                    'Upload Response',
                    style: TextStyle(
                      color: Color(0xFF003C26),
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 40,
              top: 219,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/selectresponse');
                },
                child: Container(
                  width: 311,
                  height: 322,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: Color(0xFFD9D9D9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 84,
                        top: 67,
                        child: Container(
                          width: 136,
                          height: 136,
                          decoration: ShapeDecoration(
                            color: Color(0xFF147351),
                            shape: OvalBorder(),
                          ),
                          child: Center(
                            child: Image.asset(
                              'images/img_70.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 43,
                        top: 224,
                        child: Text(
                          'Upload Response Image',
                          style: TextStyle(
                            color: Color(0xFF003C26),
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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