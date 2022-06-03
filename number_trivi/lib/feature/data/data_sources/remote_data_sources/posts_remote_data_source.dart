import 'package:number_trivi/feature/data/data_sources/models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();
}
