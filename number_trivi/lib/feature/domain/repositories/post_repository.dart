import 'package:dartz/dartz.dart';
import 'package:number_trivi/core/error/failure.dart';
import 'package:number_trivi/feature/domain/entities/post_entity.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
}
