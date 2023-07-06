
abstract class ApplianceServiceChannelProfile {
  static const CHANNEL_NAME = "com.ge.smarthq.flutter.appliance.service";

  static const N2F_DIRECT_UPDATE_ERD_ALL = "n2f_direct_update_erd_all";
  static const N2F_DIRECT_GET_ERD_ALL = "n2f_direct_get_erd_all";
  static const N2F_DIRECT_UPDATE_ERD = "n2f_direct_update_erd";
  static const N2F_DIRECT_GET_ERD = "n2f_direct_get_erd";

  static const F2N_DIRECT_ON_STATUS = "f2n_direct_on_status";
}

enum ApplianceServiceChannelListenType {
  startService,
}