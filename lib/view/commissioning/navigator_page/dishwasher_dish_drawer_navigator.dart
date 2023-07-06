/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishdrawer/dishdrawer_appliance_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishdrawer/dishdrawer_inside_top_enable_commissioning_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishdrawer/dishdrawer_locate_control_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishdrawer/dishdrawer_locate_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishdrawer/dishdrawer_inside_top_getting_started_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishdrawer/dishdrawer_on_front_enable_commissioning_fnp_page_1.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishdrawer/dishdrawer_on_front_getting_started_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishdrawer/dishdrawer_on_front_enable_commissioning_fnp_page_2.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class DishwasherDishDrawerNavigator extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        key: _navigatorKey,
        initialRoute: Routes.DISH_DRAWER_LOCATE_CONTROL,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.DISH_DRAWER_LOCATE_CONTROL:
              builder = (BuildContext _) => DishDrawerLocateControlFnpPage();
              break;
            case Routes.DISH_DRAWER_INSIDE_TOP_STEP1:
              builder = (BuildContext _) => DishDrawerInsideTopGettingStartedFnpPage();
              break;
            case Routes.DISH_DRAWER_INSIDE_TOP_STEP2:
              builder = (BuildContext _) => DishDrawerInsideTopEnableCommissioningFnpPage();
              break;
            case Routes.DISH_DRAWER_ON_FRONT_OF_DOOR_STEP1_PATH:
              builder = (BuildContext _) => DishDrawerOnFrontGettingStartedFnpPage();
              break;
            case Routes.DISH_DRAWER_ON_FRONT_OF_DOOR_STEP2_PATH:
              builder = (BuildContext _) => DishDrawerOnFrontEnableCommissioningFnpPage1();
              break;
            case Routes.DISH_DRAWER_ON_FRONT_OF_DOOR_STEP3_PATH:
              builder = (BuildContext _) => DishDrawerOnFrontEnableCommissioningPage2();
              break;
            case Routes.DISH_DRAWER_LOCATE_PASSWORD_PAGE:
              builder = (BuildContext _) => DishDrawerLocatePasswordFnpPage();
              break;
            case Routes.DISH_DRAWER_ENTER_PASSWORD_PAGE:
              builder = (BuildContext _) => DishDrawerAppliancePasswordFnpPage();
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
