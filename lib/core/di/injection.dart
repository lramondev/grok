import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;

import 'package:grok/core/network/api_client.dart';

import 'package:grok/data/repositories/auth_repository.dart';
import 'package:grok/data/repositories/holerite_repository.dart';
import 'package:grok/data/repositories/ponto_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final customHttpClient = await ApiClient.createCustomHttpClient();
  getIt.registerLazySingleton<http.Client>(() => customHttpClient);

  getIt.registerLazySingleton(() => ApiClient(getIt<http.Client>()));

  getIt.registerLazySingleton(() => AuthRepository(getIt<ApiClient>()));

  getIt.registerLazySingleton(() => HoleriteRepository(getIt<ApiClient>()));

  getIt.registerLazySingleton(() => PontoRepository(getIt<ApiClient>()));
}
