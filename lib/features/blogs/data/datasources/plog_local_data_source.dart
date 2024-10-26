import '../models/blog_model.dart';
import 'package:hive/hive.dart';

class PlogLocalDataSource {
  final Box<BlogModel> box;

  PlogLocalDataSource(this.box);

  Future<void> savePlog({required BlogModel plog}) async {
    await box.put(plog.id, plog);
  }

  Future<List<BlogModel>> getAllblogs() async {
    return box.values.cast<BlogModel>().toList();
  }
}
