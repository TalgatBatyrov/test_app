import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_post_comments_cubit.dart/user_post_comments_state.dart';
import 'package:test_app/models/comment.dart';

import '../../services/user_api.dart';

class UserPostCommentsCubit extends Cubit<UserPostCommentsState> {
  UserPostCommentsCubit() : super(UserPostCommentsLoadingState());

  Future<void> fetchUserPostCommits(int id) async {
    try {
      emit(UserPostCommentsLoadingState());
      final List<Comment> loadedUserList =
          await UserApi().getUserPostComments(id);
      emit(UserPostCommentsLoadedState(comments: loadedUserList));
    } catch (e) {
      emit(UserPostCommentsErrorState());
    }
  }
}
