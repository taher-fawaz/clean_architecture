// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:number_trivi/authentication/domain/entities/user.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEntity {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.token,
  });

  @override
  int? id;
  @override
  String? name;
  @override
  String? email;
  @override
  String? password;
  @override
  String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["user"]["id"],
        name: json["user"]["name"],
        email: json["user"]["email"],
        password: json["user"]["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "token": token,
      };
}
