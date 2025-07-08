import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gogreen/Community/community_post.dart';
import 'package:permission_handler/permission_handler.dart';

class CreatePost2 extends StatefulWidget {
  final File? selectedImage;
  const CreatePost2({super.key, required this.selectedImage});

  @override
  State<CreatePost2> createState() => _CreatePost2State();
}

class _CreatePost2State extends State<CreatePost2> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  bool _isPosting = false;
  List<bool> _isPressed = [false, false, false];
  bool _showLocationDialog = false;
  bool _showPermissionDialog = false;
  final FocusNode _captionFocusNode = FocusNode();

  @override
  void dispose() {
    _descriptionController.dispose();
    _captionController.dispose();
    _captionFocusNode.dispose();
    super.dispose();
  }

  Future<void> _uploadPost() async {
    if (widget.selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
      return;
    }

    setState(() => _isPosting = true);

    try {
      final newPost = CommunityPost(
        userName: 'Adham Ehab',
        userImage: 'images/img_53.png',
        timeAgo: 'Just now',
        postText: _descriptionController.text,
        location: 'Zagazig',
        imagePath: widget.selectedImage!.path,
        likes: 0,
        comments: 0,
      );
      if (mounted) {
        Navigator.of(context).pop(newPost);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isPosting = false);
    }
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      status = await Permission.locationWhenInUse.request();
    }
    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission granted')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission denied')),
      );
    }
    setState(() => _showPermissionDialog = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF003C26)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(
            color: Color(0xFF003C26),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.selectedImage == null)
                    const Center(child: Text('No image selected'))
                  else
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(widget.selectedImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Container(
                    width: 340,
                    height: 89,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEBF3F1),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.50,
                          color: Color(0xFF98A09C),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                          child: Text(
                            'What is the type of Problem..?',
                            style: TextStyle(
                              color: Color(0xFF709283),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          children: [
                            _buildProblemButton(0, 'Tree Planters', 108),
                            _buildProblemButton(1, 'Tree Care & Issue', 134),
                            _buildProblemButton(2, 'Others', 63),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_captionFocusNode);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEBF3F1),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0.50,
                            color: Color(0xFF98A09C),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _captionController,
                        focusNode: _captionFocusNode,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'Add a caption...',
                          hintStyle: TextStyle(
                            color: Color(0xFF709283),
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Color(0xFF003C26),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showLocationDialog = true;
                      });
                    },
                    child: Container(
                      width: 181,
                      height: 45,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEBF3F1),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0.50,
                            color: Color(0xFF98A09C),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: const [
                          Icon(Icons.location_on,
                              color: Color(0xFF709283), size: 16),
                          SizedBox(width: 8),
                          Text('Add Location',
                              style: TextStyle(color: Color(0xFF709283))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isPosting ? null : _uploadPost,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF147351),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isPosting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showLocationDialog) _buildLocationDialog(),
          if (_showPermissionDialog) _buildPermissionDialog(),
        ],
      ),
    );
  }

  Widget _buildProblemButton(int index, String text, double width) {
    return InkWell(
      onTap: () {
        setState(() {
          _isPressed = List.generate(3, (i) => i == index);
        });
      },
      child: Container(
        width: width,
        height: 27,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        decoration: ShapeDecoration(
          color: _isPressed[index]
              ? const Color(0xFF147351)
              : const Color(0xFFEBF3F1),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.50,
              color: Color(0xFF709283),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: _isPressed[index]
                    ? Colors.white
                    : const Color(0xFF003C26),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationDialog() {
    return _buildCustomDialog(
      message:
      'To help us show nearby spots needing tree care, GoGreen needs location access.',
      leftButton: 'Not Now',
      rightButton: 'Continue',
      onLeftTap: () {
        setState(() {
          _showLocationDialog = false;
        });
      },
      onRightTap: () {
        setState(() {
          _showLocationDialog = false;
          _showPermissionDialog = true;
        });
      },
    );
  }

  Widget _buildPermissionDialog() {
    return _buildCustomDialog(
      message:
      'To allow the app to show nearby spots needing tree care, GoGreen needs location access.',
      leftButton: "Don't Allow",
      rightButton: 'Allow',
      onLeftTap: () {
        setState(() {
          _showPermissionDialog = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')),
          );
        });
      },
      onRightTap: () {
        _requestLocationPermission();
      },
    );
  }

  Widget _buildCustomDialog({
    required String message,
    required String leftButton,
    required String rightButton,
    required VoidCallback onLeftTap,
    required VoidCallback onRightTap,
  }) {
    return GestureDetector(
      onTap: () => setState(() {
        _showLocationDialog = false;
        _showPermissionDialog = false;
      }),
      child: Container(
        color: Colors.black54,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            width: 346,
            height: 264,
            child: Stack(
              children: [
                Positioned(
                  left: 9,
                  top: 0,
                  child: Container(
                    width: 328,
                    height: 264,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEBF3F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 11,
                  top: 93,
                  child: SizedBox(
                    width: 323,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 22,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 191,
                  child: Container(
                    width: 327,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFDADADA)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 172,
                  top: 191,
                  child: Container(
                    transform: Matrix4.identity()..rotateZ(1.57),
                    width: 73,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFDADADA)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 41,
                  top: 213,
                  child: GestureDetector(
                    onTap: onLeftTap,
                    child: Text(
                      leftButton,
                      style: const TextStyle(
                        color: Color(0xFF147351),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 211,
                  top: 213,
                  child: GestureDetector(
                    onTap: onRightTap,
                    child: Text(
                      rightButton,
                      style: const TextStyle(
                        color: Color(0xFF147351),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 0,
                  child: Container(
                    width: 328,
                    height: 71,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF147351),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}