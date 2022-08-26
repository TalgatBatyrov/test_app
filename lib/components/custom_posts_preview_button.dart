import 'package:flutter/material.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/pages/posts_preview_page.dart';

class CustomPostsPreviewButton extends StatelessWidget {
  final String title;
  final List<Post> posts;
  const CustomPostsPreviewButton({
    Key? key,
    required this.posts,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostsPreviewPage(posts: posts),
          ),
        );
      },
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
