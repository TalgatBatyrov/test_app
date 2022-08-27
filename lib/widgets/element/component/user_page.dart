import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/theme_cubit/theme_cubit.dart';
import 'package:test_app/blocs/user_albums_cubit/user_albums_cubit.dart';
import 'package:test_app/blocs/user_posts_cubit/user_posts_cubit.dart';
import 'package:test_app/components/theme_toggle.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/services/user_repository.dart';
import 'package:test_app/styles/styles.dart';
import 'package:test_app/widgets/user_list/component/elements/user_info.dart';

class UserPage extends StatelessWidget {
  final usersRepository = UsersRepository();
  final User user;
  UserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserPostsCubit()..fetchPosts(user.id)),
        BlocProvider(create: (_) => UserAlbumCubit()..fetchAlbums(user.id)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.username),
          actions: [
            ThemeToggle(themeCubit: themeCubit),
          ],
          backgroundColor: Styles.bgColor,
        ),
        body: UserInfo(user: user),
      ),
    );
  }
}
