import 'package:dartz/dartz.dart';
import 'package:post_clean/core/error/failure.dart';
import 'package:post_clean/features/posts/domain/entities/post_entity.dart';
import 'package:post_clean/features/posts/domain/repository/post_repository.dart';

class GetAllPostsUseCase {
  final PostRepository postRepository;

  GetAllPostsUseCase(this.postRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await postRepository.getPosts();
  }
}
