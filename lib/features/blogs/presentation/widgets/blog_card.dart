import '../../domain/entities/blog.dart';
import '../bloc/blogs_bloc.dart';
import '../pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          Navigator.push(context, BlogViewerPage.route(blog));
        },
        child: Container(
          width: double.infinity,
          height: 200,
          margin: const EdgeInsets.all(16).copyWith(
            bottom: 4,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            boxShadow: const [
              BoxShadow(spreadRadius: 0.5, offset: Offset(2, 2)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("posted by ${blog.posterName}"),
              Text(blog.updatedAt.toIso8601String()),
            ],
          ),
        ),
      ),
      Positioned(
          top: 10,
          right: 10,
          child: IconButton(
              onPressed: () {
                context.read<BlogsBloc>().onSavePlog(blog);
              },
              icon: const Icon(Icons.star))),
    ]);
  }
}
