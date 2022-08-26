import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_cubit/user_cubit.dart';
import 'package:test_app/services/user_repository.dart';
import 'package:test_app/styles/styles.dart';
import 'package:test_app/widgets/user_list/users_list.dart';

class HomePage extends StatelessWidget {
  final UsersRepository usersRepository = UsersRepository();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(usersRepository),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          backgroundColor: Styles.bgColor,
        ),
        body: Column(
          children: const [
            Expanded(
              child: UsersList(),
            ),
          ],
        ),
      ),
    );
  }
}
