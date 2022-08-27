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
      final List<User> loadedUserList = await usersRepository.getAllUsers();
      final users = prefs.getString('users');
      if (users != null) {
        final List<dynamic> responsOfdec = json.decode(users);
        final models = responsOfdec.map((e) => User.fromJson(e)).toList();

        emit(UserLoadedState(users: models));
      } else {
        emit(UserLoadedState(users: loadedUserList));
      }
    } catch (e) {
      emit(UserErrorState());
    }
  }
}
