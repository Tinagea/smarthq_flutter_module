import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/beverage_center/beverage_center_navigate_page.dart' as BeverageCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/beverage_center/beverage_center_getting_started_page.dart' as BeverageCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/beverage_center/beverage_center_locate_label_page.dart' as BeverageCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/beverage_center/beverage_center_appliance_password_page.dart' as BeverageCenter;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class BeverageCenterNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.BEVERAGE_CENTER_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.BEVERAGE_CENTER_NAVIGATE_PAGE:
              builder = (BuildContext _) => BeverageCenter.BeverageCenterNavigatePage();
              break;
            case Routes.BEVERAGE_CENTER_DESCRIPTION:
              builder = (BuildContext _) => BeverageCenter.PageBeverageCenterDescription();
              break;
            case Routes.BEVERAGE_CENTER_APPLIANCE_INFO:
              builder = (BuildContext _) => BeverageCenter.PageBeverageCenterApplianceInfo();
              break;
            case Routes.BEVERAGE_CENTER_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => BeverageCenter.PageBeverageCenterPassword();
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