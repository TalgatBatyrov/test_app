import 'package:test_app/models/photo.dart';

abstract class PhotosState {}

// Нет данных
class PhotosEmptyState extends PhotosState {}

// Идет загрузка
class PhotosLoadingState extends PhotosState {}

// Данные успешно загружены

class PhotosLoadedState extends PhotosState {
  List<Photo> photos;
  PhotosLoadedState({required this.photos});
}

// Произошла ошибка
class PhotosErrorState extends PhotosState {}
