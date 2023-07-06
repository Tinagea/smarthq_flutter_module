import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hearth_oven/hearth_oven_getting_started_page.dart' as HearthOven;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hearth_oven/hearth_oven_getting_started_page_2.dart' as HearthOven;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hearth_oven/hearth_oven_getting_started_page_3.dart' as HearthOven;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hearth_oven/hearth_oven_appliance_password_page.dart' as HearthOven;

import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class HearthOvenNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.HEARTH_OVEN_DESCRIPTION,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.HEARTH_OVEN_DESCRIPTION:
              builder = (BuildContext _) => HearthOven.HearthOvenDescription();
              break;
            case Routes.HEARTH_OVEN_PREFERENCES:
              builder = (BuildContext _) => HearthOven.HearthOvenPreferences();
              break;
            case Routes.HEARTH_OVEN_WIFI:
              builder = (BuildContext _) => HearthOven.HearthOvenWifiInfo();
              break;
            case Routes.HEARTH_OVEN_PASSWORD_INFO:
              builder = (BuildContext _) => HearthOven.HearthOvenPasswordInfo();
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

