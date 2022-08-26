import 'package:flutter/material.dart';
import 'package:test_app/components/custom_posts_preview_button.dart';
import 'package:test_app/components/preview_title.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/aditional_info/elements/posts/elements/post_item.dart';

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
          PostItem(post: posts[0]),
          PostItem(post: posts[1]),
          PostItem(post: posts[2]),
        ],
      ),
    );
  }
}
