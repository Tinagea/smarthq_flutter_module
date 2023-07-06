import 'package:flutter/material.dart';

import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_navigate_page.dart'
as WallOven;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_select_type_page.dart'
    as WallOven;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_lcd_getting_started_page.dart'
    as WallOven1;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_lcd_select_type_page.dart'
    as WallOven1;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_lcd_follow_appliance_instruction_page.dart'
    as WallOven1;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_lcd_appliance_password_page.dart'
    as WallOven1;

import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_remote_enable_getting_started_page.dart'
    as WallOven2;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_wifi_connect_getting_started_page.dart'
    as WallOven2;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_settings_getting_started_page.dart'
    as WallOven2;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_lcd_with_buttons_locate_label_page.dart'
    as WallOven2;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_lcd_with_buttons_appliance_password_page.dart'
    as WallOven2;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_remote_enable_appliance_password_page.dart' as WallOven2;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_lcd_with_buttons_select_button_type_page.dart'
    as WallOven2;

import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_knob_getting_started_page.dart'
    as WallOven3;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_knob_getting_started_page_2.dart'
    as WallOven3;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_knob_getting_started_page_3.dart'
    as WallOven3;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_knob_appliance_password_page.dart'
    as WallOven3;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class WallOvenNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.WALL_OVEN_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.WALL_OVEN_NAVIGATE_PAGE:
              builder =
                  (BuildContext _) => WallOven.WallOvenNavigatePage();
              break;
            case Routes.WALL_OVEN_SELECTOR_PRIMARY:
              builder =
                  (BuildContext _) => WallOven.WallOvenSelectionPagePrimary();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_1_PAGE_1:
              builder = (BuildContext _) => WallOven1.WallOvenPrimaryTypeOnePage1();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_1_PAGE_2:
              builder = (BuildContext _) => WallOven1.WallOvenPrimaryTypeOnePage2();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_1_PAGE_3:
              builder = (BuildContext _) => WallOven1.WallOvenPrimaryTypeOnePage3();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_1_PAGE_PASSWORD_1:
              builder = (BuildContext _) =>
                  WallOven1.WallOvenLcdAppliancePasswordPage(isFirstTimeShown: true);
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_1_PAGE_PASSWORD_2:
              builder = (BuildContext _) =>
                  WallOven1.WallOvenLcdAppliancePasswordPage(isFirstTimeShown: false);
              break;
            case Routes.WALL_OVEN_SELECTOR_TYPE_2:
              builder = (BuildContext _) => WallOven2.WallOvenSelectionPageType2();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_ONE:
              builder = (BuildContext _) => WallOven2.WallOvenPrimaryTypeTwoPageOneType1();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_TWO:
              builder = (BuildContext _) => WallOven2.WallOvenPrimaryTypeTwoPageOneType2();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_THREE:
              builder = (BuildContext _) => WallOven2.WallOvenPrimaryTypeTwoPageOneType3();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_TWO:
              builder = (BuildContext _) => WallOven2.WallOvenPrimaryTypeTwoPage2();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_PASSWORD:
              builder = (BuildContext _) => WallOven2.WallOvenLcdWithButtonsPasswordPage();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_2_REMOTE_ENABLE_PASSWORD:
              builder = (BuildContext _) => WallOven2.PagePasswordWallOvenTypeTwoRemoteEnable();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_1:
              builder = (BuildContext _) => WallOven3.WallOvenPrimaryTypeThreePage1();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_2:
              builder = (BuildContext _) => WallOven3.WallOvenPrimaryTypeThreePage2();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_3:
              builder = (BuildContext _) => WallOven3.WallOvenPrimaryTypeThreePage3();
              break;
            case Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_PASSWORD:
              builder = (BuildContext _) => WallOven3.WallOvenKnobPasswordPage();
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
