import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  int statusCode = 0;
  String message = '';
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
}

// General failures
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [message, statusCode];
}

class OfflineFailure extends Failure {
  List<Object?> get props => [message, statusCode];
}

class EmptyCacheFailure extends Failure {
  @override
  String message = "Local data is not found";

  @override
  int statusCode = 404;
  @override
  List<Object?> get props => [message, statusCode];
}

class WrongDataFailure extends Failure {
  List<Object?> get props => [message, statusCode];
}
