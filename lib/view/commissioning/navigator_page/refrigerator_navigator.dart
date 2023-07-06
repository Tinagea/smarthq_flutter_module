import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/refrigeration_select_type_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class RefrigeratorNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.REFRIGERATOR_SELECT_NAVIGATOR,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.REFRIGERATOR_SELECT_NAVIGATOR:
              builder = (BuildContext _) => RefrigeratorApplianceTypePage();
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