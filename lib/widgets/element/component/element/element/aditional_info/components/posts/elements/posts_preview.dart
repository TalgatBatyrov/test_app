import 'package:flutter/material.dart';
import 'package:test_app/components/custom_posts_preview_button.dart';
import 'package:test_app/components/preview_title.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/widgets/element/component/element/element/aditional_info/components/posts/elements/posts_item.dart';

class PostsPreview extends StatelessWidget {
  final List<Post> posts;
  const PostsPreview({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const PrewievTitle(title: 'Posts'),
              CustomPostsPreviewButton(title: 'All Posts', posts: posts)
            ],
          ),
          if (posts.isNotEmpty) PostsItem(post: posts[0]),
          if (posts.length >= 2) PostsItem(post: posts[1]),
          if (posts.length >= 3) PostsItem(post: posts[2]),
        ],
      ),
    );
  }
}
