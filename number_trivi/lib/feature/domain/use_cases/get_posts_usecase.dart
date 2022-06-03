import 'package:dartz/dartz.dart';
import 'package:number_trivi/core/error/failure.dart';
import 'package:number_trivi/core/usecase/usecase.dart';
import 'package:number_trivi/feature/domain/entities/post_entity.dart';
import 'package:number_trivi/feature/domain/repositories/post_repository.dart';

class GetPostsUseCase implements UseCase<PostEntity, NoParams> {
  final PostsRepository repository;

  GetPostsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PostEntity>>> call(NoParams params) async {
    return await repository.getPosts();
  }
}
