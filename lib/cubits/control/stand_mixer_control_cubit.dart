import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/models/appliance_modifications_model.dart';
import 'package:smarthq_flutter_module/models/control/stand_mixer_control_model.dart';
import 'package:smarthq_flutter_module/resources/erd/0x0099.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9300.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9301.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9303.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9305.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9309.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/stand_mixer_erd_parser.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_service_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_presence_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/web_socket_pub_sub_device_response.dart';
import 'package:smarthq_flutter_module/resources/repositories/api_service_repository.dart';
import 'package:smarthq_flutter_module/resources/repositories/appliance_service_repository.dart';
import 'package:smarthq_flutter_module/resources/repositories/native_repository.dart';
import 'package:smarthq_flutter_module/resources/storage/erd_storage.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/services/erd_model.dart';
import 'package:smarthq_flutter_module/services/erd_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class StandMixerStateDefaultValue {
  static const bool isReversed = false;
  static const bool isRunning = false;
  static const bool isPaused = false;
  static const bool isIdle = false;

  static const int directionValue = 0;
  static const bool shouldSendSpeedValueWhileMixing = false;

  static const double currentSliderValue = 0.015; // sets to this start value to offset clipping with text
  static const double sliderMaxVal = 1; // default value, changed upon ERD 9303 update
  static const double sliderMinVal = 0;
  static const int timerMinRemaining = 0;
  static const int timerSecRemaining = 0;
}

class SendToMixerObject {
  String erdStrip;
  SendToMixerObject(this.erdStrip);
}

class StandMixerControlCubit extends Cubit<StandMixerControlState> implements ApplianceServiceObserver, ApplianceServiceDataModelObserver {
  static const String tag = "StandMixerControlCubit:";

  late NativeRepository _nativeRepository;
  late ApiServiceRepository _apiServiceRepository;
  late ApplianceServiceRepository _applianceServiceRepository;
  late ErdService _erdService;
  late ErdStorage _erdStorage;
  late NativeStorage _nativeStorage;
  late SharedDataManager _sharedDataManager;
  late int _seedValue;
  String _currentJid = "";
  String _currentApplianceId = "";
  Map<String, String>? failedCache;
  bool _isActiveStirActivated = false;

  StandMixerControlCubit(
      this._nativeRepository,
      this._apiServiceRepository,
      this._applianceServiceRepository,
      this._erdService,
      this._nativeStorage,
      this._erdStorage,
      this._sharedDataManager
      )
      : super(StandMixerControlState(seedValue: -1)) {
    geaLog.debug("StandMixerControlCubit is called");

    _seedValue = 0;
    _applianceServiceRepository.addObserver(this);
    _applianceServiceRepository.addDataModelObserver(this);
    _nativeStorage.setIsModelNumberValidationRequested = false;
  }

  StandMixerErdParser _erdParser = StandMixerErdParser();

  @override
  void onChangeStatus(ApplianceServiceStatus status) {
   geaLog.debug("Appliance Service Status Changed: $status");
   if(status == ApplianceServiceStatus.inService) {
    requestCache();
   }
  }
  
  @override
  void onReceivedCache(String jid, List<Map<String, String>> cache, List<Map<String, String>> timestamps) {
   geaLog.debug("$tag onReceivedCache");

   final onlyJid = _getJidWithoutHomeId(jid)?.toUpperCase();
  
   if (onlyJid != _currentJid) {
     geaLog.debug("$tag onReceivedCache not my appliance $onlyJid/$_currentJid");
     return;
   } else {
     _currentApplianceId = jid;
    //store the appliance id
    _nativeStorage.setSelectedAppliance = _currentApplianceId;
   }
  
   emit(state.copyWith(
       seedValue: _seedValue++,
       erdState: StandMixerErdState.loading
   ));

    final formattedCache = _applianceServiceRepository.formatCache(cache);
    geaLog.debug("StandMixerControlCubit: onReceivedCache formattedCache - $formattedCache");
    emit(state.copyWith(
        seedValue: _seedValue++,
        state: StandMixerState.cacheResponse,
        erdState: StandMixerErdState.loaded,
        cache: formattedCache
    ));

    final stateModel = _getContentModel(formattedCache);
    emit(state.copyWith(
        seedValue: _seedValue++,
        state: StandMixerState.contentResponse,
        erdState: StandMixerErdState.loaded,
        cache: formattedCache,
        contentModel: stateModel
    ));

    requestModelValidation(formattedCache[ERD.APPLIANCE_MODEL_NUMBER]);

    String _mixerStateTimestamp = "";
    timestamps.forEach((element) {
      if(element.containsKey(ERD.STAND_MIXER_STATE)) {
        _mixerStateTimestamp = element.values.first;
      }
    });
    isActiveStirEnabled(_mixerStateTimestamp);
  }

  @override
  void onReceivedPostErdResult(String jid, String erdNumber, String erdValue, String status) {
    geaLog.debug("Post ERD Result: $status");
    
    final onlyJid = _getJidWithoutHomeId(jid)?.toUpperCase();
    if (onlyJid != _currentJid) {
      geaLog.debug("$tag onReceivedPostErdResult not my appliance $onlyJid/$_currentJid");
      return;
    }
    if(erdNumber == ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS && status != "success") {
      geaLog.debug("Post ERD Result: $status");
      emit(state.copyWith(
          seedValue: _seedValue++,
          state: StandMixerState.cacheResponse,
          erdState: StandMixerErdState.loaded,
          cache: failedCache
      ));
    }
  }

  @override
  void onReceivedErd(String jid, String erdNumber, String erdValue, String timeStamp) {
    geaLog.debug("$tag onReceivedErd $jid");

    final onlyJid = _getJidWithoutHomeId(jid)?.toUpperCase();
    if (onlyJid != _currentJid) {
      geaLog.debug("$tag onReceivedErd not my appliance $onlyJid/$_currentJid");
      return;
    } else {
      _currentApplianceId = jid;
      _nativeStorage.setSelectedAppliance = _currentApplianceId;
    }

    _erdStorage.setErdValue(jid, erdNumber, erdValue);

    final cache = _applianceServiceRepository.getCache(jid);
    var formattedCache = _applianceServiceRepository.formatCache(cache);
     if (erdNumber == ERD.STAND_MIXER_STATE ||
        erdNumber == ERD.TOASTER_OVEN_COOK_TIME_REMAINING ||
        erdNumber == ERD.STAND_MIXER_CONTROL_SETTINGS_LIMITS
        || erdNumber == ERD.STAND_MIXER_MODE_STATE
        ) {
        if(erdNumber == ERD.STAND_MIXER_STATE && erdValue == "01"){
          if(_isActiveStirActivated == true){
            sendStartActiveStir();
          }
          //Save the timestamp to local storage
          saveTimeStampToLocalStorage(timeStamp);
        }

      final stateModel = _getContentModel(formattedCache);
      emit(state.copyWith(
          seedValue: _seedValue++,
          state: StandMixerState.contentResponse,
          erdState: StandMixerErdState.loaded,
          cache: formattedCache,
          contentModel: stateModel
      ));
    } else if (erdNumber == ERD.APPLIANCE_MODEL_NUMBER) {
      requestModelValidation(erdValue);
    } else if (erdNumber == ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS){
      if(sentMixData == true){
        sentMixData = false;
        return;
      }
    }
  }

  Future<void> requestCache() async {
    geaLog.debug("$tag requestCache");
    final jid = await _getSelectedAppliance();
    _currentJid = jid ?? "";
    if (jid != null && jid != "") {
      geaLog.debug("$tag requestCache jid - $jid");
      _applianceServiceRepository.requestCache(jid);
    }
  }

  bool sentMixData = false;
  Future<void> postErd(String? key, String? value) async {
    geaLog.debug("$tag postErd - key $key and value $value");
    if (key == null || value == null) {
      return;
    }
    if (_currentJid == "") {
      _currentJid = await _getSelectedAppliance() ?? "";
    }
    if(key == ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS){
      sentMixData = true;
    }
    geaLog.debug("$tag postErd jid - $_currentApplianceId");
    _applianceServiceRepository.postErd(_currentApplianceId, key, value);
  }

  void sendCyclePaused() {
    postErd(ERD.STAND_MIXER_PAUSE_MIXING_CYCLE, "01");
  }



  void sendStartMixData(String? speed, int? timerSecRemaining, int? direction) {
    if (speed == null ||
        timerSecRemaining == null) {
      geaLog.debug("$tag sendStartMixData: can't send - $speed, $timerSecRemaining, $direction");
      return;
    }
    geaLog.debug("$tag sendStartMixData - $speed, $timerSecRemaining, $direction");
    final isSpeedChanged = didChangeSpeed(speed);
    geaLog.debug("$tag sendStartMixData isSpeedChanged - $isSpeedChanged");
    var isTimerChanged = didChangeTimer(timerSecRemaining);
    geaLog.debug("$tag sendStartMixData isTimerChanged - $isTimerChanged");
    final isDirectionChanged = didChangeDirection(direction ?? 0);
    geaLog.debug("$tag sendStartMixData isDirectionChanged - $isDirectionChanged");

    final cache = _applianceServiceRepository.getCache(_currentApplianceId);
    final formattedCache = _applianceServiceRepository.formatCache(cache);
    final storedErdValue = formattedCache[ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS];
    
    StandMixerContentModel? _contentModel = _getContentModel(formattedCache);
    
    if( _contentModel != null && _contentModel.isRunning!){
      isTimerChanged = false;
      timerSecRemaining = 0;
    }

    String sendingValue = "";
    
    if (isSpeedChanged && isTimerChanged && isDirectionChanged) {
      sendingValue = _erdParser.controlSettings(storedErdValue,
          speed, timerSecRemaining.toString(), direction.toString());
    } else if (isSpeedChanged && isTimerChanged && !isDirectionChanged) {
      sendingValue = _erdParser.controlSettings(storedErdValue,
          speed, timerSecRemaining.toString(), null);
    } else if (isSpeedChanged && !isTimerChanged && isDirectionChanged) {
      sendingValue = _erdParser.controlSettings(storedErdValue,
          speed, timerSecRemaining.toString(), direction.toString());
    } else if (!isSpeedChanged && isTimerChanged && isDirectionChanged) {
      sendingValue = _erdParser.controlSettings(storedErdValue,
          null, timerSecRemaining.toString(), direction.toString());
    } else if (!isSpeedChanged && !isTimerChanged && isDirectionChanged) {
      sendingValue = _erdParser.controlSettings(storedErdValue,
          null, null, direction.toString());
    } else if (isSpeedChanged && !isTimerChanged && !isDirectionChanged) {
      sendingValue = _erdParser.controlSettings(storedErdValue,
          speed, timerSecRemaining.toString(), null);
    } else if (!isSpeedChanged && isTimerChanged && !isDirectionChanged) {
      sendingValue = _erdParser.controlSettings(storedErdValue,
          null, timerSecRemaining.toString(), null);
    } else {
      sendingValue = _erdParser.controlSettings(storedErdValue,
          speed, timerSecRemaining.toString(), direction.toString());
    }    

    failedCache = formattedCache;

    postErd(ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS, sendingValue);
    //cache the speed, timer, and direction
    _erdStorage.setErdValue(_currentJid,ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS, sendingValue);
    state.cache![ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS] = sendingValue;
    // remove first four characters of sendingValue and set it to current settings
    final currentSettings = sendingValue.substring(4);
    state.cache![ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS] = currentSettings;
    _erdStorage.setErdValue(_currentJid,ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS, currentSettings);

  }

 Future<void> requestModelValidation(String? modelNumber) async {
    geaLog.debug("StandMixerControlCubit: requestModelValidation");
    if (modelNumber == null) {
      return;
    }

    if (_nativeStorage.isModelNumberValidationRequested) {
      return;
    }

    final isModelNumberValid = await _apiServiceRepository.requestModelValidation(modelNumber);
    _nativeStorage.setIsModelNumberValidationRequested = true;

    if(!isModelNumberValid) {
      _nativeRepository.moveToModelNumberValidationScreen();
    }
  }

  Future<void> showTopBar(bool show) {
    return _nativeRepository.showTopBar(show);
  }

  Future<void> showBottomBar(bool show) {
    return _nativeRepository.showBottomBar(show);
  }

  Future<String?> _getSelectedAppliance() async {
    final selectedAppliance = await _nativeRepository.getSelectedApplianceId();
    if(_currentJid.isEmpty){
      _currentJid = selectedAppliance!.split("_")[0].toUpperCase();
    }
    _nativeStorage.setSelectedAppliance = selectedAppliance!.split("_")[0].toUpperCase();

    return selectedAppliance.split("_")[0].toUpperCase();
  }

  /// Get ERD converted value
  StandMixerContentModel? _getContentModel(Map<String, String>? cache) {
    final mixerMode = getMixerModeString(cache) ?? "";

    final currentSpeedLimits = getControlSettingsSpeedLimits(cache);
    double sliderMaxVal = 0;
    double sliderMinVal = 0;
    if (currentSpeedLimits != null) {
      sliderMaxVal = double.tryParse(currentSpeedLimits.max.toString()) ?? 0;
      sliderMinVal = double.tryParse(currentSpeedLimits.min.toString()) ?? 0;
    }

    final currentSettings = getMixerControlCurrentSettings(cache);
    double currentSliderValue = (double.tryParse(((currentSettings?.speed ?? 0) / sliderMaxVal).toString()) ?? 0);
    int timerSecRemaining = currentSettings?.timer ?? 0;
    final directionValue = currentSettings?.direction == MixerDirection.forward ? 1
        : currentSettings?.direction == MixerDirection.reverse ? 2 : 0;
    final isReversed = currentSettings?.direction == MixerDirection.reverse;
    if (currentSliderValue < 0.015) {
      currentSliderValue = 0.015; //sets & limits start position right to a more symmetrical start position
    }
    else if (currentSliderValue > 0.985) {
      currentSliderValue = 0.985; //limits ending position to a more  symmetrical end position
    }

    int timerMinRemaining = timerSecRemaining ~/ 60;
    final timerValue = getRemainingCookTimeSeconds(cache);
    final parsedRemainingTime = int.tryParse(timerValue!);
    if (timerMinRemaining != parsedRemainingTime! ~/ 60 && parsedRemainingTime > 0) {
      timerSecRemaining = parsedRemainingTime;
    }
    if(parsedRemainingTime == 0) {
      timerMinRemaining = 0;
    }

    final cycleState = getMixerCycleState(cache);
    final mixerState = cycleState;
    final isRunning = (mixerState == CycleState.mixing);
    final isPaused = (mixerState == CycleState.paused);
    final isIdle = (mixerState == CycleState.idle);

    final availableModifications = getAvailableModifications(cache);
  

    return StandMixerContentModel (
        mixerMode: mixerMode,
        mixerState: mixerState,
        isReversed: isReversed,
        isRunning: isRunning,
        isPaused: isPaused,
        isIdle: isIdle,
        timerMinRemaining: timerMinRemaining,
        timerSecRemaining: timerSecRemaining,
        directionValue: directionValue,
        currentSliderValue: currentSliderValue,
        sliderMaxVal: sliderMaxVal,
        sliderMinVal: sliderMinVal,
        availableModifications: availableModifications,
        isActiveStirEnabled: _isActiveStirActivated,
    );
  }

  StandMixerContentModel? setStateContentModel({
    required StandMixerContentModel? model,
    String? mixerMode,
    String? mixerState,
    bool? isReversed,
    bool? isRunning,
    bool? isPaused,
    bool? isIdle,
    bool? shouldScroll,
    int? timerMinRemaining,
    int? timerSecRemaining,
    int? directionValue,
    double? currentSliderValue,
    double? sliderMaxVal,
    double? sliderMinVal,
    ApplianceAvailableModifications? availableModifications,
    bool? isActiveStirEnabled,
    }){

    if (model == null) {
      return null;
    }

    if(isActiveStirEnabled != null){
      _isActiveStirActivated = isActiveStirEnabled;
    }

    return StandMixerContentModel (
        mixerMode: mixerMode ?? model.mixerMode,
        mixerState: mixerState ?? model.mixerState,
        isReversed: isReversed ?? model.isReversed,
        isRunning: isRunning ?? model.isRunning,
        isPaused: isPaused ?? model.isPaused,
        isIdle: isIdle ?? model.isIdle,
        shouldScroll: shouldScroll ?? model.shouldScroll,
        timerMinRemaining: timerMinRemaining ?? model.timerMinRemaining,
        timerSecRemaining: timerSecRemaining ?? model.timerSecRemaining,
        directionValue: directionValue ?? model.directionValue,
        currentSliderValue: currentSliderValue ?? model.currentSliderValue,
        sliderMaxVal: sliderMaxVal ?? model.sliderMaxVal,
        sliderMinVal: sliderMinVal ?? model.sliderMinVal,
        availableModifications: availableModifications ?? model.availableModifications,
        isActiveStirEnabled: isActiveStirEnabled ?? model.isActiveStirEnabled
    );

  }

  String? getMixerModeString(Map<String, String>? cache) {
    final value = cache?[ERD.STAND_MIXER_MODE_STATE];
    return getMixerModeStringFromValue(value);
  }

  String? getMixerModeStringFromValue(String? value) {
    geaLog.debug("$tag getMixerModeStringFromValue: $value");
    if (value == null) {
      return LocaleUtil.OFF;
    }

    return _erdService.getMixerMode(value).toFormatted();
  }

  String? getRemainingCookTimeSeconds(Map<String, String>? cache) {
    final value = cache?[ERD.TOASTER_OVEN_COOK_TIME_REMAINING];
    return getRemainingCookTimeSecondsFromValue(value);
  }

  String? getCookTimeSetSeconds(Map<String, String>? cache) {
    final value = cache?[ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS];
    return getMixerControlCurrentSettingsFromValue(value)?.timer.toString();
  }


  String? getRemainingCookTimeSecondsFromValue(String? value) {
    geaLog.debug("$tag getRemainingCookTimeSecondsFromValue: $value");
    if (value == null) {
      return null;
    }
    return _erdService.getRemainingCookTimeSeconds(value);
  }

  int? getStandMixerCurrentSetSpeed(Map<String, String>? cache) {
    final value = cache?[ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS];
    return getStandMixerCurrentSetSpeedFromValue(value);
  }

  int? getStandMixerCurrentSetSpeedFromValue(String? value) {
    geaLog.debug("$tag getStandMixerCurrentSetSpeedFromValue: $value");
    if (value == null) {
      return null;
    }
    return getMixerControlCurrentSettingsFromValue(value)?.speed;
  }

  int? getStandMixerCurrentTimerSet(Map<String, String>? cache) {
    final value = cache?[ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS];
    return getStandMixerCurrentSetSpeedFromValue(value);
  }

  int? getStandMixerCurrentTimerSetFromValue(String? value) {
    geaLog.debug("$tag getStandMixerCurrentTimerSetFromValue: $value");
    if (value == null) {
      return null;
    }
    return getMixerControlCurrentSettingsFromValue(value)?.timer;
  }

  String? getStandMixerCurrentDirection(Map<String, String>? cache) {
    final value = cache?[ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS];
    return getStandMixerCurrentDirectionFromValue(value);
  }

  String? getStandMixerCurrentDirectionFromValue(String? value) {
    geaLog.debug("$tag getStandMixerCurrentDirectionFromValue: $value");
    if (value == null) {
      return MixerDirection.notApplicable;
    }
    return getMixerControlCurrentSettingsFromValue(value)?.direction;
  }

  ApplianceAvailableModifications getAvailableModifications(Map<String, String>? cache) {
    if(cache != null && cache[ERD.STAND_MIXER_CYCLE_SETTING_MODIFICATION_AVAILABILITY] != null) {
      final value = cache[ERD.STAND_MIXER_CYCLE_SETTING_MODIFICATION_AVAILABILITY];
      ERD0x9309? erd = ERD0x9309(value!);
      geaLog.debug("$tag getAvailableModifications: ${erd.modifications.toString()}");
      return erd.modifications;
     } else {
      return ApplianceAvailableModifications(direction: false, speed: false, timer: false, torque: false);
    }
  }

  StandMixerSettingsModel? getMixerControlCurrentSettings(Map<String, String>? cache) {
    final value = cache?[ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS];
    return getMixerControlCurrentSettingsFromValue(value);
  }

  StandMixerSettingsModel? getMixerControlCurrentSettingsFromValue(String? value) {
    geaLog.debug("$tag getStandMixerCurrentDirectionFromValue: $value");
    if (value == null) {
      return null;
    }

    final converted = _erdService.getMixerControlCurrentSettings(value);
    final direction = converted.getDirection();
    return StandMixerSettingsModel(speed: converted.speed,
        timer: converted.timerSetValue,
        direction: _directionToReadableString(direction));
  }

  ErdLimitsModel? getControlSettingsSpeedLimits(Map<String, String>? cache) {
    final value = cache?[ERD.STAND_MIXER_CONTROL_SETTINGS_LIMITS];
    return getControlSettingsSpeedLimitsFromValue(value);
  }

  ErdLimitsModel? getControlSettingsSpeedLimitsFromValue(String? value) {
    geaLog.debug("$tag getControlSettingsSpeedLimitsFromValue: $value");
    final limits = getMixerControlSettingsLimits(value);
    if (limits == null) {
      return null;
    }

    return ErdLimitsModel(
        min: limits.minSpeed,
        max: limits.maxSpeed);
  }

  ErdLimitsModel? getControlSettingsTimerSetValueWithoutCache() {
    final cache = _applianceServiceRepository.getCache(_currentApplianceId);
    final formattedCache = _applianceServiceRepository.formatCache(cache);
    final value = formattedCache[ERD.STAND_MIXER_CONTROL_SETTINGS_LIMITS];

    if (value == null) {
      return null;
    }

    final settingsLimits = _erdService.getMixerControlSettingsLimits(value);
    return ErdLimitsModel(
        min: settingsLimits.minTimerSetValue,
        max: settingsLimits.maxTimerSetValue);
  }

  ERD0x9303? getMixerControlSettingsLimits(String? value) {
    geaLog.debug("$tag getMixerControlSettingsLimits: $value");
    if (value == null) {
      return null;
    }

    return _erdService.getMixerControlSettingsLimits(value);
  }

  String getMixerCycleState(Map<String, String>? cache) {
    final value = cache?[ERD.STAND_MIXER_STATE];

    return getMixerCycleStateFromValue(value);
  }

  String getMixerCycleStateFromValue(String? value) {
    geaLog.debug("$tag getMixerCycleStateFromValue: $value");
    if (value == null) {
      return CycleState.idle;
    }

    return _stateToReadableString(_erdService.getMixerCycleState(value));
  }

  String _directionToReadableString(Direction type) {
    switch (type) {
      case Direction.TOGGLE:
        return MixerDirection.toggle;
      case Direction.REVERSE:
        return MixerDirection.reverse;
      case Direction.FORWARD:
        return MixerDirection.forward;
      case Direction.NOT_APPLICABLE:
      default:
        return MixerDirection.notApplicable;
    }
  }

  String _stateToReadableString(MixerState state) {
    switch (state) {
      case MixerState.MIXER_IDLE:
        return CycleState.idle;
      case MixerState.MIXER_MIXING:
        return CycleState.mixing;
      case MixerState.MIXER_PAUSED:
        return CycleState.paused;
      default:
        return CycleState.idle;
    }
  }

  bool canChangeSendToMixer(StandMixerContentModel model, String? mixSpeedVal) {
    final timerSecRemaining = model.timerSecRemaining;
    final direction = model.directionValue;
    if (mixSpeedVal == null ||
        timerSecRemaining == null ||
        direction == null) {
      geaLog.debug("$tag canChangeSendToMixer: false - $mixSpeedVal, $timerSecRemaining, $direction");
      return false;
    }

    geaLog.debug("$tag canChangeSendToMixer - $mixSpeedVal, $timerSecRemaining, $direction");
    final isPaused = model.isPaused ?? StandMixerStateDefaultValue.isPaused;
    final isTimerChanged = didChangeTimer(timerSecRemaining);
    final isDirectionChanged = didChangeDirection(direction);
    final isSpeedChanged = didChangeSpeed(mixSpeedVal);

    if (isPaused) {
      if (isTimerChanged || isDirectionChanged || isSpeedChanged) {
        return true;
      }
    }
    return false;
  }

  int getSecondsRemaining(){
    final cache = _applianceServiceRepository.getCache(_currentApplianceId);
    final formattedCache = _applianceServiceRepository.formatCache(cache);
    final cachedData = getCookTimeSetSeconds(formattedCache);
    return int.parse(cachedData ?? "0");
  }

  bool didChangeTimer(int timerSecRemaining) {
    final cache = _applianceServiceRepository.getCache(_currentApplianceId);
    final formattedCache = _applianceServiceRepository.formatCache(cache);
    final cachedData = getCookTimeSetSeconds(formattedCache);
    geaLog.debug("$tag didChangeTimer: CACHED DATA: $cachedData, TIMER SEC REMAING: $timerSecRemaining");
    
    return timerSecRemaining.toString() != cachedData;
  }

  bool didChangeSpeed(String speed) {
    final cache = _applianceServiceRepository.getCache(_currentApplianceId);
    final formattedCache = _applianceServiceRepository.formatCache(cache);
    final cachedData = getStandMixerCurrentSetSpeed(formattedCache);

    return speed != cachedData.toString();
  }

  bool didChangeDirection(int direction) {
    final cache = _applianceServiceRepository.getCache(_currentApplianceId);
    final formattedCache = _applianceServiceRepository.formatCache(cache);
    final cachedData = getMixerControlCurrentSettings(formattedCache);

    var convertedDirection = 0;
    switch (cachedData?.direction) {
      case MixerDirection.forward:
        convertedDirection = 1;
        break;
      case MixerDirection.reverse:
        convertedDirection = 2;
        break;
      case MixerDirection.toggle:
        convertedDirection = 3;
        break;
      default:
        convertedDirection = 0;
        break;
    }

    geaLog.debug('$tag isDirectionChanged cached: $convertedDirection/desired: $direction');
    return direction != convertedDirection;
  }

  String? _getJidWithoutHomeId(String? jid) {
    final split = jid?.split("_");
    return split?[0];
  }

  Future<void> clearRecipeStatus() async {
    emit(state.copyWith(
      seedValue: _seedValue++,
      erdState: StandMixerErdState.loading
    ));
    String _jid = _nativeStorage.selectedAppliance ?? "";
     _erdStorage.setErdValue(_jid, ERD.RECIPE_STATUS, "0000000000000000000000000000000000000000000000");
    final cache = _applianceServiceRepository.getCache(_jid);
    var formattedCache = _applianceServiceRepository.formatCache(cache);
    //emit state
    emit(state.copyWith(
      seedValue: _seedValue++,
      erdState: StandMixerErdState.loaded,
      state: StandMixerState.contentResponse,
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


  void sendStartActiveStir(){
    _apiServiceRepository.requestMixerOscillate(_currentApplianceId.split("_")[0].toUpperCase(), 
    StandMixerOscillateRequest(
      kind: "appliance#control",
      userId: _currentApplianceId.split("_")[1],
      applianceId: _currentApplianceId.split("_")[0].toUpperCase(),
      ackTimeout: 20,
      command: "mixer-oscillate",
      data: [],
      commandLoop: 5,
    ));
    saveActiveStirEnabledToLocalStorage(true);
  }

  void saveActiveStirEnabledToLocalStorage(bool value){
    _sharedDataManager.setBooleanValue(SharedDataKey.standMixerActiveStirEnabled, value);    
  }

  Future<bool> getActiveStirEnabledFromLocalStorage() async {
    bool? value = await _sharedDataManager.getBooleanValue(SharedDataKey.standMixerActiveStirEnabled);
    return value ?? false;
  }

  void saveTimeStampToLocalStorage(String value){
    _sharedDataManager.setStringValue(SharedDataKey.standMixerActiveStirTimestamp, value);    
  }

  Future<String> getTimeStampFromLocalStorage() async {
    String? value = await _sharedDataManager.getStringValue(SharedDataKey.standMixerActiveStirTimestamp);
    return value ?? "";
  }

  Future<void> isActiveStirEnabled(String newTimestamp) async {
    bool isActiveStirFlagEnabled = await getActiveStirEnabledFromLocalStorage();
    geaLog.debug("isActiveStirEnabled: $isActiveStirFlagEnabled");
    if(!isActiveStirFlagEnabled){
      return;
    }
    String? savedTimeStamp = await _sharedDataManager.getStringValue(SharedDataKey.standMixerActiveStirTimestamp);
    geaLog.debug("savedTimeStamp: $savedTimeStamp");
    geaLog.debug("newTimestamp: $newTimestamp");
    if(savedTimeStamp == newTimestamp){
      // if the timestamp is the same, and it has been less then 15 minutes since the timestamps then the active stir is enabled
      // Format of savedTimeStamp & newTimestamp: 2023-03-17T18:01:00.977Z
      // Format of DateTime.now().toIso8601String(): 2021-03-17T18:01:00.977
      DateTime savedTimeStampDateTime = DateTime.parse(savedTimeStamp ?? "");
      DateTime dateTimeNowTimeStamp = DateTime.parse(DateTime.now().toIso8601String());
      Duration difference = dateTimeNowTimeStamp.difference(savedTimeStampDateTime);
      geaLog.debug("difference: $difference");
      if(difference.inMinutes < 15){
        emit(state.copyWith(
          seedValue: _seedValue++,
          contentModel: state.contentModel?.copyWith(
            isActiveStirEnabled: true
          )
        ));
        _isActiveStirActivated = true;
      } else {
        emit(state.copyWith(
          seedValue: _seedValue++,
        contentModel: state.contentModel?.copyWith(
            isActiveStirEnabled: false
          )));
        _isActiveStirActivated = false;
      }
    } else if(savedTimeStamp != null && savedTimeStamp.contains("AA:")){
        geaLog.debug("savedTimeStamp contains AA:");
        //compare the difference between the saved timestamp and the current datetime.now to see if it is less then 15 minutes
        // if it is less then 15 minutes then the active stir is enabled
        // Format of savedTimeStamp: AA:2023-03-17T18:01:00.977Z
        DateTime savedTimeStampDateTime = DateTime.parse(savedTimeStamp.substring(3));
        DateTime dateTimeNowTimeStamp = DateTime.parse(DateTime.now().toIso8601String());
        Duration difference = dateTimeNowTimeStamp.difference(savedTimeStampDateTime);
        geaLog.debug("difference: $difference");
        if(difference.inMinutes < 15){
          emit(state.copyWith(
            seedValue: _seedValue++,
            contentModel: state.contentModel?.copyWith(
              isActiveStirEnabled: true
            )
          ));
          _isActiveStirActivated = true;
        } else {
          emit(state.copyWith(
            seedValue: _seedValue++,
            contentModel: state.contentModel?.copyWith(
              isActiveStirEnabled: false
            )
          ));
          _isActiveStirActivated = false;
        }
      
      } else {
      emit(state.copyWith(
        seedValue: _seedValue++,
        contentModel: state.contentModel?.copyWith(
          isActiveStirEnabled: false
        )
      ));
      _isActiveStirActivated = false;
    }
  }

  @override
  Future<void> close() {
    _applianceServiceRepository.removeObserver(this);
    return super.close();
  }
  
  bool getIsRunning(String jid){
    final cache = _applianceServiceRepository.getCache(jid);
    var formattedCache = _applianceServiceRepository.formatCache(cache);
    final _contentModel = _getContentModel(formattedCache);
    return _contentModel?.isRunning ?? false;
  }

  String get applianceID => _currentApplianceId;

  void cancelMix(){
    emit(state.copyWith());
    postErd(ERD.TOASTER_OVEN_CANCEL_OPERATION, "01");
  }

  void setPresence(DevicePresence presence){
    emit(state.copyWith(
      seedValue: _seedValue++,
      presence: presence
    ));
  }

  @override
  void pubSubPresence(WebSocketPubSubPresenceResponse response) {
    print("pubSubPresence response: ${response.toJson()}");
    if(response.deviceId == _currentApplianceId){
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
  void pubSubCommand() {
  }
  
  @override
  void pubSubDevice(WebSocketPubSubDeviceResponse response) {
  }
  
  @override
  void pubSubService(WebSocketPubSubServiceResponse response) {
  }
  
}
