import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/toaster_oven/toaster_oven_profile_getting_started_page.dart' as ToasterOven;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/toaster_oven/toaster_oven_locate_label_page.dart' as ToasterOven;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/toaster_oven/toaster_oven_appliance_password_page.dart' as ToasterOven;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class ToasterOvenProfileNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.TOASTER_OVEN_PROFILE_DESCRIPTION1_MODEL,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.TOASTER_OVEN_PROFILE_DESCRIPTION1_MODEL:
              builder = (BuildContext _) => ToasterOven.ToasterOvenProfileCommissioningStep1();
              break;
            case Routes.TOASTER_OVEN_DESCRIPTION2_MODEL:
              builder = (BuildContext _) => ToasterOven.ToasterOvenCommissioningStep2();
              break;
            case Routes.TOASTER_OVEN_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => ToasterOven.ToasterOvenEnterPasswordStep();
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