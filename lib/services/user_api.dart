import 'package:dio/dio.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/models/user.dart';

class UserApi {
  Future<List<User>> getUsers() async {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      final List<dynamic> json = response.data;
      return json.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Error fetching user ...');
    }
  }

  Future<List<Post>> getUserPosts(int id) async {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/users/$id/posts');
    if (response.statusCode == 200) {
      final List<dynamic> json = response.data;
      return json.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Error fetching post ...');
    }
  }

  Future<List<Album>> getUserAlbums(int id) async {
    var response = await Dio()
        .get('https://jsonplaceholder.typicode.com/users/$id/albums');
    if (response.statusCode == 200) {
      final List<dynamic> json = response.data;
      return json.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Error fetching albums ...');
    }
  }
}
