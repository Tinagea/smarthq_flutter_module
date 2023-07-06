import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/espresso/espresso_manual_getting_started_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/espresso/espresso_manual_locate_label_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/espresso/espresso_manual_appliance_password_page.dart';

import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class EspressoManualNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.ESPRESSO_MANUAL_ONE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.ESPRESSO_MANUAL_ONE:
              builder = (BuildContext _) => ManualEspressoModuleStep1();
              break;
            case Routes.ESPRESSO_MANUAL_TWO:
              builder = (BuildContext _) => ManualEspressoModuleStep2();
              break;
            case Routes.ESPRESSO_MANUAL_THREE:
              builder = (BuildContext _) => ManualEspressoModuleStep3();
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