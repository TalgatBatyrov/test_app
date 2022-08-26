import 'package:flutter/material.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/styles/styles.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/aditional_info/components/albums/elements/albums_item.dart';

class AlbumsPreviewPage extends StatelessWidget {
  final List<Album> albums;
  const AlbumsPreviewPage({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        backgroundColor: Styles.bgColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: albums.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black.withOpacity(0.33),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final album = albums[index];
                return AlbumsItem(album: album);
              },
            ),
          ),
        ],
      ),
    );
  }
}
