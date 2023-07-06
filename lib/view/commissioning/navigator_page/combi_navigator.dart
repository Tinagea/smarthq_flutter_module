/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/combi/combi_getting_started_page.dart' as Combi;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/combi/combi_appliance_password_page.dart' as Combi;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class CombiNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.COMMON_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.COMMON_NAVIGATE_PAGE:
              builder = (BuildContext _) => CommonNavigatePage();
              break;
            case Routes.COMBI_DESCRIPTION1:
              builder = (BuildContext _) => Combi.CombiCommissioningStart();
              break;
            case Routes.COMBI_PASSWORD:
              builder = (BuildContext _) => Combi.CombiPasswordPage();
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