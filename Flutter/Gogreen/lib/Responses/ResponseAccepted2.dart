import 'package:flutter/material.dart';
import 'package:gogreen/scan/addtree.dart';

class ResponseAccepted2 extends StatelessWidget {
  const ResponseAccepted2({super.key});

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

            // Header with Back Icon + Title
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

            // Accepted Text
            Positioned(
              left: 60,
              top: 550,
              child: SizedBox(
                width: 270,
                child: Text(
                  'Your Response was accepted',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF003C26),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: -0.44,
                  ),
                ),
              ),
            ),

            // Sub Text (analysis reward)
            Positioned(
              left: 30,
              top: 580,
              child: SizedBox(
                width: 330,
                child: Text(
                  'Request an analysis of your response to get your reward',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: -0.44,
                  ),
                ),
              ),
            ),

            // NEW BUTTON under the text
            Positioned(
              left: 67,
              top: 700,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddTree()),
                  );
                },
                child: Container(
                  width: 255,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: ShapeDecoration(
                    color: Color(0xFF147351),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Locate Tree',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Dimmed Image background
            Positioned(
              left: 54,
              top: 250,
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

            // Placeholder for Center Image
            Positioned(
              left: 149,
              top: 283,
              child: Container(
                width: 101,
                height: 101,
              ),
            ),

            // Points Container
            Positioned(
              left: 26,
              top: 618,
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
          ],
        ),
      ),
    );
  }
}
