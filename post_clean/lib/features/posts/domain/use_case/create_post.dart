import 'package:dartz/dartz.dart';
import 'package:post_clean/core/error/failure.dart';
import 'package:post_clean/features/posts/domain/entities/post_entity.dart';
import 'package:post_clean/features/posts/domain/repository/post_repository.dart';

class CreatePostUseCase {
  CreatePostUseCase(this.repository);

  final PostRepository repository;

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.createPost(post);
  }
}
