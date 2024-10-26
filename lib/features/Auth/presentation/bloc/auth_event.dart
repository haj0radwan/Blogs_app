part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthLogin({
    required this.email,
    required this.password,
  });
}

 class IsAuser extends AuthEvent {}
