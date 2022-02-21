import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/feature/data/data_sources/local_data_sources/post_local_data_source.dart';
import 'package:number_trivia/feature/data/data_sources/models/post_model.dart';
import 'package:number_trivia/feature/data/data_sources/remote_data_sources/posts_remote_data_source.dart';
import 'package:number_trivia/feature/domain/entities/post_entity.dart';
import 'package:number_trivia/feature/domain/repositories/post_repository.dart';

class PostsRepositoryImpl extends PostsRepository {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    if (await networkInfo.checkConnection()) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getPosts();
        return Right(localPosts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
