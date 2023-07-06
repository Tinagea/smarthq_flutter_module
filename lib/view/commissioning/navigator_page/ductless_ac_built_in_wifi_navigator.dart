import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/ductless_ac/ductless_ac_locate_label_page.dart' as DuctlessAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/ductless_ac/ductless_ac_appliance_password_page.dart' as DuctlessAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/ductless_ac/ductless_ac_select_type_page.dart' as DuctlessAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/ductless_ac/ductless_ac_built_in_wifi_getting_started_page.dart' as DuctlessAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/ductless_ac/ductless_ac_usb_wifi_getting_started_page.dart' as DuctlessAC;

import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class DuctlessACNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.DUCTLESS_AC_APPLIANCE_SELECTION_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.DUCTLESS_AC_APPLIANCE_SELECTION_PAGE:
              builder = (BuildContext _) => DuctlessAC.PageDuctlessACSelectType();
              break;
            case Routes.DUCTLESS_AC_BUILT_IN_WIFI_DESC_PAGE_1:
              builder = (BuildContext _) => DuctlessAC.BuildInWifiACHome();
              break;
            case Routes.DUCTLESS_AC_USB_WIFI_DESCRIPTION_PAGE:
              builder = (BuildContext _) => DuctlessAC.USBWifiACHome();
              break;
            case Routes.DUCTLESS_AC_APPLIANCE_INFO_PAGE:
              builder = (BuildContext _) => DuctlessAC.DuctlessACApplianceInfoPage();
              break;
            case Routes.DUCTLESS_AC_APPLIANCE_PASSWORD_INFO_PAGE:
              builder = (BuildContext _) => DuctlessAC.DuctlessACPassword();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}

