import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gogreen/Community/CommentBubble.dart';
import 'package:gogreen/Community/community_post.dart';
import 'package:gogreen/Community/CreatePostScreen.dart';
import 'package:gogreen/NotificationPage.dart';
import 'package:gogreen/SearchScreen.dart';

class CommunityPostScreen extends StatefulWidget {
  @override
  _CommunityPostScreenState createState() => _CommunityPostScreenState();
}

class _CommunityPostScreenState extends State<CommunityPostScreen> {
  List<CommunityPost> posts = [
    CommunityPost(
      userName: 'Adham Ehab',
      userImage: 'images/img_53.png',
      timeAgo: '3h',
      postText: 'There is a tree that needs some care!',
      location: 'Al-Rawda Mosque',
      imagePath: 'images/img_50.png',
      likes: 65,
      comments: 18,
    ),
  ];

  bool _showComments = false;
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, String>> _comments = [];
  bool _showOptions = false;
  int _selectedCommentIndex = -1;

  Future<void> _handleAddPost() async {
    final newPost = await Navigator.push<CommunityPost>(
      context,
      MaterialPageRoute(builder: (context) => const CreatePost()),
    );

    if (newPost != null) {
      setState(() {
        posts.insert(0, newPost);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم نشر المنشور بنجاح')),
      );
    }
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.insert(0, {'user': 'You', 'text': _commentController.text});
        _commentController.clear();
      });
    }
  }

  void _toggleOptions(int index) {
    setState(() {
      _showOptions = !_showOptions;
      _selectedCommentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildAppBar(context),
                  _buildLocationSection(),
                  _buildCategoryTabs(),
                  ...posts.map((post) => _buildPostItem(post)).toList(),
                ],
              ),
            ),
            if (_showComments)
              GestureDetector(
                onTap: () => setState(() => _showComments = false),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: _buildCommentsSection(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Text(
                          'GoGreen',
                          style: TextStyle(
                            color: const Color(0xFF147351),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Positioned(
                          right: -5,
                          top: 5,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFF147351),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationsPage()),
                        ),
                        child: Image.asset(
                          'images/img_54.png',
                          width: 33,
                          height: 33,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchScreen()),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Color(0xFF147351),
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _handleAddPost,
                    child: Container(
                      width: 39,
                      height: 39,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF147351),
                        shape: OvalBorder(),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostItem(CommunityPost post) {
    return Column(
      children: [
        _buildPostHeader(post),
        _buildPostContent(post),
        _buildPostActions(context, post),
      ],
    );
  }

  Widget _buildPostHeader(CommunityPost post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(post.userImage, width: 47, height: 47),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.userName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      post.timeAgo,
                      style: const TextStyle(
                        color: Color(0xFF98A09C),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFF98A09C),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.public,
                      size: 14,
                      color: Color(0xFF98A09C),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent(CommunityPost post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.postText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            post.location,
            style: const TextStyle(
              color: Color(0xFF147351),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 327,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: _getImageProvider(post),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  ImageProvider _getImageProvider(CommunityPost post) {
    try {
      if (post.imagePath.startsWith('images/')) {
        return AssetImage(post.imagePath);
      }
      return FileImage(File(post.imagePath));
    } catch (e) {
      return AssetImage('images/placeholder.png');
    }
  }

  Widget _buildPostActions(BuildContext context, CommunityPost post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thumb_up, size: 16, color: Color(0xFF0F6848)),
                    const SizedBox(width: 5),
                    Text(
                      post.likes.toString(),
                      style: const TextStyle(
                        color: Color(0xFF0F6848),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    const Icon(Icons.comment, size: 16, color: Color(0xFF0F6848)),
                    const SizedBox(width: 5),
                    Text(
                      post.comments.toString(),
                      style: const TextStyle(
                        color: Color(0xFF0F6848),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFFE8EAEA), height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Image.asset('images/img_52.png', width: 20, height: 20),
                  label: const Text(
                    'Support',
                    style: TextStyle(
                      color: Color(0xFF0F6848),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/uploadResponse');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF147351),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                    child: const Text(
                      'Response',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() => _showComments = true);
                  },
                  icon: const Icon(Icons.comment_outlined, color: Color(0xFF0F6848)),
                  label: const Text(
                    'Comment',
                    style: TextStyle(
                      color: Color(0xFF0F6848),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFFE9EBEA), height: 1),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Container(
      width: 355,
      height: 500,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Comments',
                style: TextStyle(
                  color: Color(0xFF003C26),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Color(0xFF003C26)),
                onPressed: () => setState(() => _showComments = false),
              ),
            ],
          ),
          Divider(),

          // Comments List
          Expanded(
            child: _comments.isEmpty
                ? Center(
              child: Text(
                'No Comments Yet',
                style: TextStyle(
                  color: Color(0xFF003C26),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: CommentBubble(
                    userName: comment['user'] ?? '',
                    userImage: 'images/img_53.png',
                    text: comment['text'] ?? '',
                    time: '10 min',
                    onMore: () => _toggleOptions(index),
                  ),
                );
              },
            ),
          ),

          // Input Row
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/img_53.png'),
                radius: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFD7E9E2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Color(0xFF709283),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: Color(0xFF147351)),
                        onPressed: _addComment,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 20, top: 5, bottom: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: TextStyle(
                color: const Color(0xFF709283),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF003C26),
                  size: 20,
                ),
                Text(
                  'Zagazig',
                  style: TextStyle(
                    color: const Color(0xFF003C26),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF147351),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF3F1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDADADA), width: 0.5),
              ),
              child: Text(
                'Tree Planters',
                style: TextStyle(
                  color: const Color(0xFF003C26),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF3F1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFDADADA), width: 0.5),
              ),
              child: Text(
                'Tree Care & Issues',
                style: TextStyle(
                  color: const Color(0xFF003C26),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}