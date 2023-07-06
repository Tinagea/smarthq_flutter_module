import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_center/select_wifi_type.dart' as LaundryCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_center/laundry_center_select_external_wifi.dart' as LaundryCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_center/laundry_center_connect_plus_setup.dart' as LaundryCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_center/laundry_center_no_wifi_connection_options.dart' as LaundryCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_center/laundry_center_built_in_wifi_setup.dart' as LaundryCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_center/laundry_center_enter_password.dart' as LaundryCenter;

class LaundryCenterNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async => false,
      child: Navigator(
        initialRoute: Routes.COMMON_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.COMMON_NAVIGATE_PAGE:
              builder = (BuildContext _) => CommonNavigatePage();
              break;
            case Routes.LAUNDRY_CENTER_SELECT_WIFI_TYPE:
              builder = (BuildContext _) => LaundryCenter.SelectWifiConnectionType();
              break;
            case Routes.LAUNDRY_CENTER_SELECT_EXTERNAL_WIFI_OPTION:
              builder = (BuildContext _) => LaundryCenter.LaundryCenterSelectExternalWifi();
              break;
            case Routes.LAUNDRY_CENTER_CONNECT_PLUS_SETUP:
              builder = (BuildContext _) => LaundryCenter.LaundryCenterConnectPlusSetup();
              break;
            case Routes.LAUNDRY_CENTER_NO_WIFI_CONNECTION_OPTIONS:
              builder = (BuildContext _) => LaundryCenter.LaundryCenterNoWifiConnectionOptions();
              break;
            case Routes.LAUNDRY_CENTER_SETUP_BUILT_IN_WIFI:
              builder = (BuildContext _) => LaundryCenter.LaundryCenterBuiltInWifiSetup();
              break;
            case Routes.LAUNDRY_CENTER_ENTER_PASSWORD:
              builder = (BuildContext _) => LaundryCenter.LaundryCenterEnterPasswordPage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }

          return MaterialPageRoute(
            builder: builder, settings: settings);
        },
      )
    );
  }
}
