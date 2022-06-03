import 'package:number_trivi/authentication/data/data_sources/remote_data_sources/user_remote_data_source.dart';
import 'package:number_trivi/authentication/data/models/user_model.dart';
import 'package:number_trivi/core/error/exception.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<UserModel> signIn(UserModel userModel) async {
    http.Response response = await http.post(
      Uri.parse('http://192.168.1.9/elfatek/public/api/loginn'),
      //super.loginPath,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive'
      },
      //super.headers,
      body: userToJson(userModel),
    );
    if (response.statusCode == 200) {
      UserModel user = userFromJson(response.body);

      print(user);
      return user;
    } else {
      throw ServerException();
    }
  }
}
