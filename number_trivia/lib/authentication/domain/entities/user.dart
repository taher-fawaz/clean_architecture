import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  UserEntity({
    this.id,
    this.name,
    this.email,
    this.password,
    this.token,
  });

  int? id;
  String? name;
  String? email;
  String? password;
  String? token;
  @override
  List<Object?> get props => [id, name, email, password, token];
}
