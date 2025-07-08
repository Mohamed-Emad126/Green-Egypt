import 'package:flutter/material.dart';

class ResponseRejected extends StatelessWidget {
  const ResponseRejected({super.key});

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
            // Status Bar Placeholder
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 390,
                height: 44,
              ),
            ),

            // Header with Back Icon and Title
            Positioned(
              left: 0,
              top: 64,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF003C26),
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Response',
                      style: TextStyle(
                        color: Color(0xFF003C26),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Background Image
            Positioned(
              left: 48,
              top: 190,
              child: Opacity(
                opacity: 0.50,
                child: Container(
                  width: 283,
                  height: 268,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/img_74.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),

            // Center Image Placeholder
            Positioned(
              left: 145,
              top: 283,
              child: Container(
                width: 101,
                height: 101,
              ),
            ),

            // Main Rejected Text
            Positioned(
              left: 65,
              top: 499,
              child: Text(
                'Your Response was rejected',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF003C26),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                  letterSpacing: -0.44,
                ),
              ),
            ),

            // Sub Text
            Positioned(
              left: 24,
              top: 536,
              child: SizedBox(
                width: 338,
                child: Text(
                  'the number of received dislikes more than likes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                    letterSpacing: -0.40,
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
