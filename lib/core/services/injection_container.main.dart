part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _authInit();
  await _orderInit();
  await _reportInit();
}

Future<void> _reportInit() async {
  sl
    ..registerFactory(() => ReportBloc(getWeeklyReport: sl()))
    ..registerLazySingleton(() => GetWeeklyReport(sl()))
    ..registerLazySingleton<ReportRepo>(() => ReportRepoImpl(sl()))
    ..registerLazySingleton<ReportRemoteDataSource>(
      () => ReportRemoteDataSourceImpl(sl()),
    );
}

Future<void> _orderInit() async {
  sl
    ..registerFactory(
      () => OrderBloc(getOrders: sl(), updateOrderStatus: sl()),
    )
    ..registerLazySingleton(() => GetOrders(sl()))
    ..registerLazySingleton(() => UpdateOrderStatus(sl()))
    ..registerLazySingleton<OrdersRepo>(() => OrderRepoImpl(sl()))
    ..registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(sl()),
    );
}

Future<void> _authInit() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        forgotPassword: sl(),
        createPassword: sl(),
        logout: sl(),
        saveUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => CreatePassword(sl()))
    ..registerLazySingleton(() => SaveUser(sl()))
    ..registerLazySingleton(() => Logout(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl(), sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(() => prefs);
}
