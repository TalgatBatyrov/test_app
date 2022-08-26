import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_post_comments_cubit.dart/user_post_comments_cubit.dart';
import 'package:test_app/blocs/user_post_comments_cubit.dart/user_post_comments_state.dart';

class PostComments extends StatelessWidget {
  final int postId;
  const PostComments({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserPostCommentsCubit()..fetchUserPostCommits(postId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: BlocBuilder<UserPostCommentsCubit, UserPostCommentsState>(
          builder: (context, state) {
            if (state is UserPostCommentsErrorState) {
              return const Center(
                child: Text(
                  'Ошибка сети ... ',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }
            if (state is UserPostCommentsLoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.comments.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.black.withOpacity(0.33),
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final comments = state.comments[index];
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            comments.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(comments.email),
                          style: ListTileStyle.drawer,
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Column(
                            children: const [
                              TextField(),
                              TextField(),
                              TextField(),
                            ],
                          ),
                          content: const Text('Add comment'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: const Text('Send'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Add comment'),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
