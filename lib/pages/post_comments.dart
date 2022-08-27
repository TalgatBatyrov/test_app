import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_post_comments_cubit.dart/user_post_comments_cubit.dart';
import 'package:test_app/blocs/user_post_comments_cubit.dart/user_post_comments_state.dart';
import 'package:test_app/components/error.dart';
import 'package:test_app/components/loading.dart';
import 'package:test_app/services/user_api.dart';
import 'package:test_app/styles/styles.dart';

class PostComments extends StatefulWidget {
  final int postId;
  const PostComments({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final bodyController = TextEditingController();
    return BlocProvider(
      create: (context) =>
          UserPostCommentsCubit()..fetchUserPostCommits(widget.postId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.bgColor,
          title: const Text('Comments'),
        ),
        body: BlocBuilder<UserPostCommentsCubit, UserPostCommentsState>(
          builder: (context, state) {
            if (state is UserPostCommentsErrorState) {
              return const Error();
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
                        final comment = state.comments[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              comment.email,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              comment.body,
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Styles.bgColor),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Column(
                            children: [
                              TextField(
                                controller: nameController,
                                decoration:
                                    const InputDecoration(hintText: 'Name'),
                              ),
                              TextField(
                                controller: emailController,
                                decoration:
                                    const InputDecoration(hintText: 'Email'),
                              ),
                              TextField(
                                controller: bodyController,
                                decoration:
                                    const InputDecoration(hintText: 'Comment'),
                              ),
                            ],
                          ),
                          content: const Text('New comment'),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Styles.bgColor),
                              onPressed: () async {
                                if (bodyController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty &&
                                    nameController.text.isNotEmpty) {
                                  final comment = await UserApi().sendComment(
                                    id: widget.postId,
                                    body: bodyController.text,
                                    email: emailController.text,
                                    name: nameController.text,
                                  );

                                  state.comments.add(comment);
                                  setState(() {});
                                }
                                // ignore: use_build_context_synchronously
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
            return const Loading();
          },
        ),
      ),
    );
  }
}
