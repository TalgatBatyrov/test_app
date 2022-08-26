import 'package:flutter/material.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/pages/post_comments.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(107, 158, 158, 158),
      elevation: 0,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostComments(postId: post.id),
            ),
          );
        },
        leading: Text('${post.id}'),
        title: Text(
          post.title,
          style: const TextStyle(fontSize: 18),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          post.body,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        style: ListTileStyle.drawer,
      ),
    );
  }
}
