import 'package:number_trivia/feature/data/data_sources/models/post_model.dart';
import 'package:number_trivia/feature/domain/entities/post_entity.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();
}
