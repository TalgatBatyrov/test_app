import 'package:flutter/material.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/pages/albums_preview_page.dart';
import 'package:test_app/styles/styles.dart';

class CustomAlbumsPreviewButton extends StatelessWidget {
  final String title;
  final List<Album> albums;
  const CustomAlbumsPreviewButton({
    Key? key,
    required this.albums,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumsPreviewPage(albums: albums),
          ),
        );
      },
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Styles.titleColor,
        ),
      ),
    );
  }
}
