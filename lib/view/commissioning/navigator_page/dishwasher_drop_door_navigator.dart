/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_central_front_appliance_password_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_central_front_enable_commissioning_haier_page_1.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_central_front_enable_commissioning_haier_page_2.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_central_front_getting_started_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_central_front_locate_label_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_inside_top_appliance_password_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_inside_top_enable_commissioning_haier_page_1.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_inside_top_enable_commissioning_haier_page_2.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_inside_top_getting_started_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_inside_top_locate_label_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_on_front_appliance_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_on_front_getting_started_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/drop_door_on_front_locate_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dropdoor/locate_drop_door_control_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class DishwasherDropDoorNavigator extends StatelessWidget {
  const DishwasherDropDoorNavigator({Key? key}) : super(key: key);

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
            case Routes.DROP_DOOR_FNP_STEP1:
              builder = (BuildContext _) => DropDoorGettingStartedFnpPage();
              break;
            case Routes.DROP_DOOR_FNP_STEP2:
              builder = (BuildContext _) => DropDoorOnFrontLocatePasswordFnpPage();
              break;
            case Routes.DROP_DOOR_FNP_STEP3:
              builder = (BuildContext _) => DropDoorOnFrontAppliancePasswordFnpPage();
              break;
            case Routes.DROP_DOOR_LOCATE_CONTROL_HAIER:
              builder = (BuildContext _) => LocateDropDoorControlHaierPage();
              break;
            case Routes.DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP1:
              builder =
                  (BuildContext _) => DropDoorCentralFrontGettingStartedHaierPage();
              break;
            case Routes.DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP2:
              builder =
                  (BuildContext _) => DropDoorCentralFrontEnableCommissioningHaierPage1();
              break;
            case Routes.DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP3:
              builder =
                  (BuildContext _) => DropDoorCentralFrontEnableCommissioningHaierPage2();
              break;
            case Routes.DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP4:
              builder =
                  (BuildContext _) => DropDoorCentralFrontLocateLabelHaierPage();
              break;
            case Routes.DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP5:
              builder =
                  (BuildContext _) => DropDoorCentralFrontAppliancePasswordHaierPage();
              break;
            case Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP1:
              builder = (BuildContext _) => DropDoorInsideTopGettingStartedHaierPage();
              break;
            case Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP2:
              builder = (BuildContext _) => DropDoorInsideTopEnableCommissioningHaierPage1();
              break;
            case Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP3:
              builder = (BuildContext _) => DropDoorInsideTopEnableCommissioningHaierPage2();
              break;
            case Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP4:
              builder = (BuildContext _) => DropDoorInsideTopLocateLabelHaierPage();
              break;
            case Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP5:
              builder = (BuildContext _) => DropDoorInsideTopAppliancePasswordHaierPage();
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
