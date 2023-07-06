
abstract class ShortcutServiceChannelProfile {
  static const CHANNEL_NAME = "com.ge.smarthq.flutter.shortcut.service";

  /// Called to retrieve the oven type
  /// key - 'ovenType'
  /// value - String
  /// - example
  ///  {'ovenType': {'body': {'ovenType': 'singleOven'}, 'kind': 'ovenType'}});
  static const F2N_DIRECT_REQUEST_OVEN_TYPE = "f2n_direct_request_oven_type";

  /// Called for retrieve available oven mode items (For shortcut)
  /// key - 'ovenModes'
  /// value - String
  /// - example
  /// {'ovenModes': {'body': {'ovenModes': ['Bake', 'Conv. Bake Multi.']}, 'kind': 'ovenModes'}}
  static const F2N_DIRECT_REQUEST_AVAILABLE_OVEN_MODES = "f2n_direct_request_available_oven_modes";

  /// Called for retrieve available oven temperature items (For shortcut)
  /// key - 'ovenTemps'
  /// value - String
  /// - example
  /// 'ovenTemps': {'body': {'tempUnit': 'fahrenheit', 'ovenTemps': ['530', '535', '540', '545', '550']}, 'kind': 'ovenTemps'}}
  static const F2N_DIRECT_REQUEST_AVAILABLE_OVEN_TEMPS = "f2n_direct_request_available_oven_temps";

  /// Called for retrieve available ac mode items (For shortcut)
  /// key - 'acModes'
  /// value - String
  /// - example
  /// {'acModes': {'body': {'acModes': ['Dry', 'Energy Saver', 'Turbo Cool']}, 'kind': 'acModes'}}
  static const F2N_DIRECT_REQUEST_AVAILABLE_AC_MODES = "f2n_direct_request_available_ac_modes";

  /// Called for retrieve available ac temperature items (For shortcut)
  /// key - 'acTemps'
  /// value - String
  /// - example
  /// {'acTemps': {'body': {'acTemps': ['24', '25', '26', '27', '28', '29', '30'], 'tempUnit': 'fahrenheit'}, 'kind': 'acTemps'}}
  static const F2N_DIRECT_REQUEST_AVAILABLE_AC_TEMPS = "f2n_direct_request_available_ac_temps";

  /// Called for retrieve available ac Fan items (For shortcut)
  /// key - 'acFans'
  /// value - String
  /// - example
  /// {'acFans': {'body': {'acFans': ['Auto', 'High', 'Medium', 'Low']}, 'kind': 'acFans'}}
  static const F2N_DIRECT_REQUEST_AVAILABLE_AC_FANS = "f2n_direct_request_available_ac_fans";

  /// Called for retrieve all saved shortcuts (For shortcut)
  static const N2F_DIRECT_REQUEST_ALL_SHORTCUTS = "n2f_direct_request_all_shortcuts";

  /// Called for removing all saved shortcuts (For shortcut)
  static const N2F_DIRECT_REQUEST_REMOVE_ALL_SHORTCUTS = "n2f_direct_request_remove_all_shortcuts";

  /// Called when new shortcut was created.
  static const F2N_DIRECT_NOTIFYING_SHORTCUT_CREATED = "f2n_direct_notifying_shortcut_created";

  /// Called when existed shortcut was removed.
  static const F2N_DIRECT_NOTIFYING_SHORTCUT_REMOVED = "f2n_direct_notifying_shortcut_removed";

  /// Called when user clicks Create a new shortcut after the guidance
  static const F2N_DIRECT_NOTIFYING_SHORTCUT_GUIDANCE_DONE = "f2n_direct_notifying_shortcut_guidance_done";
}

enum ShortcutServiceChannelListenType {
  none,
}