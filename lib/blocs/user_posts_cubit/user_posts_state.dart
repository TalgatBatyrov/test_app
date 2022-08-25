import 'package:test_app/models/post.dart';

abstract class UserPostsState {}

// Нет юзеров
class UserPostsEmptyState extends UserPostsState {}

// Идет процесс загрузки
class UserPostsLoadingState extends UserPostsState {}

// Данные успешно загружены

class UserPostLoadedState extends UserPostsState {
  List<Post> posts;
  UserPostLoadedState({required this.posts});
}

// Произошла ошибка
class UserPostsErrorState extends UserPostsState {}
