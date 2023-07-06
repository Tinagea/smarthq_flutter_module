/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_appliance_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_getting_started_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class RangeNavigatorFnp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        key: _navigatorKey,
        initialRoute: Routes.COMMON_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.COMMON_NAVIGATE_PAGE:
              builder = (BuildContext _) => CommonNavigatePage();
              break;
            case Routes.RANGE_FNP_GETTING_STARTED:
              builder = (BuildContext _) => RangeGettingStartedFnpPage();
              break;
            case Routes.RANGE_FNP_ENTER_PASSWORD:
              builder = (BuildContext _) => RangeAppliancePasswordFnpPage();
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
