import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gogreen/Community/CommunityPage.dart';
import 'respondes_post_model.dart';
import 'response_data.dart';

class ResponsePosted extends StatelessWidget {
  const ResponsePosted({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = ResponseData.posts;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF003C26), size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CommunityPostScreen()),
            );
          },
        ),
        title: const Text(
          'Responses',
          style: TextStyle(
            color: Color(0xFF003C26),
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image.asset(post.userImage),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.userName),
                      const Text(
                        'Waiting Verification',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF003C26),
                          fontSize: 10,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(post.timeAgo),
                ),
                Image.file(File(post.imagePath)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/img_72.png', width: 24, height: 24), // Image for Dislike count
                          Text(
                            '6',
                            style: TextStyle(
                              color: const Color(0xFF147351),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10), // Small space between counters
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/img_71.png', width: 24, height: 24), // Image for Like count
                          Text(
                            '0',
                            style: TextStyle(
                              color: const Color(0xFF147351),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/img_71.png', width: 24, height: 24), // Image for Dislike
                          Text(
                            'Like',
                            style: TextStyle(
                              color: const Color(0xFF147351),
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/img_72.png', width: 24, height: 24), // Image for Like
                          Text(
                            'Dislike',
                            style: TextStyle(
                              color: const Color(0xFF147351),
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Placeholder class for CommunityPostScreen (replace with actual implementation)
