import 'package:get_it/get_it.dart';

import 'package:tiki_app_testing/services/api_client.dart';
import 'package:tiki_app_testing/repository/build_repository.dart';
import 'package:tiki_app_testing/repository/search_repository.dart';

GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerLazySingleton<ApiClient>(() => ApiClient());
  serviceLocator.registerLazySingleton<BuildRepository>(() => BuildRepository());
  serviceLocator.registerLazySingleton<SearchRepository>(() => SearchRepository());
}
