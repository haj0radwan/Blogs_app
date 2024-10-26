part of 'initdep.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(BlogModelAdapter());
  await Hive.openBox<BlogModel>('blogs');
  serviceLocator.registerLazySingleton<Box<BlogModel>>(
      () => Hive.box<BlogModel>('blogs'));
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionCheck>(
      () => ConnectionCheckImpl(serviceLocator()));
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(), //supabase client
      ),
    )
    // Repository
    ..registerFactory<AuthRepo>(
      () => Authrepoimpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => Signup(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => Login(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        signup: serviceLocator(),
        login: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

Future<void> ist() async {
  AuthBloc(
          signup: serviceLocator(),
          login: serviceLocator(),
          appUserCubit: serviceLocator(),
          currentUser: serviceLocator())
      .add(IsAuser());
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemotDataSourece>(
      () => BlogRemotDataSourece(
        serviceLocator(),
      ),
    )
    ..registerFactory<PlogLocalDataSource>(
      () => PlogLocalDataSource(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepo>(
      () => BlogRepoImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => LocalInteractions(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogsBloc(
        localInteractions: serviceLocator(),
        uploadblog: serviceLocator(),
        getAllblogs: serviceLocator(),
      ),
    );
}
