

import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class PushNotificationManager {
  static final PushNotificationManager _instance = PushNotificationManager._();
  factory PushNotificationManager() {
    return _instance;
  }
  PushNotificationManager._();

  late ApiServiceRepository _apiServiceRepository;
  late SharedDataManager _sharedPreferenceManager;
  void initialize(
      ApiServiceRepository apiServiceRepository,
      SharedDataManager sharedPreferenceManager) {
    _apiServiceRepository = apiServiceRepository;
    _sharedPreferenceManager = sharedPreferenceManager;
  }

  Future<bool> sendPushToken(String pushToken, bool isLogin) async {
    var isSuccess = false;

    final tokenReceipt = await _sharedPreferenceManager.getStringValue(SharedDataKey.tokenReceipt);
    if (isLogin) {
      isSuccess = await _mustSendPushToken(pushToken, tokenReceipt);
    }
    else {
      if (tokenReceipt == null) {
        isSuccess = await _mustSendPushToken(pushToken, null);
      }
      else {
        isSuccess = await _sendPushToken(pushToken, tokenReceipt);
      }
    }

    return isSuccess;
  }

  Future<bool> _mustSendPushToken(String pushToken, String? tokenReceipt) async {
    geaLog.debug("PushNotificationManager: Register and Associate Tokens");
    var isSuccess = false;

    final receivedTokenReceipt = await _apiServiceRepository.registerToken(pushToken, tokenReceipt);
    if (receivedTokenReceipt != null) {
      await _sharedPreferenceManager.setStringValue(SharedDataKey.pushToken, pushToken);

      isSuccess = await _apiServiceRepository.associateToken(receivedTokenReceipt);
      if (isSuccess)
        await _sharedPreferenceManager.setStringValue(SharedDataKey.tokenReceipt, receivedTokenReceipt);
    }

    return isSuccess;
  }

  Future<bool> _sendPushToken(String pushToken, String tokenReceipt) async {
    var isSuccess = false;

    if (await _shouldRegisterToken(pushToken)) {
      geaLog.debug("PushNotificationManager: Register PushToken");
      final receivedTokenReceipt = await _apiServiceRepository.registerToken(pushToken, tokenReceipt);
      if (receivedTokenReceipt != null) {
        await _sharedPreferenceManager.setStringValue(SharedDataKey.pushToken, pushToken);

        if (await _shouldAssociateToken(receivedTokenReceipt)) {
          geaLog.debug("PushNotificationManager: Associate TokenReceipt");
          isSuccess = await _apiServiceRepository.associateToken(receivedTokenReceipt);
          if (isSuccess) {
            await _sharedPreferenceManager.setStringValue(SharedDataKey.tokenReceipt, receivedTokenReceipt);
          }
        }
      }
    }
    else {
      geaLog.debug("PushNotificationManager: Do not Register and Associate Tokens");
    }

    return isSuccess;
  }

  Future<bool> _shouldRegisterToken(String newPushToken) async {
    bool shouldRegister = true;
    final savedPushToken = await _sharedPreferenceManager.getStringValue(SharedDataKey.pushToken);
    if (savedPushToken != null) {
      if (savedPushToken.compareTo(newPushToken) == 0) {
        shouldRegister = false;
      }
    }
    return shouldRegister;
  }

  Future<bool> _shouldAssociateToken(String newTokenReceipt) async {
    bool shouldAssociate = true;
    final savedTokenReceipt = await _sharedPreferenceManager.getStringValue(SharedDataKey.tokenReceipt);
    if (savedTokenReceipt != null) {
      if (savedTokenReceipt.compareTo(newTokenReceipt) == 0) {
        shouldAssociate = false;
      }
    }
    return shouldAssociate;
  }
}