// Общее сотояние
abstract class UserState {}

// Нет юзеров
class UserEmptyState extends UserState {}

// Идет процесс загрузки
class UserLoadingState extends UserState {}

// Данные успешно загружены
class UserLoadedState extends UserState {
  List<dynamic> loadedUser;
  UserLoadedState({required this.loadedUser});
}

// Произошла ошибка
class UserErrorState extends UserState {}
