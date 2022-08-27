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

  Future<List<User>> getUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      var response = await dio.get('${baseUrl}users');

      final List<dynamic> jsonr = response.data;

      final users = jsonr.map((e) => User.fromJson(e)).toList();

      prefs.setString('users', json.encode(users));

      return users;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Post>> getUserPosts(int id) async {
    try {
      var response = await dio.get('${baseUrl}users/$id/posts');
      final List<dynamic> json = response.data;
      return json.map((e) => Post.fromJson(e)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Album>> getUserAlbums(int id) async {
    try {
      var response = await dio.get('${baseUrl}users/$id/albums');
      final List<dynamic> json = response.data;
      return json.map((e) => Album.fromJson(e)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Comment>> getUserPostComments(int id) async {
    try {
      var response = await dio.get('${baseUrl}posts/$id/comments');
      final List<dynamic> json = response.data;
      return json.map((e) => Comment.fromJson(e)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Photos>> getPhotos(int id) async {
    try {
      var response = await dio.get('${baseUrl}albums/$id/photos');
      final List<dynamic> json = response.data;
      return json.map((e) => Photos.fromJson(e)).toList();
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
      var response = await dio.post(
        '${baseUrl}posts/$id/comments',
        data: {
          'name': name,
          'email': email,
          'body': body,
        },
      );
      final json = response.data;
      return Comment.fromJson(json);
    } catch (_) {
      rethrow;
    }
  }
}
