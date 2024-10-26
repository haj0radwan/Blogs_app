import 'dart:async';
import '../../../../core/errors/failure.dart';
import '../entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> currentUser();
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String password, required String email});
}
