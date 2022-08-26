import 'package:test_app/models/photos.dart';

abstract class PhotosState {}

// Нет данных
class PhotosEmptyState extends PhotosState {}

// Идет загрузка
class PhotosLoadingState extends PhotosState {}

// Данные успешно загружены

class PhotosLoadedState extends PhotosState {
  List<Photos> photos;
  PhotosLoadedState({required this.photos});
}

// Произошла ошибка
class PhotosErrorState extends PhotosState {}
