import 'package:dartz/dartz.dart';
import 'package:number_trivi/authentication/data/models/user_model.dart';
import 'package:number_trivi/authentication/domain/entities/user.dart';
import 'package:number_trivi/authentication/domain/repository/user_repository.dart';
import 'package:number_trivi/core/error/failure.dart';
import 'package:number_trivi/core/usecase/usecase.dart';

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
