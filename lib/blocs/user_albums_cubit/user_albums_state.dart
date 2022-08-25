import 'package:test_app/models/album.dart';

abstract class UserAlbumsState {}

// Нет юзеров
class UserAlbumsEmptyState extends UserAlbumsState {}

// Идет процесс загрузки
class UserAlbumsLoadingState extends UserAlbumsState {}

// Данные успешно загружены

class UserAlbumsLoadedState extends UserAlbumsState {
  List<Album> albums;
  UserAlbumsLoadedState({required this.albums});
}

// Произошла ошибка
class UserAlbumsErrorState extends UserAlbumsState {}
