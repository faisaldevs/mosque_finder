import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:mosque_finder_app/app/router/config/navigation_service.dart';
import 'package:mosque_finder_app/core/networks/dio/interceptor/log.dart';
import 'package:mosque_finder_app/core/services/logger.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/local/local_auth_datasource.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/local/local_auth_datasource_impl.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/remote/remote_auth_datasource.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/remote/remote_auth_datasource_impl.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/login_repository.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/login_repository_impl.dart';

final locator = GetIt.instance;

final hiveBox = locator<Box>();
CustomLogger get logger => locator<CustomLogger>();

Future<void> diSetup() async {
  await Hive.initFlutter();

  locator
    // ..registerLazySingleton(() => FirebaseMessaging.instance)
    // ..registerSingleton<GetStorage>(GetStorage())
    ..registerSingleton<CustomLogger>(CustomLogger())
    ..registerSingleton<NavigationService>(NavigationService())
    ..registerSingleton<Box>(await Hive.openBox("hive_app"))
    // NEW: Dio configured with our interceptor
    ..registerSingleton<Dio>(() {
      final dio = Dio();
      dio.interceptors.add(DioLogger());
      // dio.interceptors.add(DioLogger(level: LogLevel.verbose));
      return dio;
    }())
    // Auth Data Sources
    ..registerSingleton<LocalAuthDatasource>(
      LocalAuthDatasourceImpl(locator<Box>()),
    )
    ..registerSingleton<RemoteAuthDatasource>(
      RemoteAuthDatasourceImpl(locator<Dio>()),
    )
    // Auth Repository
    ..registerSingleton<LoginRepository>(
      LoginRepositoryImpl(
        remoteDataSource: locator<RemoteAuthDatasource>(),
        localDataSource: locator<LocalAuthDatasource>(),
      ),
    );

  logger.info("✅ DI Setup Completed");
}
