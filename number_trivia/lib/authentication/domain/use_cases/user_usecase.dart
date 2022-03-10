import 'package:dartz/dartz.dart';
import 'package:number_trivia/authentication/data/models/user_model.dart';
import 'package:number_trivia/authentication/domain/entities/user.dart';
import 'package:number_trivia/authentication/domain/repository/user_repository.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/usecase/usecase.dart';

class UserAuthUseCase extends AuthenticationUseCase<UserEntity, UserModel> {
  final UserRepository userRepository;
  UserAuthUseCase({required this.userRepository});
  @override
  Future<Either<Failure, UserEntity>> signIn(UserModel params) async {
    return await userRepository.signIn(params);
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(UserModel params) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
