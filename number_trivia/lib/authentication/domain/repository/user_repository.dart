import 'package:dartz/dartz.dart';
import 'package:number_trivia/authentication/data/models/user_model.dart';
import 'package:number_trivia/authentication/domain/entities/user.dart';
import 'package:number_trivia/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> signIn(UserModel userModel);
}
