part of 'blogs_bloc.dart';

abstract class BlogsEvent extends Equatable {
  const BlogsEvent();

  @override
  List<Object> get props => [];
}

class GetAll extends BlogsEvent {}

class GetAllLocalBlogs extends BlogsEvent {}

class SavePlog extends BlogsEvent {
  final Blog blog;
  const SavePlog({required this.blog});
}

class UploadEvent extends BlogsEvent {
  final String content;
  final String title;
  final String poid;
  final File img;
  const UploadEvent(
      {required this.content,
      required this.img,
      required this.poid,
      required this.title});
}
