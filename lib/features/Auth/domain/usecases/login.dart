import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/authrepo.dart';
import 'package:dartz/dartz.dart';

class Login implements UseCase<User, LogParams> {
  final AuthRepo authRepo;
  const Login(this.authRepo);

  @override
  Future<Either<Failure, User>> call(LogParams params) async {
    return await authRepo.loginWithEmailPassword(
        password: params.password, email: params.email);
  }
}

class LogParams {
  final String password;
  final String email;
  const LogParams({required this.email, required this.password});
}
