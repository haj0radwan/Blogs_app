import 'package:hive/hive.dart';
import '../../domain/entities/blog.dart';

part 'blog_model.g.dart';

@HiveType(typeId: 0)
class BlogModel extends Blog {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String posterId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final DateTime updatedAt;

  @HiveField(6)
  final String? posterName;

  BlogModel({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.updatedAt,
    this.posterName,
  }) : super(
          id: id,
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: imageUrl,
          updatedAt: updatedAt,
          posterName: posterName,
        );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
