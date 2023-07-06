import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_inside_right_enable_commissioning_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_inside_right_appliance_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_inside_right_getting_started_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_inside_right_locate_label_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class RightOnWallNavigator extends StatelessWidget {
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
            case Routes.RIGHT_ON_WALL_DESCRIPTION2_MODEL1:
              builder = (BuildContext _) => FridgeInsideRightGettingStartedFnpPage();
              break;
            case Routes.RIGHT_ON_WALL_DESCRIPTION3_MODEL1:
              builder = (BuildContext _) => FridgeInsideRightEnableCommissioningFnpPage();
              break;
            case Routes.RIGHT_ON_WALL_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => FridgeInsideRightAppliancePasswordFnpPage();
              break;
            case Routes.RIGHT_ON_WALL_COMMISSIONING_SHOW_TYPE:
              builder = (BuildContext _) => FridgeInsideRightLocateLabelFnpPage();
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