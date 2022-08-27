import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/blocs/user_albums_cubit/user_albums_state.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/services/user_api.dart';

class UserAlbumCubit extends Cubit<UserAlbumsState> {
  UserAlbumCubit() : super(UserAlbumsLoadingState());

  Future<void> fetchAlbums(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      emit(UserAlbumsLoadingState());

      final List<Album> albums = await UserApi().getUserAlbums(id);

      final cacheAlbums = prefs.getString('albums');
      if (cacheAlbums != null) {
        final List<dynamic> decodePosts = json.decode(cacheAlbums);
        final models = decodePosts.map((e) => Album.fromJson(e)).toList();
        emit(UserAlbumsLoadedState(albums: models));
      } else {
        emit(UserAlbumsLoadedState(albums: albums));
      }
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final cacheAlbums = prefs.getString('albums');
      if (cacheAlbums != null) {
        final List<dynamic> decodePosts = json.decode(cacheAlbums);
        final models = decodePosts.map((e) => Album.fromJson(e)).toList();
        emit(UserAlbumsLoadedState(albums: models));
      } else {
        emit(UserAlbumsErrorState());
      }
    }
  }
}
