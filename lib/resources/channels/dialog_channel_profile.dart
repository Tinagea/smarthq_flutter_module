
abstract class DialogChannelProfile {
  static const CHANNEL_NAME = "com.ge.smarthq.flutter.dialog";

  /// Called to check whether the flutter is running on native project.
  /// key - 'native'
  /// value - bool
  /// {'native':true}
  static const F2N_DIRECT_IS_RUNNING_ON_NATIVE = "f2n_direct_is_running_on_native";

  /// Called to notify that the flutter engine is ready to service.
  /// The native must use the flutter dialog after receiving this function.
  static const F2N_DIRECT_READY_TO_SERVICE = "f2n_direct_ready_to_service";

  /// Called to retrieve the user's country code
  /// key - 'countryCode'
  /// value - String
  static const F2N_DIRECT_REQUEST_USER_COUNTRY_CODE = "f2n_direct_request_user_country_code";

  /// Called to get the language preference info
  /// key - 'languagePreference'
  /// value - String
  /// - example
  /// {'languagePreference':'en'}
  static const F2N_DIRECT_GET_LANGUAGE_PREFERENCE = "f2n_direct_get_language_preference";

  /// Called to get the mobile device token info
  /// key - 'mdt'
  /// value - String
  static const F2N_DIRECT_GET_MDT = "f2n_direct_get_mdt";

  /// Called to get the ge token info
  /// key - 'geToken'
  /// value - String
  static const F2N_DIRECT_GET_GE_TOKEN = "f2n_direct_get_ge_token";

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

  /// Called to show the flutter dialog.
  /// This function must be called before using the view controller or the fragment in the native.
  /// key - 'dialogName'       * dialog name to show.
  /// value - String
  /// key - 'dialogParameter'  * Parameter in the form of Map<String:dynamic> to be delivered when showing the dialog.
  /// value - DialogParameter  * DialogParameter consists of DialogParameterKind and DialogParameterBody.
  ///                             If there is parameter to be delivered, create new DialogParameterKind and
  ///                             define the corresponding DialogParameterBodyXXXX.
  ///                             DialogParameterBodyXXXX must inherit from DialogParameterBody.
  /// {
  ///   "dialogName":"pushNotification",
  ///   "dialogParameter": DialogParameter
  /// }
  static const N2F_DIRECT_SHOW_DIALOG = "n2f_direct_show_dialog";

  /// Called to close the flutter dialog.
  /// There is no need the parameter.
  static const N2F_DIRECT_CLOSE_DIALOG = "n2f_direct_close_dialog";
}

enum DialogChannelListenType {
  showDialog,
  closeDialog
}
