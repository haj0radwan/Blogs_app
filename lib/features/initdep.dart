
import '../core/common/app_user/app_user_cubit.dart';
import '../core/network/connection.dart';
import '../core/secrets/app_secrets.dart';
import 'Auth/data/datasources/Authremotedatasource.dart';
import 'Auth/data/repositories/authrepoimpl.dart';
import 'Auth/domain/repositories/authrepo.dart';
import 'Auth/domain/usecases/current_user.dart';
import 'Auth/domain/usecases/login.dart';
import 'Auth/domain/usecases/signup.dart';
import 'Auth/presentation/bloc/auth_bloc.dart';
import 'blogs/data/datasources/blog_remot_data_sourece.dart';
import 'blogs/data/datasources/plog_local_data_source.dart';
import 'blogs/data/models/blog_model.dart';
import 'blogs/data/repositories/blog_repo_impl.dart';
import 'blogs/domain/repositories/blog_repo.dart';
import 'blogs/domain/usecases/get_all_blogs.dart';
import 'blogs/domain/usecases/local_interactions.dart';
import 'blogs/domain/usecases/upload_blog.dart';
import 'blogs/presentation/bloc/blogs_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'initdep.main.dart';
