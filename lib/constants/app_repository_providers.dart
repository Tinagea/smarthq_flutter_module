import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';

class AppRepositoryProviders {
  AppRepositoryProviders._();

  static final List<RepositoryProvider<dynamic>> repositoryProviders = [
    RepositoryProvider<LocalDataManager>(
      create: (context) => GetIt.I.get<LocalDataManager>(),
    ),
    RepositoryProvider<NativeStorage>(
      create: (context) => GetIt.I.get<NativeStorage>(),
    ),
    RepositoryProvider<ErdStorage>(
      create: (context) => GetIt.I.get<ErdStorage>(),
    ),
    RepositoryProvider<WifiCommissioningStorage>(
      create: (context) => GetIt.I.get<WifiCommissioningStorage>(),
    ),
    RepositoryProvider<BleCommissioningStorage>(
      create: (context) => GetIt.I.get<BleCommissioningStorage>(),
    ),
    RepositoryProvider<GatewayStorage>(
      create: (context) => GetIt.I.get<GatewayStorage>(),
    ),
    RepositoryProvider<SharedDataManager>(
      create: (context) => GetIt.I.get<SharedDataManager>(),
    ),
  ];

  static final List<RepositoryProvider<dynamic>> repositoryProvidersForDialog = [
    RepositoryProvider<LocalDataManager>(
      create: (context) => GetIt.I.get<LocalDataManager>(),
    ),
    RepositoryProvider<DialogStorage>(
      create: (context) => GetIt.I.get<DialogStorage>(),
    ),
    RepositoryProvider<SharedDataManager>(
      create: (context) => GetIt.I.get<SharedDataManager>(),
    ),
  ];
}