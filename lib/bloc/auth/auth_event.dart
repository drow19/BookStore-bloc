import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];

}

class ErrorEvent extends AuthEvent {
  final String message;

  ErrorEvent({@required this.message});

  @override
  List<Object> get props => [message];
}


class CheckUserLogin extends AuthEvent{
  @override
  List<Object> get props => throw UnimplementedError();

}