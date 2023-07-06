import 'base_config.dart';

class DevConfig implements BaseConfig {

  String get apiHost => "https://api-fld.brillion.geappliances.com";
  String get accountHost => "https://accounts-fld.brillion.geappliances.com";
  String get clientMySmartHQApiHost => "https://client-fld.mysmarthq.com";
  String get apiMySmartHQHost => "https://api-fld.mysmarthq.com";

  String get brandContentsHost => "https://wca-mobile-brand-content-fld.brillion.geappliances.com";

  String get integration => "b77844c8778c7d77263eb10f9552c7060c4bde59";
  String get clientId => "55527330624d73306a63565a554f612b337a3842";
  String get clientSecret => "714c6574425736715763426e35554778625351684b4f654f3847654d7343733d";

  String get appIdsIOS => "cloud.smarthq.mobile.smarthq.ios.fld";
  String get appIdsAndroid => "cloud.smarthq.mobile.smarthq.android.fld";
}