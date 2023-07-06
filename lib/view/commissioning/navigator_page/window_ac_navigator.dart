import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/window_ac/window_ac_getting_started_page.dart' as WindowAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/window_ac/window_ac_locate_label_page.dart' as WindowAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/window_ac/window_ac_appliance_password_page.dart' as WindowAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/window_ac/window_ac_getting_wifi_not_blinking_page.dart' as WindowAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/window_ac/window_ac_getting_call_page.dart' as WindowAC;

import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class WindowsACNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.WINDOW_AC_PAGE_1,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.WINDOW_AC_PAGE_1:
              builder = (BuildContext _) => WindowAC.WindowACHome();
              break;
            case Routes.WINDOW_AC_PAGE_2:
             builder = (BuildContext _) => WindowAC.WindowAcInfo();
              break;
            case Routes.WINDOW_AC_PAGE_3:
             builder = (BuildContext _) => WindowAC.WindowACPassword();
              break;
            case Routes.WINDOW_AC_PAGE_4:
              builder = (BuildContext _) => WindowAC.WindowACWifiNotBlinking();
              break;
            case Routes.WINDOW_AC_PAGE_5:
              builder = (BuildContext _) => WindowAC.WindowACCall();
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

