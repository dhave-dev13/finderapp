import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.message, this.stackTrace});

  final String? message;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.message, super.stackTrace});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message, super.stackTrace});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message, super.stackTrace});
}

class ExceptionFailure extends Failure {
  const ExceptionFailure({super.message, super.stackTrace});
}

class CredentialFailure extends Failure {
  const CredentialFailure({super.message, super.stackTrace});
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message, super.stackTrace});
}
