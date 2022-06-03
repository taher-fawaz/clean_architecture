import 'package:dartz/dartz.dart';
import 'package:number_trivi/authentication/data/models/user_model.dart';
import 'package:number_trivi/authentication/domain/entities/user.dart';
import 'package:number_trivi/core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> signIn(UserModel userModel);
}
