import 'package:bookstorebloc/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthState extends Equatable {}

class InitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class IsLogged extends AuthState {
  final UserModel userModel;

  IsLogged({@required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class UserLoginState extends AuthState {
  @override
  List<Object> get props => [];
}

class UserLogOutState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginError extends AuthState {
  final String message;

  LoginError({@required this.message});

  @override
  List<Object> get props => [message];
}
