import 'package:number_trivi/authentication/data/data_sources/local_data_sources/user_local_data_source.dart';
import 'package:number_trivi/authentication/data/models/user_model.dart';
import 'package:number_trivi/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cashedUser = 'Cashed_User';

class UserLocalDataSourceImpl extends UserLocalDataSource {
  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();

  @override
  Future<UserModel> signIn(UserModel userModel) async {
    final jsonString =
        await sharedPreferences.then((value) => value.getString(cashedUser));
    if (jsonString != null) {
      return Future.value(userFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(UserModel userModel) {
    return sharedPreferences.then((value) => value.setString(
          cashedUser,
          userToJson(userModel),
        ));
  }
}
