import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_posts_cubit/user_posts_cubit.dart';
import 'package:test_app/blocs/user_posts_cubit/user_posts_state.dart';
import 'package:test_app/components/error.dart';
import 'package:test_app/components/loading.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/aditional_info/elements/posts/elements/posts_preview.dart';

class Posts extends StatelessWidget {
  const Posts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostsCubit, UserPostsState>(
      builder: (context, state) {
        if (state is UserPostsErrorState) {
          return const Error();
        }
        if (state is UserPostLoadedState) {
          return PostsPreview(posts: state.posts);
        }
        return const Loading();
      },
    );
  }
}
