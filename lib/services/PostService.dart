import 'package:dio/dio.dart';
import 'package:flutter_favorite_bloc/models/Post.dart';

class PostService {
  static const BASE_URL = "https://jsonplaceholder.typicode.com";
  final Dio dio = Dio();

  Future<List<Post>> getPosts() async {
    try {
      Response response = await dio.get("$BASE_URL/posts");
      var list = response.data as List;
      List<Post> posts = list.map<Post>((json) => Post.fromJson(json)).toList();
      return posts;
    } catch (e) {
      throw Exception(e);
    }
  }
}
