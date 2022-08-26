import 'package:flutter/material.dart';
import 'package:test_app/components/custom_albums_preview_button.dart';
import 'package:test_app/components/preview_title.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/aditional_info/elements/albums/elements/albums_item.dart';

class AlbumPreview extends StatelessWidget {
  final List<Album> albums;
  const AlbumPreview({
    Key? key,
    required this.albums,
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
              const PrewievTitle(title: 'Albums'),
              CustomAlbumsPreviewButton(
                albums: albums,
                title: 'All albums',
              )
            ],
          ),
          AlbumsItem(album: albums[0]),
          AlbumsItem(album: albums[1]),
          AlbumsItem(album: albums[2]),
        ],
      ),
    );
  }
}
