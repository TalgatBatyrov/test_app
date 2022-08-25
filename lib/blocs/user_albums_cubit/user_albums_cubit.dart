import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_albums_cubit/user_albums_state.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/services/user_api.dart';

class UserAlbumCubit extends Cubit<UserAlbumsState> {
  UserAlbumCubit() : super(UserAlbumsLoadingState());

  Future<void> fetchAlbums(int id) async {
    try {
      emit(UserAlbumsLoadingState());
      final List<Album> albums = await UserApi().getUserAlbums(id);
      emit(UserAlbumsLoadedState(albums: albums));
    } catch (e) {
      emit(UserAlbumsErrorState());
    }
  }
}
