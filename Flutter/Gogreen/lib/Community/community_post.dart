class CommunityPost {
  final String userName;
  final String userImage;
  final String timeAgo;
  final String postText;
  final String location;
  final String imagePath;
  final int likes;
  final int comments;

  CommunityPost({
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.postText,
    required this.location,
    required this.imagePath,
    required this.likes,
    required this.comments,
  });
}
