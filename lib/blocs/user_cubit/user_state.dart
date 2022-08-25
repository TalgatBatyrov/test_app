// Общее сотояние
import 'package:test_app/models/user.dart';

abstract class UserState {}

// Нет юзеров
class UserEmptyState extends UserState {}

// Идет процесс загрузки
class UserLoadingState extends UserState {}

// Данные успешно загружены
class UserLoadedState extends UserState {
  List<User> users;
  UserLoadedState({required this.users});
}

// Произошла ошибка
class UserErrorState extends UserState {}
