// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:alnekhba_blogs/core/errors/failure.dart';
import 'package:alnekhba_blogs/core/usecases/usecase.dart';
import 'package:alnekhba_blogs/features/blogs/domain/entities/blog.dart';
import 'package:alnekhba_blogs/features/blogs/domain/repositories/blog_repo.dart';

class UploadBlog implements UseCase<Blog, Params> {
  final BlogRepo blogRepo;
  const UploadBlog(this.blogRepo);
  @override
  Future<Either<Failure, Blog>> call(Params params) async {
    return await blogRepo.uploadBlog(
        image: params.img,
        title: params.title,
        content: params.content,
        posterId: params.posterId);
  }
}

class Params {
  final File img;
  final String title;
  final String content;
  final String posterId;
  Params({
    required this.img,
    required this.title,
    required this.content,
    required this.posterId,
  });
}
