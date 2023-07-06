
abstract class APIServiceChannelProfile {
  static const CHANNEL_NAME = "com.ge.smarthq.flutter.api.service";

  /// STRUCTURE OF THE API SERVICE CHANNEL COMMON RESPONSE
  ///
  /// All responses consist of:
  /// APIServiceResult
  /// {
  ///   kind: ""                    - Request type info, the contents of the body is changed depending on [kind].
  ///   success: bool               - True or false, When false, the reason is returned through [reason]. When true, [reason] will be null.
  ///   reason: String?             - The reason for failure.
  ///   body: APIServiceResultBody  - Response data to the request.
  /// }
  ///
  /// APIServiceResultBody          - Depending on the [kind], various fields may be added.
  /// {
  ///   status: String?
  ///   apiVersion: String?
  ///   ...
  /// }

  /// Called to get the ota status of device
  /// REQUEST:
  ///   key: 'deviceId'
  ///   value: String
  ///   - example
  ///   {'deviceId': 'fe0f41b381f3ce28a7c7a2dd99a7dc1a7942514bda8c0ee3610076b881abeae7'}
  /// RESPONSE: APIServiceResultBody
  ///   key:'status'
  ///   value: String
  ///     status has 3 values as below.
  ///     - 'idle' (idle status),
  ///     - 'available' (OTA available status)
  ///     - 'updating' (OTA in progress status)
  ///     {'status':'idle'}
  static const N2F_DIRECT_GET_DEVICE_OTA_STATUS = "n2f_direct_get_device_ota_status";

  /// Called to request starting the OTA
  /// REQUEST:
  ///   key: 'deviceId'
  ///   value: String
  ///   - example
  ///   {'deviceId': 'fe0f41b381f3ce28a7c7a2dd99a7dc1a7942514bda8c0ee3610076b881abeae7'}
  /// RESPONSE: APIServiceResultBody
  ///   key:'success'
  ///   value: bool
  ///     status has 2 values as below.
  ///     - true (success to request starting OTA)
  ///     - false (fail to request starting OTA)
  static const N2F_DIRECT_START_DEVICE_OTA = "n2f_direct_start_device_ota";

  /// Called to get the api version of the notification setting page.
  /// REQUEST:
  ///   key - 'applianceTypeDec'
  ///   value - String (Decimal value of the appliance type)
  ///   - example
  ///   {'applianceTypeDec': '12'}
  /// RESPONSE: APIServiceResultBody
  ///   key - 'apiVersion'
  ///   value - String (v1 or v2), if return v1, the app must work using v1 api in Native, if return v2, the app must work using v2 api in Flutter.
  ///   - example
  ///   {'apiVersion':'v1'}
  static const N2F_DIRECT_GET_NOTIFICATION_SETTING_API_VERSION = "n2f_direct_get_notification_setting_api_version";

  /// Called to get the support api version list for the push notification
  /// REQUEST:
  ///   no key and value
  /// RESPONSE: APIServiceResultBody
  ///   key - 'notificationVersionList'
  ///   value - APIServiceResultNotificationVersionItem List
  ///     [
  ///       APIServiceResultNotificationVersionItem,
  ///       APIServiceResultNotificationVersionItem
  ///     ]
  ///   APIServiceResultNotificationVersionItem
  ///     key - 'applianceTypeDec'
  ///     value - String, it is a Decimal value
  ///     key - 'apiVersion'
  ///     value - String (v1 or v2), if return v1, the app must work using v1 api in Native, if return v2, the app must work using v2 api in Flutter.
  ///     - example
  ///     {
  ///      'applianceTypeDec':'8',
  ///      'apiVersion':'v1'
  ///     }
  static const N2F_DIRECT_GET_NOTIFICATION_API_VERSION_LIST = "n2f_direct_get_notification_api_version_list";
}
