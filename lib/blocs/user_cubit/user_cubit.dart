import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/blocs/user_cubit/user_state.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/services/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UsersRepository usersRepository;
  UserCubit(this.usersRepository) : super(UserEmptyState()) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      emit(UserLoadingState());
      // Получили юзеров
      final List<User> loadedUserList = await usersRepository.getAllUsers();
      final cacheUsers = prefs.getString('users');
      // Если в кэше есть данные то показываем их
      if (cacheUsers != null) {
        final List<dynamic> decodeUsers = json.decode(cacheUsers);
        final cacheUsersList =
            decodeUsers.map((e) => User.fromJson(e)).toList();
        emit(UserLoadedState(users: cacheUsersList));
        // Иначе загруженные
      } else {
        emit(UserLoadedState(users: loadedUserList));
      }
      // В случае ошибки проверяем кэш и если есть показываем
    } catch (e) {
      // Вот это дублирование нужно исправить
      final prefs = await SharedPreferences.getInstance();
      final usersCache = prefs.getString('users');
      if (usersCache != null) {
        final List<dynamic> decodeUsers = json.decode(usersCache);

        final models = decodeUsers.map((e) => User.fromJson(e)).toList();

        emit(UserLoadedState(users: models));
      } else {
        // Иначе выводим ошибку
        emit(UserErrorState());
      }
    }
  }
}
