import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/blocs/user_post_comments_cubit.dart/user_post_comments_state.dart';
import 'package:test_app/models/comment.dart';

import '../../services/user_api.dart';

class UserPostCommentsCubit extends Cubit<UserPostCommentsState> {
  UserPostCommentsCubit() : super(UserPostCommentsLoadingState());

  Future<void> fetchUserPostCommits(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      emit(UserPostCommentsLoadingState());
      final List<Comment> loadedUserList =
          await UserApi().getUserPostComments(id);
      final cacheComments = prefs.getString('postComments');
      if (cacheComments != null) {
        final List<dynamic> decodeComments = json.decode(cacheComments);
        final models = decodeComments.map((e) => Comment.fromJson(e)).toList();
        final cacheComment = prefs.getString('newComment');
        if (cacheComment != null) {
          final decodeComment = json.decode(cacheComment);
          final model = Comment.fromJson(decodeComment);
          models.add(model);
        }

        emit(UserPostCommentsLoadedState(comments: models));
      } else {
        emit(UserPostCommentsLoadedState(comments: loadedUserList));
      }
    } catch (_) {
      final prefs = await SharedPreferences.getInstance();
      final cacheComments = prefs.getString('postComments');
      if (cacheComments != null) {
        final List<dynamic> decodeComments = json.decode(cacheComments);
        final models = decodeComments.map((e) => Comment.fromJson(e)).toList();
        emit(UserPostCommentsLoadedState(comments: models));
      } else {
        emit(UserPostCommentsErrorState());
      }
    }
  }
}
