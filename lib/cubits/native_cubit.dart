import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/managers/push_notification_manager.dart';
import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class NativeCubit extends Cubit<NativeState> implements NativeChannelObserver {

  late NativeRepository _nativeRepository;
  late ApplianceServiceRepository _applianceServiceRepository;
  late LocalDataManager _localDataManager;
  late SharedDataManager _sharedDataManager;
  late int _seedValue;
  
  NativeCubit(
      this._nativeRepository,
      this._applianceServiceRepository,
      this._localDataManager,
      this._sharedDataManager)
      : super(NativeState(seedValue: -1)) {
    geaLog.debug("NativeCubit is called");

    _nativeRepository.addObserver(this);
    _seedValue = 0;

  }

  @override
  Future<void> close() {
    _nativeRepository.removeObserver(this);
    return super.close();
  }

  @override
  void onReceivedItem(NativeChannelListenType type, ChannelDataItem? item) async {
    geaLog.debug("NativeCubit:onReceivedItem: type($type)");

    switch (type) {
      case NativeChannelListenType.startService:
        await _getTokens();
        _startService();
        break;

      case NativeChannelListenType.postPushToken:
        if (item is PushTokenChannelDataItem) {
          final pushToken = item.pushToken;
          final isLogin = item.isLogin;
          if (pushToken != null && isLogin != null)
            await PushNotificationManager().sendPushToken(pushToken, isLogin);
        }
        break;

      case NativeChannelListenType.routeToScreen:
        if (item is RoutingScreenChannelDataItem) {

          final nativeStorage = _localDataManager
              .getStorage(StorageType.native) as NativeStorage;

          // Set RoutingType
          final routingType = item.routingType!;
          nativeStorage.setRoutingType = routingType;

          // Set RoutingParameter
          final routingParameter = item.routingParameter;
          nativeStorage.setRoutingParameter = routingParameter;

          var routingContext = ContextUtil.instance.routingContext;
          geaLog.debug("routeToScreen:($routingType):context($routingContext)");
          if (routingContext != null) {
            try {
              /// In order to route, the app must move to MainRouter.
              Navigator.of(routingContext, rootNavigator: true).popUntil((route) => route.isFirst);
            } catch (error) {
              geaLog.debug(error);
              /// The app should not move to MainRouter
              /// The context may be freed from memory.
              /// This part will disappear when the improvement work using one Navigator is completed.
            }

            if(routingType == RoutingType.standMixer){
              handleStandMixer(routingContext);
            } else if(routingType == RoutingType.guidedRecipe){
              emit(state.copyWith(returnedRoute: Routes.RECIPE_DICOVER_PAGE));
            }
            if(routingType == RoutingType.guidedRecipe){
              emit(state.copyWith(returnedRoute: Routes.RECIPE_DICOVER_PAGE));
            }

          }
        }
        break;
    }
  }

  Future<void> fetchCountryCode() async {
    geaLog.debug('NativeCubit:_saveCountryCode()');
    await _nativeRepository.getCountryCode();
  }

  Future<void> _getTokens() async {
    final mdt = await _nativeRepository.getMdt();
    final geToken = await _nativeRepository.getGeToken();
    geaLog.debug('NativeCubit:getTokens() - mdt:$mdt, geToken:$geToken');

    await _sharedDataManager.setStringValue(SharedDataKey.mobileDeviceToken, mdt);
    await _sharedDataManager.setStringValue(SharedDataKey.geToken, geToken);
  }
  
  Future<void> _startService() async {
    await _applianceServiceRepository.startService();
  }

  Future<String> getLanguagePreference() {
    geaLog.debug('NativeCubit:getLanguagePreference()');
    return _nativeRepository.getLanguagePreference();
  }

  Future<void> showTopBar(bool show) {
    return _nativeRepository.showTopBar(show);
  }

  Future<void> showBottomBar(bool show) {
    return _nativeRepository.showBottomBar(show);
  }

  void closeFlutterScreen(){
    SystemNavigator.pop(animated: true);
  }

  Future<UserCountryCodeState> actionDirectRequestUserCountryCode() async {
    return await _nativeRepository.actionDirectRequestUserCountryCode();
  }

  Future<void> moveToOfflineScreen() async {
    return await _nativeRepository.moveToOfflineScreen();
  }
  
  /// This method is used to return the user back to the same screen if they have navigated away from the same Stand Mixer.
  /// It compares the last Jid with the current Jid & if it is the same it will emit the route String
  /// The Main Cubit then reads the string & routes the user to the same screen. Afterward, it will reset the route String to empty.
  /// This method is used by both IOS & Android to achieve the same result of returning the user back to their previous screen. 
  Future<void> handleStandMixer(BuildContext? context) async {
    clearReturnedRoute();
    final _nativeStorage = (_localDataManager.getStorage(StorageType.native) as NativeStorage);
    final currentJid = _nativeStorage.selectedAppliance!.split("_")[0].toUpperCase();
    final applianceJid = await _nativeRepository.getSelectedApplianceId();
    geaLog.debug('handleStandMixer:currentJid($currentJid), applianceJid($applianceJid)');
    if(context != null){
      final currentRoute = ModalRoute.of(context);
      geaLog.debug('handleStandMixer:currentRoute($currentRoute)');
      if(currentJid == applianceJid) {
        emit(state.copyWith(seedValue: _seedValue++, returnedRoute: currentRoute!.settings.name));
      }
    }
    _nativeStorage.setSelectedAppliance = applianceJid;
  }
  
  void clearReturnedRoute() {
    emit(NativeState());
  }
}
