import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';

class ApplianceCubit extends Cubit<ApplianceState> {

  late ApiServiceRepository _apiServiceRepository;
  late NativeRepository _nativeRepository;
  late LocalDataManager _localDataManager;
  
  // late int _seedValue;

  ApplianceCubit(
      this._localDataManager,
      this._apiServiceRepository,
      this._nativeRepository,) :
        super(ApplianceState(seedValue: -1));

  void actionRequestValidateModelNumber(String? modelNumber) async {
    final isModelNumberValid = await _apiServiceRepository.requestModelValidation(modelNumber);

    if(!isModelNumberValid) {
      _nativeRepository.moveToModelNumberValidationScreen();
    }
  }
  
  Future<void> setCurrentAppliance() async {
    //first, get the device list
    DeviceListResponse? deviceList = await _apiServiceRepository.getDeviceList();
    String? jid = await _nativeRepository.getSelectedApplianceId();
    DevicePresence? appliancePresence;
    getNativeStorage().setSelectedAppliance = jid;
    ApplianceType applianceType = ApplianceType.UNDEFINED;
    deviceList.devices!.forEach((element) {
      if(element.updId == null) return;
      if (element.updId?.toUpperCase() == jid!.split('_')[0].toUpperCase()) {
        switch (element.deviceType!.split('.').last) {
          case "toasteroven":
            applianceType = ApplianceType.TOASTER_OVEN;
            appliancePresence = element.presence;
            break;
          case "standmixer":
            applianceType = ApplianceType.STAND_MIXER;
            appliancePresence = element.presence;
            break;
          default:
            applianceType = ApplianceType.UNDEFINED;
            appliancePresence = DevicePresence.offline;
        }
      }
      emit(state.copyWith(
        applianceType: applianceType,
        appliancePresence: appliancePresence,
        ));
    });
  }

  String getApplianceTypeForRequest(){
    ApplianceType? applianceType = state.applianceType;
    String applianceString = "";
    switch(applianceType) {
      case ApplianceType.STAND_MIXER:
        applianceString = "Stand Mixer";
        break;
      case ApplianceType.TOASTER_OVEN:
        applianceString = "Toaster Oven";
        break;
      default:
        applianceString = "UNDEFINED";
        break;
    }
    return applianceString;
  }
  
  void clearApplianceType(){
    emit(state.copyWith(applianceType: null));
  }
  
  Future<String?> getJid() async {
    String? jid = await _nativeRepository.getSelectedApplianceId();
    return jid;
  }
  
  NativeStorage getNativeStorage() {
    final nativeStorage = _localDataManager.getStorage(StorageType.native) as NativeStorage;
    return nativeStorage;
  }

  DevicePresence getDevicePresenceFromState()  {
    return state.appliancePresence ?? DevicePresence.offline;
  }

  Future<DevicePresence> getDevicePresence()  async {
    await setCurrentAppliance();
    return state.appliancePresence ?? DevicePresence.offline;
  }
  
}