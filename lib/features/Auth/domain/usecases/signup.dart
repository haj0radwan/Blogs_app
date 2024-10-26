import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/authrepo.dart';
import 'package:dartz/dartz.dart';

class Signup implements UseCase<User, Params> {
  final AuthRepo authRepo;
  const Signup(this.authRepo);
  @override
  Future<Either<Failure, User>> call(Params params) {
    return authRepo.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class Params {
  final String email;
  final String name;
  final String password;
  const Params({
    required this.email,
    required this.name,
    required this.password,
  });
}
