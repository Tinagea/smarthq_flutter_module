import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/dehumidifier/dehumidifier_getting_started_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/dehumidifier/dehumidifier_locate_label_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/dehumidifier/dehumidifier_appliance_password_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class DehumidifierNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.DEHUMIDIFIER_DESCRIPTION1,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.DEHUMIDIFIER_DESCRIPTION1:
              builder = (BuildContext _) => DehumidifierStep1();
              break;
            case Routes.DEHUMIDIFIER_DESCRIPTION2:
              builder = (BuildContext _) => DehumidifierStep2();
              break;
            case Routes.DEHUMIDIFIER_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => DehumidifierStep3();
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