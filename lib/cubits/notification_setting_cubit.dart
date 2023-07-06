
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/models/common/notification/notification_setting_model.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_setting_item.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class NotificationSettingCubit extends Cubit<NotificationSettingState>{

  late NativeRepository _nativeRepository;
  late ApiServiceRepository _apiServiceRepository;
  late int _seedValue;
  String? _deviceId;
  static const String _ruleId = "1c7ff92e-762d-4ef0-856a-0971156c4a6e";

  NotificationSettingCubit(
      this._nativeRepository,
      this._apiServiceRepository)
      :super(NotificationSettingState(seedValue: -1)) {
    geaLog.debug("NotificationSettingCubit is called");
    _seedValue = 0;
  }

  void getNotificationInfo() async {

    emit(state.copyWith(
        seedValue: _seedValue++,
        loadingStatus: LoadingStatus.loading
    ));

    List<NotificationSettingItem>? notificationSettingList;
    final applianceId = await _nativeRepository.getSelectedApplianceId();
    if (applianceId != null) {
      final deviceId = await _apiServiceRepository.getDeviceIdByUpdId(applianceId);
      if (deviceId != null) {
        _deviceId = deviceId;
        notificationSettingList = await _apiServiceRepository.getNotificationSettingInfo(deviceId);

        bool _isAutofillFeatureEnabled = BuildEnvironment.hasFeature(featureType: EnvFeatureType.autofill);

        if(_isAutofillFeatureEnabled){
          notificationSettingList.removeWhere((element) =>
            element.ruleId == _ruleId);
        }
      }
    }

    emit(state.copyWith(
        seedValue: _seedValue++,
        notificationSettingList: notificationSettingList,
        loadingStatus: LoadingStatus.updated
    ));
  }

  Future<bool> postNotificationRule(int index) async {
    var ruleEnable = false;
    final ruleId = state.notificationSettingList?[index].ruleId;
    final ruleEnabled = state.notificationSettingList?[index].ruleEnabled;
    if (_deviceId != null && ruleId != null && ruleEnabled != null) {
      ruleEnable = await _apiServiceRepository
          .postNotificationRule(_deviceId!, ruleId, !ruleEnabled);
    }

    final updatedItem = state.notificationSettingList?[index]
        .copyWith(ruleEnabled: ruleEnable);
    if (updatedItem != null) {
      state.notificationSettingList?[index] = updatedItem;
    }

    emit(state.copyWith(
        seedValue: _seedValue++,
        loadingStatus: LoadingStatus.updated
    ));

    return ruleEnable;
  }

}