import 'dart:io';

import '../../../../core/errors/failure.dart';
import '../entities/blog.dart';
import 'package:dartz/dartz.dart';

abstract class BlogRepo {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();

  Future<void> savePlog( Blog blog);
  Future<List<Blog>> getAllLocalBlogs();
}
