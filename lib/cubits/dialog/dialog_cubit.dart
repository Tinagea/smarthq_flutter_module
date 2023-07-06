
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/models/dialog/dialog_model.dart';
import 'package:smarthq_flutter_module/models/dialog/dialog_type.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter_body.dart';
import 'package:smarthq_flutter_module/resources/repositories/dialog_repository.dart';
import 'package:smarthq_flutter_module/resources/storage/dialog_storage.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class DialogCubit extends Cubit<DialogState> implements DialogChannelObserver {
  static const String tag = "DialogCubit:";

  late DialogRepository _dialogRepository;
  late LocalDataManager _localDataManager;
  late SharedDataManager _sharedDataManager;

  DialogCubit(
      this._dialogRepository,
      this._localDataManager,
      this._sharedDataManager)
      : super(DialogInitial()) {
    geaLog.debug("DialogCubit is called");
    _dialogRepository.addObserver(this);
  }

  @override
  Future<void> close() {
    _dialogRepository.removeObserver(this);
    return super.close();
  }

  void onReceivedItem(
      DialogChannelListenType type,
      ChannelDataItem? item) async {
    geaLog.debug("${tag}onReceivedItem: type($type)");

    switch (type) {
      case DialogChannelListenType.showDialog:
        if (item is DialogChannelDataItem) {
          final dialogType = item.dialogType!;
          final dialogParameter = item.dialogParameter;
          emit(DialogShow(
              dialogType: dialogType,
              dialogParameter: dialogParameter));
        }
        break;

      case DialogChannelListenType.closeDialog:
        emit(DialogClose());
        break;
    }
  }

  Future<void> getTokens() async {
    final mdt = await _dialogRepository.getMdt();
    final geToken = await _dialogRepository.getGeToken();
    geaLog.debug('${tag}getTokens() - mdt:$mdt, geToken:$geToken');

    await _sharedDataManager.setStringValue(SharedDataKey.mobileDeviceToken, mdt);
    await _sharedDataManager.setStringValue(SharedDataKey.geToken, geToken);
  }

  Future<String> getLanguagePreference() async {
    geaLog.debug('${tag}getLanguagePreference()');
    final language = await _dialogRepository.getLanguagePreference();
    final storage = _localDataManager.getStorage(StorageType.dialog) as DialogStorage;
    storage.setLanguageCode = language;
    return language;
  }

  /// Just for testing
  void testDialog() {
    for(var i = 0; i < 1; i++) {
      emit(
        DialogShow(
          dialogType: DialogType.pushNotification,
          dialogParameter: DialogParameter(
            kind: DialogParameterKind.pushNotification,
            body: DialogParameterBodyPushNotification(
              alertType: 'cloud.smarthq.alert.leakdetected',
              url: 'https://www.geappliances.com/',
              rawPayload: null,
              msg: "test-msg-$i",
              title: "SmartHQ-$i",
              deviceId: null,
              deviceType: 'cloud.smarthq.device.dishwasher',
            ),
          ),
        ),
      );
    }
  }
}