import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_posts_cubit/user_posts_state.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/services/user_api.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  UserPostsCubit() : super(UserPostsLoadingState());

  Future<void> fetchPosts(int id) async {
    try {
      emit(UserPostsLoadingState());
      final List<Post> loadedUserList = await UserApi().getUserPosts(id);
      emit(UserPostLoadedState(posts: loadedUserList));
    } catch (e) {
      emit(UserPostsErrorState());
    }
  }
}
