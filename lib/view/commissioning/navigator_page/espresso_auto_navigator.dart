import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/espresso/espresso_auto_getting_started_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/espresso/espresso_auto_locate_label_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/espresso/espresso_auto_appliance_password_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class EspressoAutoNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.ESPRESSO_AUTO_ONE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.ESPRESSO_AUTO_ONE:
              builder = (BuildContext _) => AutoEspressoModuleStep1();
              break;
            case Routes.ESPRESSO_AUTO_TWO:
              builder = (BuildContext _) => AutoEspressoModuleStep2();
              break;
            case Routes.ESPRESSO_AUTO_THREE:
              builder = (BuildContext _) => AutoEspressoModuleStep3();
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