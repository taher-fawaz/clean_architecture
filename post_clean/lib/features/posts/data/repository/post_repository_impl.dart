import 'package:dartz/dartz.dart';
import 'package:post_clean/core/error/exception.dart';
import 'package:post_clean/core/error/failure.dart';
import 'package:post_clean/core/network/network_info.dart';
import 'package:post_clean/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:post_clean/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:post_clean/features/posts/data/model/post_model.dart';
import 'package:post_clean/features/posts/domain/entities/post_entity.dart';
import 'package:post_clean/features/posts/domain/repository/post_repository.dart';

typedef DeleteOrUpdateOrAdd = Future<Unit> Function();

class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImpl({
    required this.postRemoteDataSource,
    required this.postLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    final remotePosts = await postRemoteDataSource.getPosts();

    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getPosts();
        await postLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getCashedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> createPost(Post post) async {
    final postModel = PostModel(title: post.title, body: post.body);
    return _getMessage(() => postRemoteDataSource.createPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return _getMessage(() => postRemoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return _getMessage(() => postRemoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAdd deleteOrUpdateOrAdd) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAdd();
        // await postRemoteDataSource.deletePost(id);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
