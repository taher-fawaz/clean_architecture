import 'package:number_trivi/authentication/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> signIn(UserModel userModel);
  Future<void> cacheUser(UserModel userModel);
}
