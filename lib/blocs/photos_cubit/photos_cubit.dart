import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/blocs/photos_cubit/photos_state.dart';
import 'package:test_app/models/photos.dart';
import 'package:test_app/services/user_api.dart';

class PhotosCubit extends Cubit<PhotosState> {
  PhotosCubit() : super(PhotosLoadingState());

  Future<void> fetchPhotos(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      emit(PhotosLoadingState());
      final List<Photos> loadedUserList = await UserApi().getPhotos(id);

      final cachePhotos = prefs.getString('photos');

      if (cachePhotos != null) {
        final List<dynamic> decodeUsers = json.decode(cachePhotos);
        final cachePhotosList =
            decodeUsers.map((e) => Photos.fromJson(e)).toList();
        emit(PhotosLoadedState(photos: cachePhotosList));
      } else {
        emit(PhotosLoadedState(photos: loadedUserList));
      }
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final cachePhotos = prefs.getString('photos');

      if (cachePhotos != null) {
        final List<dynamic> decodeUsers = json.decode(cachePhotos);
        final cachePhotosList =
            decodeUsers.map((e) => Photos.fromJson(e)).toList();
        emit(PhotosLoadedState(photos: cachePhotosList));
      } else {
        emit(PhotosErrorState());
      }
    }
  }
}
