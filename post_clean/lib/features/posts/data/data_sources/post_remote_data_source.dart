import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:post_clean/core/constants.dart';
import 'package:post_clean/core/error/exception.dart';

import 'package:post_clean/features/posts/data/model/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel post);

  Future<Unit> createPost(PostModel post);

  // Future<List<PostModel>> getPosts() async {
  //   final response =
  //       await Dio().get('https://jsonplaceholder.typicode.com/posts');
  //   List<PostModel> posts = [];
  //   for (var i = 0; i < response.data.length; i++) {
  //     posts.add(PostModel.fromJson(response.data[i]));
  //   }
  //   return posts;
  // }
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  http.Client client;
  PostRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(
      Uri.parse(AppConstants.baseUrl + "/posts"),
    );
    print(response);

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body);
      final List<PostModel> postModels = decodedJson
          .map((postModel) => PostModel.fromJson(postModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> createPost(PostModel post) async {
    final body = {
      "title": post.title,
      "body": post.body,
    };

    final response = await client
        .post(Uri.parse(AppConstants.baseUrl + "/posts"), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await client.delete(
      Uri.parse(AppConstants.baseUrl + "/posts/${id.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id.toString();
    final body = {
      "title": post.title,
      "body": post.body,
    };

    final response = await client.patch(
      Uri.parse(AppConstants.baseUrl + "/posts/$postId"),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
