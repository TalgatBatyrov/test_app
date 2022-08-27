import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/theme_cubit/theme_cubit.dart';
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
    final themeCubit = context.watch<ThemeCubit>();
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
          style: TextStyle(
            fontSize: 18,
            color: themeCubit.isLight ? Styles.lightColor : Styles.nightColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ListTileStyle.drawer,
      ),
    );
  }
}
