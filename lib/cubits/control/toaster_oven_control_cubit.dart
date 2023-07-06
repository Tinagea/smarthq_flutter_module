/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/models/control/toaster_oven_control_model.dart';
import 'package:smarthq_flutter_module/models/routing_model.dart';
import 'package:smarthq_flutter_module/resources/erd/0x0099.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';
import 'package:smarthq_flutter_module/resources/erd/toaster_oven/0x9209.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_service_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_presence_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_device_response.dart';
import 'package:smarthq_flutter_module/resources/repositories/appliance_service_repository.dart';
import 'package:smarthq_flutter_module/resources/repositories/native_repository.dart';
import 'package:smarthq_flutter_module/resources/storage/erd_storage.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/services/erd_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ToasterOvenStateDefaultValue {
  static const int timerMinRemaining = 0;
  static const int timerSecRemaining = 0;
}

class ToasterOvenControlCubit extends Cubit<ToasterOvenControlState> implements ApplianceServiceObserver, ApplianceServiceDataModelObserver {
  static const String tag = "ToasterOvenControlCubit:";

  late NativeRepository _nativeRepository;
  late ApplianceServiceRepository _applianceServiceRepository;
  late ErdService _erdService;
  late ErdStorage _erdStorage;
  late NativeStorage _nativeStorage;
  late int _seedValue;

  String? currentJid;
  String? currentApplianceId;
  bool bakeCanceled = false;
  
  ToasterOvenControlCubit(
      this._nativeRepository,
      this._applianceServiceRepository,
      this._erdService,
      this._nativeStorage,
      this._erdStorage,
      )
      : super(ToasterOvenControlState(seedValue: -1)) {
    geaLog.debug("ToasterOvenControlCubit is called");

    _seedValue = 0;
    _applianceServiceRepository.addObserver(this);
    _applianceServiceRepository.addDataModelObserver(this);
    _nativeStorage.setIsModelNumberValidationRequested = false;
  }
  
  @override
  void onChangeStatus(ApplianceServiceStatus status) {
    geaLog.debug("Appliance Service Status Changed: $status");
    RoutingType _routingType = _nativeStorage.routingType;
    if(status == ApplianceServiceStatus.inService && _routingType == RoutingType.guidedRecipe) {
      requestCache();
    }
  }

  @override
  void onReceivedCache(String jid, List<Map<String, String>> cache,  List<Map<String, String>> timestamps) {
    geaLog.debug("$tag onReceivedCache");
    geaLog.debug("CACHE PASSED JID $jid");
    final onlyApplianceId = _getJidWithoutHomeId(jid)?.toUpperCase();
    
    currentJid = jid;
    
    if (onlyApplianceId != currentApplianceId) {
      geaLog.debug("$tag onReceivedCache not my appliance $onlyApplianceId/$currentApplianceId");
      return;
    } else {
      currentApplianceId = jid.split("_")[0].toUpperCase();
      //store the appliance id
      _nativeStorage.setSelectedAppliance = currentApplianceId;
    }

    emit(state.copyWith(
        seedValue: _seedValue++,
        erdState: ToasterOvenErdState.loading
    ));

    final formattedCache = _applianceServiceRepository.formatCache(cache);
    geaLog.debug("ToasterOvenControlCubit: onReceivedCache formattedCache - $formattedCache");

    emit(state.copyWith(
        seedValue: _seedValue++,
        erdState: ToasterOvenErdState.loaded,
        cache: formattedCache,
    ));
    
  }

  @override
  void onReceivedPostErdResult(String jid, String erdNumber, String erdValue, String status) {
    geaLog.debug("Post ERD Result: $status");
  }

  @override
  void onReceivedErd(String jid, String erdNumber, String erdValue, String timestamp) {
    geaLog.debug("$tag onReceivedErd $jid");
    geaLog.debug("ERD PASSED JID $jid");
    
    final onlyApplianceId = _getJidWithoutHomeId(jid)?.toUpperCase();
    if (onlyApplianceId != currentApplianceId) {
      geaLog.debug("$tag onReceivedErd not my appliance $onlyApplianceId/$currentApplianceId");
      return;
    } else {
      currentApplianceId = onlyApplianceId;
      _nativeStorage.setSelectedAppliance = currentApplianceId;
    }

    _erdStorage.setErdValue(jid, erdNumber, erdValue);

    final cache = _applianceServiceRepository.getCache(jid);
    var formattedCache = _applianceServiceRepository.formatCache(cache);
    if (erdNumber == ERD.TOASTER_OVEN_CURRENT_STATE ||
        (erdNumber == ERD.TOASTER_OVEN_COOK_TIME_REMAINING && !bakeCanceled)
    ) {
      emit(state.copyWith(
          erdState: ToasterOvenErdState.loaded,
          seedValue: _seedValue++,
          cache: formattedCache,
      ));
    }
  }

  Future<void> requestCache() async {
    geaLog.debug("$tag requestCache");
    final applianceId = await _getSelectedAppliance();
    currentApplianceId = applianceId ?? "";
    if (applianceId != null && applianceId != "") {
      geaLog.debug("$tag requestCache applianceId - $applianceId");
      _applianceServiceRepository.requestCache(applianceId);
    }
  }

  Future<void> postErd(String? key, String? value) async {
    geaLog.debug("$tag postErd - key $key and value $value");
    if (key == null || value == null) {
      return;
    }

    if (currentApplianceId == "") {
      currentApplianceId = await _getSelectedAppliance() ?? "";
    }


    geaLog.debug("$tag postErd jid - $currentJid");
    String? _currentJid = currentJid ?? "";
    _applianceServiceRepository.postErd(_currentJid , key, value);
  }

  Future<String?> _getSelectedAppliance() async {
    final selectedAppliance = await _nativeRepository.getSelectedApplianceId();
    if(currentJid == null || currentJid!.isEmpty){
      currentJid = selectedAppliance!;
    }
    _nativeStorage.setSelectedAppliance = selectedAppliance!.split("_")[0].toUpperCase();

    return selectedAppliance.split("_")[0].toUpperCase();
  }
  

  String? getRemainingCookTimeSeconds(Map<String, String>? cache) {
    final value = cache?[ERD.TOASTER_OVEN_COOK_TIME_REMAINING];
    return getRemainingCookTimeSecondsFromValue(value);
  }


  String? getRemainingCookTimeSecondsFromValue(String? value) {
    geaLog.debug("$tag getRemainingCookTimeSecondsFromValue: $value");
    if (value == null) {
      return null;
    }
    return _erdService.getRemainingCookTimeSeconds(value);
  }
  

  ToasterOvenCurrentState getToasterOvenCurrentState() {
    geaLog.debug("$tag getToasterOvenCurrentState - cache: ${state.cache}");
    final value = state.cache?[ERD.TOASTER_OVEN_CURRENT_STATE];

    return getToasterOvenCurrentStateFromValue(value);
  }

  ToasterOvenCurrentState getToasterOvenCurrentStateFromValue(String? value) {
    geaLog.debug("$tag getToasterOvenCurrentStateFromValue: $value");
    if (value == null) {
      return ToasterOvenCurrentState.TOASTER_OVEN_SLEEP;
    }

    return _erdService.getToasterOvenState(value);
  }
  

  String? _getJidWithoutHomeId(String? jid) {
    final split = jid?.split("_");
    return split?[0];
  }
  
  void cancelBake(){
    emit(state.copyWith());
    postErd(ERD.TOASTER_OVEN_CANCEL_OPERATION, "01");
  }

  Future<void> clearRecipeStatus() async {
    emit(state.copyWith(
        seedValue: _seedValue++,
        erdState: ToasterOvenErdState.loading
    ));
    String _jid = _nativeStorage.selectedAppliance ?? "";
    _erdStorage.setErdValue(_jid, ERD.RECIPE_STATUS, "0000000000000000000000000000000000000000000000");
    final cache = _applianceServiceRepository.getCache(_jid);
    var formattedCache = _applianceServiceRepository.formatCache(cache);
    //emit state
    emit(state.copyWith(
        seedValue: _seedValue++,
        erdState: ToasterOvenErdState.loaded,
        state: ToasterOvenState.contentResponse,
        cache: formattedCache
    ));
  }

  String getBrandName() {
    Map<String, String> cache = state.cache ?? {};
    if(cache.containsKey(ERD.APPLIANCE_BRAND_TYPE)){
      return ERD0x0099(cache[ERD.APPLIANCE_BRAND_TYPE]!).brandName ?? "";      
    } else {
      return "";
    }
  }

  @override
  Future<void> close() {
    _applianceServiceRepository.removeObserver(this);
    return super.close();
  }

  @override
  void pubSubCommand() {
  }

  @override
  void pubSubDevice(WebSocketPubSubDeviceResponse response) {
  }

  @override
  void pubSubPresence(WebSocketPubSubPresenceResponse response) {
    if(response.deviceId == currentApplianceId){
      if(response.presence == "offline"){
        emit(state.copyWith(
          seedValue: _seedValue++,
          presence: DevicePresence.offline
        ));
      } else {
        emit(state.copyWith(
          seedValue: _seedValue++,
          presence: DevicePresence.online
        ));
      }
    }
  }

  @override
  void pubSubService(WebSocketPubSubServiceResponse response) {
  }

}
