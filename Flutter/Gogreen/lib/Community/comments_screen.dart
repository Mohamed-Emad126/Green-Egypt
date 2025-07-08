import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347,
      height: 602,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 17,
            top: 26,
            child: Container(width: 41, height: 41, child: Stack()),
          ),
          Positioned(
            left: 115,
            top: 32.50,
            child: Text(
              'Comments',
              style: TextStyle(
                color: const Color(0xFF003C26),
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 7,
            top: 449,
            child: Container(width: 32, height: 32),
          ),
          Positioned(
            left: 97,
            top: 187,
            child: Container(
              width: 136,
              height: 136,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Stack(),
            ),
          ),
          Positioned(
            left: 84,
            top: 323,
            child: Text(
              'No Comments Yet',
              style: TextStyle(
                color: const Color(0xFF003C26),
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 356,
            child: SizedBox(
              width: 293,
              child: Text(
                'Be the first to comment and help make a difference',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF383F3C),
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 524,
            child: Container(
              width: 323,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://placehold.co/32x32"),
                        fit: BoxFit.fill,
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                  Container(
                    width: 288,
                    height: 54,
                    padding: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD7E9E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 272,
                          child: Text(
                            'Write a comment',
                            style: TextStyle(
                              color: const Color(0xFF709283),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 255,
                          top: 7,
                          child: Container(
                            width: 25,
                            height: 25,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF147351),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 6,
                                  top: 6,
                                  child: Container(width: 14, height: 14, child: Stack()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}