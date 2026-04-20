import 'package:finderapp/core/config/app_config.dart';
import 'package:finderapp/core/services/hive/global_hive.dart';
import 'package:finderapp/core/services/hive/hive_service.dart';
import 'package:finderapp/features/tracker/data/datasources/remote/geo_location_data_source.dart';
import 'package:finderapp/features/tracker/data/datasources/services/geo_location_service.dart';
import 'package:finderapp/features/tracker/data/repositories/geo_locator_repository_impl.dart';
import 'package:finderapp/features/tracker/domain/repositories/geo_locator_repository.dart';
import 'package:finderapp/features/tracker/domain/usecases/get_target_location_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // --------------- USECASES --------------- //
  sl.registerLazySingleton(() => GetTargetLocationUsecase(sl()));

  // --------------- SERVICES --------------- //
  sl.registerLazySingleton<GeoLocationService>(() => GeoLocationService(AppConfig.instance.dio, baseUrl: AppConfig.instance.baseUrl));
  sl.registerLazySingleton<GlobalHive>(() => GlobalHive());
  HiveService hiveService = HiveService();
  sl.registerLazySingleton<HiveService>(() => hiveService);
  await GetIt.instance<GlobalHive>().init(hiveService);

  // --------------- REPOSITORIES --------------- //
  sl.registerLazySingleton<GeoLocatorRepository>(() => GeoLocatorRepositoryImpl(sl()));

  // --------------- DATA SOURCES --------------- //
  sl.registerLazySingleton<GeoLocationDataSource>(() => GeoLocationDataSourceImpl(sl()));
}
