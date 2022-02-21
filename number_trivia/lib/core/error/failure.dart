import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  abstract int statusCode;
  abstract String message;
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
}

// General failures
class ServerFailure extends Failure {
  @override
  int statusCode = 404;
  @override
  String message = "Server error ";

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  @override
  String message = "Local data is not found";

  @override
  int statusCode = 404;
  @override
  List<Object?> get props => [message, statusCode];
}
