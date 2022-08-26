import 'package:flutter/material.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/pages/post_comments.dart';
import 'package:test_app/styles/styles.dart';

class PostsItem extends StatelessWidget {
  final Post post;
  const PostsItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Styles.grey,
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
            style: const TextStyle(
              fontSize: 18,
              color: Styles.titleColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            post.body,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          style: ListTileStyle.drawer),
    );
  }
}
