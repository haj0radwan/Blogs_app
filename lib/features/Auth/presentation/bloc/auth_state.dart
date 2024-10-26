part of 'auth_bloc.dart';

enum Authstate { loading, failure, succes, initial }

abstract class AuthState extends Equatable {
  final User? user;
  final String? m;
  final Authstate authstate;
  const AuthState({this.user, this.m, this.authstate = Authstate.initial});
  @override
  List<Object?> get props => [user, m, authstate];
}

class AuthInitial extends AuthState {
  final User? user;
  final String? m;
  final Authstate authstate;
  const AuthInitial({this.user, this.m, this.authstate = Authstate.initial});
}

class AuthLoading extends AuthState {}
