import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/blog.dart';
import '../repositories/blog_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllBlogs implements UseCase<List<Blog>, Noparams> {
  final BlogRepo blogRepo;
  const GetAllBlogs(this.blogRepo);
  @override
  Future<Either<Failure, List<Blog>>> call(Noparams params) async {
    return await blogRepo.getAllBlogs();
  }
}

class Noparams {}
