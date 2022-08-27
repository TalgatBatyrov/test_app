import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/blocs/user_posts_cubit/user_posts_state.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/services/user_api.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  UserPostsCubit() : super(UserPostsLoadingState());

  Future<void> fetchPosts(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      emit(UserPostsLoadingState());
      final List<Post> loadedPostsList = await UserApi().getUserPosts(id);

      final cachePosts = prefs.getString('posts');
      if (cachePosts != null) {
        final List<dynamic> decodePosts = json.decode(cachePosts);
        final models = decodePosts.map((e) => Post.fromJson(e)).toList();
        emit(UserPostLoadedState(posts: models));
      } else {
        emit(UserPostLoadedState(posts: loadedPostsList));
      }
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final cachePosts = prefs.getString('posts');
      if (cachePosts != null) {
        final List<dynamic> decodePosts = json.decode(cachePosts);
        final models = decodePosts.map((e) => Post.fromJson(e)).toList();
        emit(UserPostLoadedState(posts: models));
      } else {
        emit(UserPostsErrorState());
      }
    }
  }
}
