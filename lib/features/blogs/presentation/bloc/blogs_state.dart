part of 'blogs_bloc.dart';

enum BlogState { failure, loading, success, initial ,successupload}

abstract class BlogsState extends Equatable {
  final BlogState blogState;
  final String? error;
  final List<Blog>? blog;
  const BlogsState({this.blog, this.error, this.blogState = BlogState.initial});
  @override
  List<Object?> get props => [blogState, blog, error];
  PlogStates cpwithsuccesupload({required BlogState st}) {
    return PlogStates(blogState: st, blog: blog);
  }
}

class PlogStates extends BlogsState {
  const PlogStates({super.blogState, super.blog, super.error});
}
