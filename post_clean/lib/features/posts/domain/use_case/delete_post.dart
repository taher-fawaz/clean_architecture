import 'package:dartz/dartz.dart';
import 'package:post_clean/core/error/failure.dart';
import 'package:post_clean/features/posts/domain/repository/post_repository.dart';

class DeletePostUseCase {
  DeletePostUseCase(this.repository);

  final PostRepository repository;

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deletePost(id);
  }
}
