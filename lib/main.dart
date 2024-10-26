import 'core/common/app_user/app_user_cubit.dart';
import 'features/Auth/presentation/bloc/auth_bloc.dart';
import 'features/Auth/presentation/pages/loginpage.dart';
import 'features/initdep.dart';
import 'features/blogs/presentation/bloc/blogs_bloc.dart';
import 'features/blogs/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await ist();
  await Future.delayed(const Duration(seconds: 7));
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<BlogsBloc>(),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return (state is AppUserLoggedIn);
        },
        builder: (context, isloogedin) {
          if (isloogedin) {
            return const BlogPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
