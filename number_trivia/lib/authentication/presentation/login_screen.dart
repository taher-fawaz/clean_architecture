import 'package:flutter/material.dart';
import 'package:number_trivia/authentication/data/data_sources/local_data_sources/user_local_data_source.dart';
import 'package:number_trivia/authentication/data/data_sources/local_data_sources/user_local_data_source_impl.dart';
import 'package:number_trivia/authentication/data/data_sources/remote_data_sources/user_remote_data_source_impl.dart';
import 'package:number_trivia/authentication/data/models/user_model.dart';
import 'package:number_trivia/authentication/data/repository/user_repository_impl.dart';
import 'package:number_trivia/authentication/domain/entities/user.dart';
import 'package:number_trivia/authentication/domain/use_cases/user_usecase.dart';
import 'package:number_trivia/core/network/network_info.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController nameController =
      TextEditingController(text: "Your name");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
            ),
            TextFormField(
              controller: passwordController,
            ),
            OutlinedButton(
                onPressed: () {
                  UserAuthUseCase(
                          userRepository: UserRepositoryImpl(
                              localDataSource: UserLocalDataSourceImpl(),
                              networkInfo: NetworkInfo.getInstance(),
                              remoteDataSource: UserRemoteDataSourceImpl()))
                      .signIn(UserModel(
                          email: emailController.text,
                          password: passwordController.text));
                },
                child: Text("data"))
          ],
        ),
      ),
    );
  }
}
