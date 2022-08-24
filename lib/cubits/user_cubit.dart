import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/cubits/user_state.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/services/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UsersRepository usersRepository;
  UserCubit(this.usersRepository) : super(UserEmptyState());

  Future<void> fetchUsers() async {
    try {
      emit(UserLoadingState());
      final List<User> loadedUserList = await usersRepository.getAllUsers();
      emit(UserLoadedState(loadedUser: loadedUserList));
    } catch (e) {
      emit(UserErrorState());
    }
  }
}
