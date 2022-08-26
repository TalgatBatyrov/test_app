import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/photos_cubit/photos_state.dart';
import 'package:test_app/models/photos.dart';
import 'package:test_app/services/user_api.dart';

class PhotosCubit extends Cubit<PhotosState> {
  PhotosCubit() : super(PhotosLoadingState());

  Future<void> fetchPhotos(int id) async {
    try {
      emit(PhotosLoadingState());
      final List<Photos> loadedUserList = await UserApi().getPhotos(id);
      emit(PhotosLoadedState(photos: loadedUserList));
    } catch (e) {
      emit(PhotosErrorState());
    }
  }
}
