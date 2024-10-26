import '../entities/blog.dart';
import '../repositories/blog_repo.dart';

class LocalInteractions {
  final BlogRepo blogRepo;
  LocalInteractions(this.blogRepo);

  Future<void> savePlog(Blog blog) async {
    return await blogRepo.savePlog(blog);
  }

  Future<List<Blog>> getAllBlogs() async {
    return await blogRepo.getAllLocalBlogs();
  }
}
