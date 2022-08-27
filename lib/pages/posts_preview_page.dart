import 'package:flutter/material.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/styles/styles.dart';
import 'package:test_app/widgets/element/component/element/element/aditional_info/components/posts/elements/posts_item.dart';

class PostsPreviewPage extends StatelessWidget {
  final List<Post> posts;
  const PostsPreviewPage({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Styles.bgColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black.withOpacity(0.33),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                return PostsItem(post: post);
              },
            ),
          ),
        ],
      ),
    );
  }
}
