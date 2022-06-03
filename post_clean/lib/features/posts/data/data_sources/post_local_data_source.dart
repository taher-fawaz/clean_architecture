import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:post_clean/core/error/exception.dart';
import 'package:post_clean/features/posts/data/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCashedPosts();

  Future<Unit> cachePosts(List<PostModel> posts);

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel post);

  Future<Unit> createPost(PostModel post);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    final List postModelToJson = posts.map((post) => post.toJson()).toList();
    sharedPreferences.setString('CASHED_POSTS', json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    final jsonString = sharedPreferences.getString('CASHED_POSTS');
    if (jsonString == null) {
      throw EmptyCacheException();
    }
    final List decodeJsonData = jsonDecode(jsonString);
    final List<PostModel> jsonToPostModels = decodeJsonData
        .map<PostModel>((post) => PostModel.fromJson(post))
        .toList(); // map<PostModel> is a function that takes a list of json and returns a list of PostModel

    return Future.value(jsonToPostModels);
  }

  @override
  Future<Unit> createPost(PostModel post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
