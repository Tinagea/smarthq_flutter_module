
abstract class NativeChannelProfile {
  static const CHANNEL_NAME = "com.ge.smarthq.flutter.native";

  /// Called for checking whether the flutter module is running on native project.
  /// key - 'native'
  /// value - bool
  /// {'native':true}
  static const F2N_DIRECT_IS_RUNNING_ON_NATIVE = "f2n_direct_is_running_on_native";

  /// Called for notifying that the flutter module is ready to service.
  /// The native must use the flutter module after receiving this function.
  static const F2N_DIRECT_READY_TO_SERVICE = "f2n_direct_ready_to_service";

  /// Called for navigating from Flutter View to Flutter View is required.
  /// key - 'routingName'       * screen(configured with Flutter View) name to move.
  /// value - String
  /// key - 'routingParameter'  * Parameter in the form of Map<String:dynamic> to be delivered when moving the screen.
  /// value - RoutingParameter  * RoutingParameter consists of RoutingParameterKind and RoutingParameterBody.
  ///                             If there is parameter to be delivered, create new RoutingParameterKind and
  ///                             define the corresponding RoutingParameterBodyXXXX.
  ///                             RoutingParameterBodyXXXX must inherit from RoutingParameterBody.
  /// {
  ///   "routingName":"centralControllerScreen",
  ///   "routingParameter": RoutingParameter
  /// }
  static const F2N_DIRECT_MOVE_TO_FLUTTER_VIEW_SCREEN = "f2n_direct_move_to_flutter_view_screen";

  /// Called for getting the mobile device token info
  /// key - 'mdt'
  /// value - String
  static const F2N_DIRECT_GET_MDT = "f2n_direct_get_mdt";

  /// Called for getting the ge token info
  /// key - 'geToken'
  /// value - String
  static const F2N_DIRECT_GET_GE_TOKEN = "f2n_direct_get_ge_token";

  /// Called for getting the push token info
  /// key - 'pushToken'
  /// value - String
  /// - example
  /// {'pushToken':'a1ce84afebecc7932b2efbf20afb911f972f76527b1e74afab445e59413a5d09'}
  static const F2N_DIRECT_GET_PUSH_TOKEN = "f2n_direct_get_push_token";

  /// Called for getting the language preference info
  /// key - 'languagePreference'
  /// value - String
  /// - example
  /// {'languagePreference':'en'}
  static const F2N_DIRECT_GET_LANGUAGE_PREFERENCE = "f2n_direct_get_language_preference";

  /// Called for getting the selected appliance id info
  /// key - 'selectedApplianceId'
  /// value - String
  /// - example
  /// {'selectedApplianceId':'D828C98B70B1'}
  static const F2N_DIRECT_GET_SELECTED_APPLIANCE_ID = "f2n_direct_get_selected_appliance_id";

  /// Called for starting the services in Flutter Module
  /// This function will be called when the native is ready to service (etc, after sign in)
  static const N2F_DIRECT_START_SERVICE = "n2f_direct_start_service";

  /// Called for registering the push token to GE Cloud
  /// key - 'pushToken'
  /// value - String
  /// key - 'login' (It should be set to true immediately after a new login. Otherwise, set it to false)
  /// value - bool
  /// - example
  /// {'pushToken':'a1ce84afebecc7932b2efbf20afb911f972f76527b1e74afab445e59413a5d09',
  ///  'login': false}
  static const N2F_DIRECT_POST_PUSH_TOKEN = "n2f_direct_post_push_token";

  /// Called for routing the flutter screen.
  /// This function must be called before using the view controller or the fragment in the native.
  /// key - 'routingName'       * screen(configured with Flutter View) name to move.
  /// value - String
  /// key - 'routingParameter'  * Parameter in the form of Map<String:dynamic> to be delivered when moving the screen.
  /// value - RoutingParameter  * RoutingParameter consists of RoutingParameterKind and RoutingParameterBody.
  ///                             If there is parameter to be delivered, create new RoutingParameterKind and
  ///                             define the corresponding RoutingParameterBodyXXXX.
  ///                             RoutingParameterBodyXXXX must inherit from RoutingParameterBody.
  /// {
  ///   "routingName":"centralControllerScreen",
  ///   "routingParameter": RoutingParameter
  /// }
  static const N2F_DIRECT_ROUTE_TO_SCREEN = "n2f_direct_route_to_screen";

  static const F2N_DIRECT_INVALID_MODEL_NUMBER = "f2n_direct_invalid_model_number";
  /// Called to retrieve the brand type user has selected
  /// key - 'brandType'
  /// value - String
  static const F2N_DIRECT_REQUEST_SELECTED_BRAND_TYPE = "f2n_direct_request_selected_brand_type";

  /// Called to retrieve the user's country code
  /// key - 'countryCode'
  /// value - String
  static const F2N_DIRECT_REQUEST_USER_COUNTRY_CODE = "f2n_direct_request_user_country_code";

  /// Called to request show and hide header and tab bar
  /// Only for Stand mixer
  static const F2N_DIRECT_SHOW_HEADER = "f2n_direct_show_header";
  static const F2N_DIRECT_SHOW_TAB_BAR = "f2n_direct_show_tab_Bar";

  /// Called for navigating to the Native Offline Self Help screen
  static const F2N_DIRECT_APPLIANCE_OFFLINE = "f2n_direct_appliance_offline";

  /// TODO: Create channel to call the sign out action from native
  static const N2F_DIRECT_SIGNED_OUT = "n2f_direct_signed_out";
}

enum NativeChannelListenType {
  startService,
  postPushToken,
  routeToScreen
}
