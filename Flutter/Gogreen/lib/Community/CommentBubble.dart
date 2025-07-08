import 'package:flutter/material.dart';

class CommentBubble extends StatelessWidget {
  final String userName;
  final String userImage;
  final String text;
  final String time;
  final VoidCallback onMore;

  const CommentBubble({
    super.key,
    required this.userName,
    required this.userImage,
    required this.text,
    required this.time,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(userImage),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFC4DCD3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: onMore,
                      child: const Icon(Icons.more_vert, size: 18, color: Color(0xFF003C26)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 13, color: Colors.black),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF003C26)),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Reply',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF003C26),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
