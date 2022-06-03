import 'package:number_trivi/authentication/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signIn(UserModel userModel);
}
