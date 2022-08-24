import 'package:test_app/models/user.dart';
import 'package:test_app/services/user_api.dart';

class UsersRepository {
  final _usersProvider = UserApi();
  Future<List<User>> getAllUsers() => _usersProvider.getUsers();
}
