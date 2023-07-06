
abstract class CommissioningChannelProfile {
  static const CHANNEL_NAME = "com.ge.smarthq.flutter.commissioning";

  static const ACTION_REQUEST_APPLICATION_PROVISIONING_TOKEN = "action_request_application_provisioninig_token";
  static const LISTEN_APPLICATION_PROVISIONING_TOKEN_RESPONSE = "listen_application_provisioning_token_response"; // isSuccess: bool
  static const ACTION_SAVE_ACM_PASSWORD = "action_save_acm_password"; // acmpassword: String
  static const LISTEN_CONNECTED_GE_MODULE_WIFI = "listen_connected_ge_module_wifi"; // isSuccess: bool
  static const ACTION_REQUEST_COMMISSIONING_DATA = "action_request_commissioning_data";
  static const ACTION_REQUEST_GE_MODULE_REACHABILITY = "action_request_ge_module_reachability"; // isOn: bool
  static const LISTEN_COMMISSIONING_DATA_RESPONSE = "listen_commissioning_data_response"; // isSuccess: bool
  static const ACTION_GET_RECOMMEND_SSID = "action_get_recommend_ssid";
  static const LISTEN_RECOMMEND_SSID = "listen_recommend_ssid"; // ssid: String // if there is not, ""
  static const ACTION_REQUEST_NETWORK_LIST = "action_request_network_list";
  static const LISTEN_NETWORK_LIST = "listen_network_list"; // ssid: String, securityType: String
  static const ACTION_SAVE_SELECTED_NETWORK_INFORMATION = "action_save_selected_network_information"; // ssid: String, securityType: String, password: String
  static const ACTION_START_COMMISSIONING = "action_start_commissioning";
  static const LISTEN_PROGRESS_STEP = "listen_progress_step"; // step: int, isSuccess: bool
  static const ACTION_REQUEST_RELAUNCH = "action_request_relaunch";
  static const ACTION_MOVE_TO_NATIVE_BACK_PAGE = "action_move_to_native_back_page";
  static const ACTION_CHECK_CONNECTED_GE_MODULE_WIFI = "action_check_connected_ge_module_wifi";
  static const ACTION_COMMISSIONING_SUCCESSFUL = "action_commissioning_successful";
  static const ACTION_START_AUTO_JOIN = "action_start_auto_join";
  static const ACTION_CHECK_CONNECTED_GE_MODULE_WIFI_WITH_RESULT = "action_check_connected_ge_module_wifi_with_result";
  static const ACTION_REQUEST_COMMISSIONING_DATA_WITH_RESULT = "action_request_commissioning_data_with_result";
  static const ACTION_CHECK_CONNECTED_GE_MODULE_SSID = "action_check_connected_ge_module_ssid";

  // For Commissioning Enhancement - in case of the network password is wrong.
  static const LISTEN_NETWORK_JOIN_STATUS_FAIL = "listen_network_join_status_fail"; // It is only used in Android, iOS's scenario is different. the iOS should show popup instead of it.
  static const LISTEN_CHECK_MODULE_STATUS_FROM_USER = "listen_check_module_status_from_user"; // It is only used in iOS. the iOS should show popup.
  static const ACTION_CANCEL_COMMISSIONING = "action_cancel_commissioning"; // It is only used in iOS.
}

enum CommissioningChannelListenType {
  APPLICATION_PROVISIONING_TOKEN,
  CONNECTED_GE_MODULE_WIFI,
  COMMISSIONING_DATA_RESPONSE,
  RECOMMEND_SSID,
  NETWORK_LIST,
  PROGRESS_STEP,
  NETWORK_JOIN_STATUS_FAIL,
  CHECK_MODULE_STATUS_FROM_USER,
}

abstract class CommissioningSecurityType {
  static const NONE = 'None';
  static const DISABLE = 'Disabled';
  static const WEP = 'WEP';
  static const WPA_AES_PSK = 'WPA_AES_PSK';
  static const WPA_TKIP_PSK = 'WPA_TKIP_PSK';
  static const WPA2_AES_PSK = 'WPA2_AES_PSK';
  static const WPA2_TKIP_PSK = 'WPA2_TKIP_PSK';
  static const WPA2_MIXED_PSK = 'WPA2_MIXED_PSK';
  static const WPA_WPA2_MIXED = 'WPA_WPA2_MIXED';

  static const Map<String, String> TYPE_MAP = {
    CommissioningSecurityTypeName.NONE: NONE,
    CommissioningSecurityTypeName.WEP: WEP,
    CommissioningSecurityTypeName.WPA_AES_PSK: WPA_AES_PSK,
    CommissioningSecurityTypeName.WPA_TKIP_PSK: WPA_TKIP_PSK,
    CommissioningSecurityTypeName.WPA2_AES_PSK: WPA2_AES_PSK,
    CommissioningSecurityTypeName.WPA2_TKIP_PSK: WPA2_TKIP_PSK,
    CommissioningSecurityTypeName.WPA2_MIXED_PSK: WPA2_MIXED_PSK,
    CommissioningSecurityTypeName.WPA_WPA2_MIXED: WPA_WPA2_MIXED,
  };

  static bool isOpenNetwork(String? securityType) {
    if (securityType == null) return false;
    return (securityType.toUpperCase() == NONE.toUpperCase()
        || securityType.toUpperCase() == DISABLE.toUpperCase());
  }
}

abstract class CommissioningSecurityTypeName {

  static const SecurityTypeList = [NONE, WEP, WPA_AES_PSK, WPA_TKIP_PSK, WPA2_AES_PSK, WPA2_TKIP_PSK, WPA2_MIXED_PSK, WPA_WPA2_MIXED];
  static const String NONE = 'None';
  static const String WEP = 'WEP';
  static const String WPA_AES_PSK = 'WPA (AES)';
  static const String WPA_TKIP_PSK = 'WPA (TKIP)';
  static const String WPA2_AES_PSK = 'WPA2 (AES)';
  static const String WPA2_TKIP_PSK = 'WPA2 (TKIP)';
  static const String WPA2_MIXED_PSK = 'WPA2 (Mixed)';
  static const String WPA_WPA2_MIXED = 'WPA/WPA2 (Mixed)';
}