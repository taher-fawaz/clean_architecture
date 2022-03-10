import 'package:dartz/dartz.dart';
import 'package:number_trivia/authentication/data/data_sources/local_data_sources/user_local_data_source.dart';

import 'package:number_trivia/authentication/data/data_sources/remote_data_sources/user_remote_data_source.dart';
import 'package:number_trivia/authentication/data/models/user_model.dart';
import 'package:number_trivia/authentication/domain/entities/user.dart';
import 'package:number_trivia/authentication/domain/repository/user_repository.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/network/network_info.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, UserModel>> signIn(UserModel userModel) async {
    if (await networkInfo.checkConnection()) {
      try {
        final user = await remoteDataSource.signIn(userModel);
        localDataSource.cacheUser(userModel);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUser = await localDataSource.signIn(userModel);
        return Right(localUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
