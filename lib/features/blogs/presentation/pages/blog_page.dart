import '../../../../core/util/show_snackbar.dart';
import '../bloc/blogs_bloc.dart';
import 'add_blog.dart';
import '../widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<PlogsBloc>().add(GetAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
              icon: const Icon(Icons.archive),
              onPressed: () {
                context.read<PlogsBloc>().add(GetAllLocalBlogs());
              }),
          IconButton(
              onPressed: () {
                context.read<PlogsBloc>().add(GetAll());
              },
              icon: const Icon(Icons.wifi_rounded)),
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<PlogsBloc, PlogsState>(
        listener: (context, state) {
          if (state.blogState == BlogState.failure) {
            showSnackBar(context, state.error!);
          }
        },
        builder: (context, state) {
          if (state.blogState == BlogState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.blogState == BlogState.success) {
            final l = state.blog!.reversed.toList();
            return ListView.builder(
              itemCount: state.blog!.length,
              itemBuilder: (context, index) {
                final blog = l[index];
                return BlogCard(blog: blog, color: Colors.white30);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
