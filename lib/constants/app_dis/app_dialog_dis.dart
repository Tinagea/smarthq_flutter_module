import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/cubits/dialog/dialog_cubit.dart';
import 'package:smarthq_flutter_module/cubits/dialog/push_notification/push_notification_cubit.dart';
import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/repositories/dialog_repository.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';


class AppDialogDIs {
  static const String tag = "AppDialogDIs:";

  static void dependencyInjection({
    required ChannelManager channelManager}) {
    geaLog.debug("$tag:dependencyInjection()");

    /// Please keep the order of the function call below.
    /// Problems can arise depending on the order of class declarations.
    _storage();
    _storageManagers();
    _repositories(channelManager);
    _managers();
    _services();
    _cubits();
  }

  static void _storage() {

    GetIt.I.registerSingleton<DialogStorage>(
        DialogStorageImpl());

    GetIt.I.registerSingleton<ApiServiceStorage>(
        ApiServiceStorageImpl());
  }


  static void _storageManagers() {

    GetIt.I.registerSingleton<LocalDataManager>(
        LocalDataManagerImpl([
          GetIt.I.get<DialogStorage>(),
          GetIt.I.get<ApiServiceStorage>(),
        ]));

    GetIt.I.registerSingleton<SharedDataManager>(
        SharedDataManagerImpl());
  }


  static void _repositories(ChannelManager channelManager) {

    GetIt.I.registerSingleton<DialogRepository>(
        DialogRepositoryImpl(
          channelManager: channelManager,
          dialogStorage: GetIt.I.get<DialogStorage>()
        ));

    GetIt.I.registerSingleton<ApiServiceRepository>(
        ApiServiceRepositoryImpl(
            apiServiceStorage: GetIt.I.get<LocalDataManager>()
                .getStorage(StorageType.apiService) as ApiServiceStorage
        ));
  }


  static void _managers() {

  }


  static void _services() {

  }


  static void _cubits() {
    GetIt.I.registerSingleton<DialogCubit>(
        DialogCubit(
            GetIt.I.get<DialogRepository>(),
            GetIt.I.get<LocalDataManager>(),
            GetIt.I.get<SharedDataManager>()
        ));

    GetIt.I.registerFactory<PushNotificationCubit>(() =>
        PushNotificationCubit(
          GetIt.I.get<DialogRepository>()
        ));
  }
}