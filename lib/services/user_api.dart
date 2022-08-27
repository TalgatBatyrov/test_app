import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/models/comment.dart';
import 'package:test_app/models/photos.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/models/user.dart';

class UserApi {
  var dio = Dio();
  final baseUrl = 'https://jsonplaceholder.typicode.com/';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<User>> getUsers() async {
    try {
      final prefs = await _prefs;
      // await prefs.clear();

      var response = await dio.get('${baseUrl}users');

      final List<dynamic> data = response.data;

      final users = data.map((e) => User.fromJson(e)).toList();

      await prefs.setString('users', json.encode(users));

      return users;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Post>> getUserPosts(int id) async {
    try {
      final prefs = await _prefs;

      var response = await dio.get('${baseUrl}users/$id/posts');

      final List<dynamic> data = response.data;
      await prefs.setString('posts', json.encode(data));

      final posts = data.map((e) => Post.fromJson(e)).toList();

      return posts;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Album>> getUserAlbums(int id) async {
    try {
      final prefs = await _prefs;
      var response = await dio.get('${baseUrl}users/$id/albums');
      final List<dynamic> data = response.data;
      await prefs.setString('albums', json.encode(data));
      final albums = data.map((e) => Album.fromJson(e)).toList();
      return albums;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Comment>> getUserPostComments(int id) async {
    try {
      final prefs = await _prefs;
      var response = await dio.get('${baseUrl}posts/$id/comments');
      final List<dynamic> data = response.data;
      prefs.setString('postComments', json.encode(data));
      final postComments = data.map((e) => Comment.fromJson(e)).toList();
      return postComments;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Photos>> getPhotos(int id) async {
    try {
      final prefs = await _prefs;
      var response = await dio.get('${baseUrl}albums/$id/photos');
      final List<dynamic> data = response.data;
      await prefs.setString('photos', json.encode(data));
      final photos = data.map((e) => Photos.fromJson(e)).toList();
      return photos;
    } catch (_) {
      rethrow;
    }
  }

  Future<Comment> sendComment({
    required int id,
    required String name,
    required String body,
    required String email,
  }) async {
    try {
      final prefs = await _prefs;
      var response = await dio.post(
        '${baseUrl}posts/$id/comments',
        data: {
          'name': name,
          'email': email,
          'body': body,
        },
      );
      final data = response.data;
      prefs.setString('newComment', json.encode(data));

      final newComment = Comment.fromJson(data);
      return newComment;
    } catch (_) {
      rethrow;
    }
  }
}
