import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_inside_left_getting_started_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_inside_left_enable_commissioning_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_inside_left_locate_label_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_inside_left_appliance_password_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class LeftOnWallNavigator extends StatelessWidget {
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
            case Routes.LEFT_ON_WALL_DESCRIPTION2_MODEL1:
              builder = (BuildContext _) => FridgeInsideLeftGettingStartedHaierPage();
              break;
            case Routes.LEFT_ON_WALL_DESCRIPTION3_MODEL1:
              builder = (BuildContext _) => FridgeInsideLeftEnableCommissioningHaierPage();
              break;
            case Routes.LEFT_ON_WALL_DESCRIPTION4_MODEL1:
              builder = (BuildContext _) => FridgeInsideLeftLocateLabelHaierPage();
              break;
            case Routes.LEFT_ON_WALL_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => FridgeInsideLeftAppliancePasswordHaierPage();
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