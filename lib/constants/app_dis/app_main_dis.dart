import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_get_started_cubit.dart';
import 'package:smarthq_flutter_module/resources/repositories/recipe_repository.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_brand_selection_cubit.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/resources/repositories/commissioning_brand_selection_repository.dart';
import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';

import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/services/erd_service.dart';
import 'package:smarthq_flutter_module/services/life_cycle_service.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/services/wifi_locker_service.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';

// shortcuts
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_edit_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_entry_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_review_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_select_type_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_create_cubit.dart';
import 'package:smarthq_flutter_module/resources/repositories/shortcut_service_repository.dart';
import 'package:smarthq_flutter_module/resources/storage/shortcut_storage.dart';

class AppMainDIs {
  static const String tag = "AppMainDIs:";

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

    GetIt.I.registerSingleton<NativeStorage>(
        NativeStorageImpl());
    GetIt.I.registerSingleton<ErdStorage>(
        ErdStorageImpl());
    GetIt.I.registerSingleton<ApiServiceStorage>(
        ApiServiceStorageImpl());
    GetIt.I.registerSingleton<WifiCommissioningStorage>(
        WifiCommissioningStorageImpl());
    GetIt.I.registerSingleton<BleCommissioningStorage>(
        BleCommissioningStorageImpl());
    GetIt.I.registerSingleton<GatewayStorage>(
        GatewayStorageImpl());
    GetIt.I.registerSingleton<ShortcutStorage>(
        ShortcutStorageImpl());
  }

  static void _storageManagers() {

    GetIt.I.registerSingleton<LocalDataManager>(
        LocalDataManagerImpl([
          GetIt.I.get<NativeStorage>(),
          GetIt.I.get<ErdStorage>(),
          GetIt.I.get<ApiServiceStorage>(),
          GetIt.I.get<WifiCommissioningStorage>(),
          GetIt.I.get<BleCommissioningStorage>(),
          GetIt.I.get<GatewayStorage>(),
          GetIt.I.get<ShortcutStorage>()
        ]));
    GetIt.I.registerSingleton<SharedDataManager>(
        SharedDataManagerImpl());
  }


  static void _repositories(ChannelManager channelManager) {
    GetIt.I.registerSingleton<NativeRepository>(
        NativeRepositoryImpl(
            channelManager: channelManager,
            nativeStorage: GetIt.I.get<LocalDataManager>()
                .getStorage(StorageType.native) as NativeStorage
        ));
    GetIt.I.registerSingleton<CommissioningRepository>(
        CommissioningRepositoryImpl(
            channelManager: channelManager
        ));
    GetIt.I.registerSingleton<BleCommissioningRepository>(
        BleCommissioningRepositoryImpl(
            channelManager: channelManager
        ));
    GetIt.I.registerSingleton<ApiServiceRepository>(
        ApiServiceRepositoryImpl(
            apiServiceStorage: GetIt.I.get<LocalDataManager>()
                .getStorage(StorageType.apiService) as ApiServiceStorage
        ));
    GetIt.I.registerSingleton<ApplianceServiceRepository>(
        ApplianceServiceRepositoryImpl(
            channelManager: channelManager,
            erdStorage: GetIt.I.get<LocalDataManager>()
                .getStorage(StorageType.erd) as ErdStorage,
            sharedDataManager: GetIt.I.get<SharedDataManager>(),
            nativeStorage: GetIt.I.get<LocalDataManager>()
                .getStorage(StorageType.native) as NativeStorage
        ));
    GetIt.I.registerSingleton<RecipeRepository>(
        RecipeRepositoryImpl());
    GetIt.I.registerSingleton<CommissioningBrandSelectionRepository>(
        CommissioningBrandSelectionRepository.newInstance());

    GetIt.I.registerSingleton<ShortcutServiceRepository>(
        ShortcutServiceRepositoryImpl(
          channelManager: channelManager,
          sharedDataManager: GetIt.I.get<SharedDataManager>(),
        ));
  }


  static void _managers() {

    GetIt.I.registerSingleton<PushNotificationManager>(
        PushNotificationManager()..initialize(
            GetIt.I.get<ApiServiceRepository>(),
            GetIt.I.get<SharedDataManager>()
        ));

    GetIt.I.registerSingleton<DialogManager>(
        DialogManager());
  }


  static void _services() {

    GetIt.I.registerSingleton<WifiLockerService>(
        WifiLockerService(
            GetIt.I.get<ApiServiceRepository>(),
            GetIt.I.get<NativeRepository>()
        ));
    
    GetIt.I.registerSingleton<ErdService>(
        ErdService());

    GetIt.I.registerSingleton<LifeCycleService>(
        LifeCycleServiceImpl()
          ..addObserver(
              GetIt.I.get<ApplianceServiceRepository>() as LifeCycleObserver
          ));

    GetIt.I.registerSingleton<ShortcutService>(
        ShortcutService(
            GetIt.I.get<SharedDataManager>()
        ));
  }


  static void _cubits() {

    GetIt.I.registerSingleton<NativeCubit>(
        NativeCubit(
            GetIt.I.get<NativeRepository>(),
            GetIt.I.get<ApplianceServiceRepository>(),
            GetIt.I.get<LocalDataManager>(),
            GetIt.I.get<SharedDataManager>()
        ));

    GetIt.I.registerSingleton<CommissioningCubit>(
        CommissioningCubit(
            GetIt.I.get<CommissioningRepository>(),
            GetIt.I.get<WifiLockerService>(),
            GetIt.I.get<LocalDataManager>()
        ));

    GetIt.I.registerSingleton<BleCommissioningCubit>(
        BleCommissioningCubit(
            GetIt.I.get<BleCommissioningRepository>(),
            GetIt.I.get<ApiServiceRepository>(),
            GetIt.I.get<WifiLockerService>(),
            GetIt.I.get<LocalDataManager>()
        ));

    GetIt.I.registerSingleton<RecipeCubit>(
        RecipeCubit(
            GetIt.I.get<RecipeRepository>()
        ));

    GetIt.I.registerSingleton<RecipeStepsCubit>(
        RecipeStepsCubit(
            GetIt.I.get<RecipeRepository>(),
            GetIt.I.get<ApplianceServiceRepository>(),
            GetIt.I.get<LocalDataManager>()
                .getStorage(StorageType.native) as NativeStorage,
            GetIt.I.get<SharedDataManager>()
        ));

    GetIt.I.registerSingleton<RecipeDetailsCubit>(
        RecipeDetailsCubit());

    GetIt.I.registerSingleton<NotificationSettingCubit>(
        NotificationSettingCubit(
            GetIt.I.get<NativeRepository>(),
            GetIt.I.get<ApiServiceRepository>()
        ));

    GetIt.I.registerSingleton<NotificationHistoryCubit>(
        NotificationHistoryCubit(
            GetIt.I.get<NativeRepository>(),
            GetIt.I.get<ApiServiceRepository>()
        ));

    GetIt.I.registerFactory<CommissioningBrandSelectionCubit>(() =>
        CommissioningBrandSelectionCubit(
            GetIt.I.get<CommissioningBrandSelectionRepository>()
        ));

    GetIt.I.registerSingleton<ApplianceCubit>(
        ApplianceCubit(
            GetIt.I.get<LocalDataManager>(),
            GetIt.I.get<ApiServiceRepository>(),
            GetIt.I.get<NativeRepository>()
        ));

    GetIt.I.registerSingleton<ErdCubit>(
        ErdCubit(
            GetIt.I.get<ApplianceServiceRepository>(),
            GetIt.I.get<LocalDataManager>()
                .getStorage(StorageType.native) as NativeStorage
        ));
    GetIt.I.registerFactory<StandMixerControlCubit>(() =>
        StandMixerControlCubit(
            GetIt.I.get<NativeRepository>(),
            GetIt.I.get<ApiServiceRepository>(),
            GetIt.I.get<ApplianceServiceRepository>(),
            GetIt.I.get<ErdService>(),
            GetIt.I.get<NativeStorage>(),
            GetIt.I.get<ErdStorage>(),
            GetIt.I.get<SharedDataManager>()
        ));

    GetIt.I.registerFactory<ToasterOvenControlCubit>(() =>
        ToasterOvenControlCubit(
            GetIt.I.get<NativeRepository>(),
            GetIt.I.get<ApplianceServiceRepository>(),
            GetIt.I.get<ErdService>(),
            GetIt.I.get<NativeStorage>(),
            GetIt.I.get<ErdStorage>()
        ));

    /// Shortcuts
    GetIt.I.registerFactory<ShortcutEntryCubit>(() =>
        ShortcutEntryCubit(
            GetIt.I.get<ShortcutServiceRepository>(),
            GetIt.I.get<ApiServiceRepository>(),
            GetIt.I.get<LocalDataManager>()
        ));

    GetIt.I.registerFactory<ShortcutSelectTypeCubit>(() =>
        ShortcutSelectTypeCubit(
            GetIt.I.get<LocalDataManager>()
        ));

    GetIt.I.registerFactory<ShortcutCreateCubit>(() =>
        ShortcutCreateCubit(
            GetIt.I.get<ShortcutServiceRepository>(),
            GetIt.I.get<ShortcutService>(),
            GetIt.I.get<LocalDataManager>()
        ));

    GetIt.I.registerFactory<ShortcutReviewCubit>(() =>
        ShortcutReviewCubit(
            GetIt.I.get<ShortcutServiceRepository>(),
            GetIt.I.get<ShortcutService>(),
            GetIt.I.get<LocalDataManager>()
        ));

    GetIt.I.registerFactory<ShortcutEditCubit>(() =>
        ShortcutEditCubit(
            GetIt.I.get<ShortcutServiceRepository>(),
            GetIt.I.get<ShortcutService>(),
            GetIt.I.get<LocalDataManager>()
        ));

    GetIt.I.registerFactory<ShortcutGetStartedCubit>(() =>
        ShortcutGetStartedCubit(
          GetIt.I.get<ShortcutServiceRepository>()
        ));
  }
}