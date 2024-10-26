import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/authrepo.dart';
import 'package:dartz/dartz.dart';

class CurrentUser implements UseCase<User, Noparams> {
  final AuthRepo authRepo;
  const CurrentUser(this.authRepo);
  @override
  Future<Either<Failure, User>> call(Noparams params) async {
    return await authRepo.currentUser();
  }
}

class Noparams {}
