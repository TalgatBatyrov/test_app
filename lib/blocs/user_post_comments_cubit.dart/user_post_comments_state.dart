import 'package:test_app/models/comment.dart';

abstract class UserPostCommentsState {}

// Нет данных
class UserPostCommentsEmptyState extends UserPostCommentsState {}

// Идет процесс загрузки
class UserPostCommentsLoadingState extends UserPostCommentsState {}

// Данные успешно загружены

class UserPostCommentsLoadedState extends UserPostCommentsState {
  List<Comment> comments;
  UserPostCommentsLoadedState({required this.comments});
}

// Произошла ошибка
class UserPostCommentsErrorState extends UserPostCommentsState {}
