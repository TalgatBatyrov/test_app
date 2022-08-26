import 'package:flutter/material.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/pages/photos.dart';
import 'package:test_app/styles/styles.dart';

class AlbumsItem extends StatelessWidget {
  final Album album;
  const AlbumsItem({
    Key? key,
    required this.album,
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
              builder: (context) => Photos(albumId: album.id),
            ),
          );
        },
        leading: Text('${album.id}'),
        title: Text(
          album.title,
          style: const TextStyle(
            fontSize: 18,
            color: Styles.titleColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ListTileStyle.drawer,
      ),
    );
  }
}
