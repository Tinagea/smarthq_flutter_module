import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/stand_mixer_erd_parser.dart';
import 'package:smarthq_flutter_module/resources/repositories/appliance_service_repository.dart';
import 'package:smarthq_flutter_module/resources/repositories/native_repository.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/storage/storages.dart';
part 'erd_state.dart';

class ErdCubit extends Cubit<ErdState> implements ApplianceServiceObserver, NativeChannelObserver  {
  final ApplianceServiceRepository _applianceServiceRepository;
  final NativeStorage _nativeStorage;

  ErdCubit(this._applianceServiceRepository, this._nativeStorage) : super(ErdInitial()) {
    /// ERD cubit should not observe this. Cubit is by screen.
    // _applianceServiceRepository.addObserver(this);
  }
  Map<dynamic, dynamic> erds = {};
  List<String> erdExceptions = [];

  bool isStateInitial() => state is ErdInitial;

  bool isStateLoaded() => state is ErdLoaded;
  StandMixerErdParser _erdStandMixer = StandMixerErdParser();

  void resetState() {
    emit(ErdInitial());
  }

  Future<void> _awaitStateLoaded({int maxTryCount = 20}) async {
    int tryCount = 0;
    while (!isStateLoaded() && tryCount < maxTryCount) {
      await Future.delayed(Duration(milliseconds: 400));
      tryCount++;
    }
  }

  void getAllErds() {
    final jid = _nativeStorage.selectedAppliance;
    
    if (jid.toString().isEmpty || jid.toString() == "null") {
      geaLog.error("JID is null");
      return;
    }
    
    _applianceServiceRepository.requestCache(jid ?? "");
  }

  Future<String> updateErd(String applianceID, String key) async {
    final jid = _nativeStorage.selectedAppliance;
    key = key.toLowerCase();
    geaLog.debug("Updating ERD for $applianceID With Key $key");
    
    if(erds.containsKey(key)) {
      geaLog.debug("ERD already exists for $key");
      return erds[key];
    }
    
    emit(ErdLoading());
    _applianceServiceRepository.requestCache(jid!);
    await _awaitStateLoaded();
    String response = _handleResponse(key);
    geaLog.debug("ERD Received: $response");
    
    return response;
  }

  Future<void> postErd(String applianceID, String key, StandMixerAction action, String value,{bool commit = true}) async {
    String? erd;
    String? newStrip;
    String? jid = _nativeStorage.selectedAppliance;
    erd =  _handleErd(key);

    if (_erdStandMixer.erdStrip == null) {
      _erdStandMixer.erdStrip = erd;
    }

    newStrip = _erdStandMixer.doAction(action, value);
    erds[key] = newStrip;
    geaLog.debug("New Strip To Send: $newStrip");

    if (commit) {
      _applianceServiceRepository.postErd(jid!,key, newStrip);
      _erdStandMixer.clear();
    }
  }

  String? _handleErd(String key) {
    String? erd;
    try {
      if (key != ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS) {
        erd = erds[key];
      }
    } catch (e) {
      geaLog.debug("$key IS NOT READABLE");
    }

    return erd;
  }

  String _handleResponse(String key) {
    erds = (state as ErdLoaded).response!;
    geaLog.debug("ERD Received: ${erds[key]}");
    return erds[key];
  }

  Map<String, String> formatCache(List<Map<String, String>> cache){
    Map<String, String> cacheMap = {};

    for(Map<String, String> entry in cache){
      cacheMap[entry.keys.first] = entry.values.first;
    }

    return cacheMap;
  }

  void clearAllErds(){
    erds = {};
    _erdStandMixer.clear();
    emit(ErdInitial());
    geaLog.debug("ERD Cache Cleared");
  }

  void clearExceptionList(){
    erdExceptions = [];
  }

  @override
  void onChangeStatus(ApplianceServiceStatus status) {
    geaLog.debug("Appliance Service Status Changed: $status");
  }

  @override
  void onReceivedCache(String jid, List<Map<String, String>> cache, List<Map<String, String>> timestamps) {
    emit(ErdLoading());
    erds = formatCache(cache);
    geaLog.debug('erdUpdateResponse: $erds');
    emit(ErdLoaded(erds, exceptions: erdExceptions));
    clearExceptionList();
  }

  @override
  void onReceivedPostErdResult(String jid, String erdNumber, String erdValue, String status) {
    geaLog.debug("Post ERD Result: $status"); 
  }

  @override
  void onReceivedItem(NativeChannelListenType type, ChannelDataItem? item) {}

  @override
  void onReceivedErd(String jid, String erdNumber, String erdValue, String timestamp) {
    emit(ErdLoading());
    switch (erdNumber) {
      case ERD.TOASTER_OVEN_COOK_TIME_REMAINING:
        geaLog.debug("-------------ADDING 922F EXCEPTION------------");
        erdExceptions.add(ErdException.IS_TIMER_UPDATE);
        break;
      default:
    }
    erds[erdNumber] = erdValue;
    emit(ErdLoaded(erds, exceptions: erdExceptions));
  }
}
