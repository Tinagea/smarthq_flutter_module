import 'base_config.dart';

class ProdConfig implements BaseConfig {

  String get apiHost => "https://api.brillion.geappliances.com";
  String get accountHost => "https://accounts.brillion.geappliances.com";
  String get clientMySmartHQApiHost => "https://client.mysmarthq.com";
  String get apiMySmartHQHost => "https://api.mysmarthq.com";

  String get brandContentsHost => "https://wca-mobile-brand-content-prd.brillion.geappliances.com";

  String get integration => "ee21425ff9263d7505434d2fda2e577ecf5a40f8";
  String get clientId => "564c31616c4f7474434b307435412b4d2f6e7672";
  String get clientSecret => "6476512b5246446d452f697154444941387052645938466e5671746e5847593d";

  String get appIdsIOS => "cloud.smarthq.mobile.smarthq.ios.prd";
  String get appIdsAndroid => "cloud.smarthq.mobile.smarthq.android.prd";
}