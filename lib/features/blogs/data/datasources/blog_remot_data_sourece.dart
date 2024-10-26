import 'dart:io';

import '../../../../core/errors/exceptions.dart';
import '../models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemotDataSourece {
  final SupabaseClient supabaseClient;
  const BlogRemotDataSourece(this.supabaseClient);

  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final blog = await supabaseClient
          .from("blogs")
          .insert(blogModel.toJson())
          .select();
      return BlogModel.fromJson(blog.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
            blog.id,
            image,
          );
      return supabaseClient.storage.from('blog_images').getPublicUrl(
            blog.id,
          );
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*, profiles (name)');
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog['profiles']['name'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
