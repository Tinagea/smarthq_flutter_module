
abstract class BleCommissioningChannelProfile {
  static const CHANNEL_NAME = "com.ge.smarthq.flutter.ble.commissioning";

  static const ACTION_DIRECT_BLE_GET_SEARCHED_BEACON_LIST = "action_direct_ble_get_searched_beacon_list"; // [applianceType: [String]] and null

  static const ACTION_BLE_MOVE_TO_WELCOME_PAGE = "action_ble_move_to_welcome_page"; // applianceType: String, subType: String, isBleMode: Bool

  static const ACTION_BLE_START_IBEACON_SCANNING = "action_ble_start_ibeacon_scanning"; // durationSecTime: int
  static const LISTEN_BLE_IBEACON_SCANNING_RESULT = "listen_ble_ibeacon_scanning_result"; // [applianceType: String] and null

  static const ACTION_BLE_START_ALL_SCANNING = "action_ble_start_all_scanning"; // durationSecTime: int
  static const ACTION_BLE_START_ADVERTISEMENT_SCANNING = "action_ble_start_advertisement_scanning"; // durationSecTime: int

  static const LISTEN_BLE_DETECTED_SCANNING = "listen_ble_detected_scanning"; // [scanType: String(ibeacon,advertisement), advertisementIndex: int, applianceType: String]
  static const LISTEN_BLE_FINISHED_SCANNING = "listen_ble_finished_scanning";
  static const ACTION_BLE_STOP_SCANNING = "action_ble_stop_scanning";

  static const ACTION_BLE_START_PAIRING_ACTION1 = "action_ble_start_pairing_action1"; // applianceType: String
  static const LISTEN_BLE_START_PAIRING_ACTION1_RESULT = "listen_ble_start_pairing_action1_result"; // applianceType: String, isSuccess: bool

  static const ACTION_BLE_REQUEST_NETWORK_LIST = "action_ble_request_network_list";
  static const LISTEN_BLE_NETWORK_LIST = "listen_ble_network_list"; // ssid: String, securityType: String

  static const ACTION_BLE_SAVE_SELECTED_NETWORK_INDEX = "action_ble_save_selected_network_index"; // index: int
  static const ACTION_BLE_SAVE_SELECTED_NETWORK_INFORMATION = "action_ble_save_selected_network_information"; // ssid: String, securityType: String, password: String
  static const ACTION_BLE_START_COMMISSIONING = "action_ble_start_commissioning";
  static const ACTION_BLE_START_COMMISSIONING_ONLY_MODULE = "action_ble_start_commissioning_only_module";
  static const ACTION_DIRECT_BLE_GET_UPD_ID = "action_direct_ble_get_upd_id"; // updId: String
  static const LISTEN_BLE_PROGRESS_STEP = "listen_ble_progress_step"; // step: int, isSuccess: bool

  static const ACTION_BLE_START_PAIRING_ACTION2 = "action_ble_start_pairing_action2"; // applianceType: String
  static const LISTEN_BLE_START_PAIRING_ACTION2_RESULT = "listen_ble_start_pairing_action2_result"; // isSuccess: bool

  static const ACTION_BLE_START_PAIRING_ACTION3 = "action_ble_start_pairing_action3"; // applianceType: String, advertisementIndex: int
  static const LISTEN_BLE_START_PAIRING_ACTION3_RESULT = "listen_ble_start_pairing_action3_result"; // applianceType: String, isSuccess: bool

  static const LISTEN_BLE_NETWORK_JOIN_STATUS_FAIL = "listen_ble_network_join_status_fail";

  static const LISTEN_BLE_NETWORK_STATUS_DISCONNECT = "listen_ble_network_status_disconnect";

  static const ACTION_DIRECT_BLE_DEVICE_STATE = "action_direct_ble_device_state"; // state: String (on, off)
  static const LISTEN_BLE_DEVICE_STATE = "listen_ble_device_state"; // state: String (on, off)

  static const ACTION_BLE_GO_TO_SETTING = "action_ble_go_to_setting";

  static const ACTION_BLE_RETRY_PAIRING = "action_ble_retry_pairing";
  static const LISTEN_BLE_RETRY_PAIRING_RESULT = "listen_ble_retry_pairing_result"; // isSuccess: bool

  static const LISTEN_BLE_MOVE_TO_ROOT_COMMISSIONING_PAGE = "listen_ble_move_to_root_commissioning_page";

  static const LISTEN_BLE_FAIL_TO_CONNECT = "listen_ble_fail_to_connect";

  static const ACTION_DIRECT_BLE_GET_INFO_TO_PAIR_SENSOR = "action_direct_ble_get_info_to_pair_sensor"; // deviceId: String, gatewayId: String
}

enum BleCommissioningChannelListenType {
  BLE_IBEACON_SCANNING_RESULT,
  BLE_DETECTED_SCANNING,
  BLE_FINISHED_SCANNING,
  BLE_START_PAIRING_ACTION1_RESULT,
  BLE_START_PAIRING_ACTION2_RESULT,
  BLE_START_PAIRING_ACTION3_RESULT,
  BLE_NETWORK_LIST,
  BLE_PROGRESS_STEP,
  BLE_NETWORK_JOIN_STATUS_FAIL,
  BLE_NETWORK_STATUS_DISCONNECT,
  BLE_DEVICE_STATE,
  BLE_RETRY_PAIRING_RESULT,
  BLE_MOVE_TO_ROOT_COMMISSIONING_PAGE,
  BLE_FAIL_TO_CONNECT,
  BLE_MOVE_TO_PAIR_SENSOR
}

abstract class BleCommissioningSecurityType {
  static const OPEN = 'Open';
  static const WEP = 'Wep';
  static const WEP_SHARED = 'WepShared';
  static const WPA = 'Wpa';
  static const WPA2 = 'Wpa2';
  static const WPA_WPA2_MIXED = 'WpaWpa2Mixed';
  static const WPA3 = 'Wpa3';
  static const WPA2_WPA3_MIXED = 'Wpa2Wpa3Mixed';
  static const UNKNOWN = 'Unknown';
  static const DISABLE = 'Disabled';

  static const Map<String, String> TYPE_MAP = {
    BleCommissioningSecurityTypeName.OPEN: OPEN,
    BleCommissioningSecurityTypeName.WEP: WEP,
    BleCommissioningSecurityTypeName.WEP_SHARED: WEP_SHARED,
    BleCommissioningSecurityTypeName.WPA: WPA,
    BleCommissioningSecurityTypeName.WPA2: WPA2,
    BleCommissioningSecurityTypeName.WPA_WPA2_MIXED: WPA_WPA2_MIXED,
    BleCommissioningSecurityTypeName.WPA3: WPA3,
    BleCommissioningSecurityTypeName.WPA2_WPA3_MIXED: WPA2_WPA3_MIXED,
  };
}

abstract class BleCommissioningSecurityTypeName {

  static const SecurityTypeList = [OPEN, WEP, WEP_SHARED, WPA, WPA2, WPA_WPA2_MIXED, WPA3, WPA2_WPA3_MIXED];
  static const String OPEN = 'OPEN';
  static const String WEP = 'WEP';
  static const String WEP_SHARED = 'WEP (SHARED)';
  static const String WPA = 'WPA';
  static const String WPA2 = 'WPA2';
  static const String WPA_WPA2_MIXED = 'WPA/WPA2 (Mixed)';
  static const String WPA3 = 'WPA3';
  static const String WPA2_WPA3_MIXED = 'WPA2/WPA3 (Mixed)';
}

abstract class BleCommissioningEncryptType {
  static const String AUTO = 'Auto';
  static const String TKIP = 'TKIP';
  static const String CCMP = 'CCMP';
  static const String WEP = 'WEP';
  static const String MIXED = 'Mixed';
  static const String NONE = 'None';
  static const String UNDEFINED = 'Undefined';
}