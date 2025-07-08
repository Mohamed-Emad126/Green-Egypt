import 'package:flutter/material.dart';

class ResponseAccepted extends StatelessWidget {
  const ResponseAccepted({super.key});

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
            // Status bar placeholder
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

            // "Your Response was accepted" text
            Positioned(
              left: 60,
              top: 500,
              child: Text(
                'Your Response was accepted',
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

            // "Congratulation...." text
            Positioned(
              left: 116,
              top: 541,
              child: Text(
                'Congratulation....',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1BA52B),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                  letterSpacing: -0.44,
                ),
              ),
            ),

            // Background Image
            Positioned(
              left: 54,
              top: 199,
              child: Opacity(
                opacity: 0.50,
                child: Container(
                  width: 283,
                  height: 268,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/img_76.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),

            // Center image placeholder
            Positioned(
              left: 149,
              top: 283,
              child: Container(
                width: 101,
                height: 101,
              ),
            ),

            // Bottom points container background
            Positioned(
              left: 26,
              top: 568,
              child: Container(
                width: 338,
                height: 76,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // "You Earn" text
            Positioned(
              left: 60,
              top: 596,
              child: SizedBox(
                width: 90,
                child: Text(
                  'You Earn ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xAF383F3C),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            // "Points" text
            Positioned(
              left: 259,
              top: 596,
              child: SizedBox(
                width: 62,
                child: Text(
                  'Points',
                  style: TextStyle(
                    color: Color(0xAF383F3C),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            // Points Row (Star + Number)
            Positioned(
              left: 150,
              top: 585,
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Image.asset(
                    'images/img_75.png',
                    width: 41,
                    height: 41,
                  ),
                  Text(
                    '20',
                    style: TextStyle(
                      color: Color(0xFFE3B62D),
                      fontSize: 36,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
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
