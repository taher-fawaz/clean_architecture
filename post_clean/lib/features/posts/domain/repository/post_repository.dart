import 'package:dartz/dartz.dart';
import 'package:post_clean/core/error/failure.dart';
import 'package:post_clean/features/posts/data/model/post_model.dart';
import 'package:post_clean/features/posts/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();

  Future<Either<Failure, Unit>> deletePost(int id);

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> createPost(Post post);
}
