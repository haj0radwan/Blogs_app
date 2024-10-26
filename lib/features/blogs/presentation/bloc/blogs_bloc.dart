import 'dart:developer';
import 'dart:io';


import 'package:alnekhba_blogs/features/blogs/presentation/bloc/blogs_bloc.dart';

import '../../domain/entities/blog.dart';
import '../../domain/usecases/get_all_blogs.dart';
import '../../domain/usecases/local_interactions.dart';
import '../../domain/usecases/upload_blog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blogs_event.dart';
part 'blogs_state.dart';

class BlogsBloc extends Bloc<BlogsEvent, BlogsState> {
  final GetAllBlogs _getAllblogs;
  final UploadBlog _uploadBlog;
  final LocalInteractions _localInteractions;

  BlogsBloc(
      {required GetAllBlogs getAllblogs,
      required UploadBlog uploadblog,
      required LocalInteractions localInteractions})
      : _getAllblogs = getAllblogs,
        _uploadBlog = uploadblog,
        _localInteractions = localInteractions,
        super(const PlogStates()) {
    on<BlogsEvent>(
        (event, emit) => emit(const PlogStates(blogState: BlogState.loading)));
    on<GetAll>(_ongetAllBlogs);
    on<UploadEvent>(_onuploadBlog);
    on<GetAllLocalBlogs>(_onGetAllLocalBlogs);
    // on<SavePlog>(_onSavePlog);
  }

  void _onGetAllLocalBlogs(
      GetAllLocalBlogs event, Emitter<BlogsState> emit) async {
    final res = await _localInteractions.getAllBlogs();
    emit(PlogStates(
      blog: res,
      blogState: BlogState.success,
    ));
  }

// SavePlog event, Emitter<BlogsState> emit
  void onSavePlog(Blog blog) async {
    await _localInteractions.savePlog(blog);
    //  List<Blog> list = state.blog ?? [];
    log("the state is ${state.blog}");
    // emit(PlogStates(blog: list, blogState: BlogState.success));
  }

  void _onuploadBlog(UploadEvent event, Emitter<BlogsState> emit) async {
    final res = await _uploadBlog(Params(
        img: event.img,
        title: event.title,
        content: event.content,
        posterId: event.poid));
    List<Blog> templist = state.blog ?? [];
    res.fold(
      (l) => emit(PlogStates(blogState: BlogState.failure, error: l.message)),
      (r) {
        templist.insert(0, r);
        emit(PlogStates(blogState: BlogState.success, blog: templist));
      },
    );
  }

  void _ongetAllBlogs(GetAll event, Emitter<BlogsState> emit) async {
    final res = await _getAllblogs(Noparams());
    res.fold(
      (l) => emit(PlogStates(blogState: BlogState.failure, error: l.message)),
      (r) => emit(PlogStates(blog: r, blogState: BlogState.success)),
    );
  }
}
