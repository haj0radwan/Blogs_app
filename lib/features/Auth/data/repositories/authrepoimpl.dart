import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/connection.dart';
import '../datasources/Authremotedatasource.dart';
import '../models/usermodel.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authrepo.dart';
import 'package:dartz/dartz.dart';

class Authrepoimpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionCheck connectionCheck;
  const Authrepoimpl(this.authRemoteDataSource, this.connectionCheck);
  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionCheck.thereisconnection) {
        final session = authRemoteDataSource.currentUserSession;
        if (session == null) return left(Failure("user not logged in"));

        return right(UserModel(
            email: session.user.email ?? '', id: session.user.id, name: ""));
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("user not loged in yett"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
          name: name, password: password, email: email),
    );
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String password, required String email}) async {
    return _getUser(
      () async => await authRemoteDataSource.loginWithEmailPassword(
          email: email, password: password),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionCheck.thereisconnection)) {
        return left(Failure("there is no internet connection try again later"));
      }
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
