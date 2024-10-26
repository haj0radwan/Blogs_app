import 'dart:io';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/connection.dart';
import '../datasources/blog_remot_data_sourece.dart';
import '../datasources/plog_local_data_source.dart';
import '../models/blog_model.dart';
import '../../domain/entities/blog.dart';
import '../../domain/repositories/blog_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class BlogRepoImpl implements BlogRepo {
  final BlogRemotDataSourece blogRemotDataSourece;
  final PlogLocalDataSource ploglocaldatasource;
  final ConnectionCheck connectionCheck;
  const BlogRepoImpl(this.blogRemotDataSourece, this.connectionCheck,
      this.ploglocaldatasource);

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await connectionCheck.thereisconnection) {
        return left(Failure("no internet connection"));
      }
      final blogs = await blogRemotDataSourece.getAllBlogs();
      return right(blogs);
    } on ServerException catch (a) {
      return left(Failure(a.message));
    }
  }

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
  }) async {
    try {
      if (!await connectionCheck.thereisconnection) {
        return left(Failure("there is no internet connection"));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemotDataSourece.uploadBlogImage(
        image: image,
        blog: blogModel,
      );
      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );
      final uploadedBlog = await blogRemotDataSourece.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<List<Blog>> getAllLocalBlogs() async {
    try {
      return await ploglocaldatasource.getAllblogs();
    } catch (e) {
      throw const CachException(" No Data found ");
    }
  }

  @override
  Future<void> savePlog(Blog blog) async {
    return await ploglocaldatasource.savePlog(plog: blog as BlogModel);
  }
}
