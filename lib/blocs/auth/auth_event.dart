part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthCheck extends AuthEvent {}

class GetDataWithToken extends AuthEvent {
  final String token;

  GetDataWithToken(this.token);
  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthEvent {}

class LoginProcess extends AuthEvent {
  final String email;
  final String password;

  LoginProcess({this.email, this.password});
  @override
  List<Object> get props => [email, password];
}

class RegisterProcess extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String retypePassword;

  RegisterProcess({
    this.name,
    this.email,
    this.password,
    this.retypePassword,
  });
  @override
  List<Object> get props => [name, email, password, retypePassword];
}
