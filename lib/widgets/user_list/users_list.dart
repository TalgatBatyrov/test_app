import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_cubit/user_cubit.dart';
import 'package:test_app/blocs/user_cubit/user_state.dart';
import 'package:test_app/components/error.dart';
import 'package:test_app/components/loading.dart';
import 'package:test_app/widgets/user_list/elements/user_page.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserEmptyState) {
          return const Center(
            child: Text(
              'Нет данных ...',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }
        if (state is UserLoadingState) {
          return const Loading();
        }
        if (state is UserErrorState) {
          return const Error();
        }

        if (state is UserLoadedState) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.users.length,
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.black.withOpacity(0.33),
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final user = state.users[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPage(user: user),
                    ),
                  );
                },
                leading: const Icon(Icons.person),
                title: Text(
                  user.username,
                  style: const TextStyle(fontSize: 20),
                ),
                style: ListTileStyle.drawer,
                subtitle: Text(
                  user.name,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
