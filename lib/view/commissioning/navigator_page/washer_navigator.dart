import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_select_load_type_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_front_select_type_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_top_select_type_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_front_buttons_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_front_lcd_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_top_dial_only_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_top_dial_with_slider_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_front_buttons_appliance_password_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_front_lcd_getting_started_page_2.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_front_lcd_appliance_password_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_top_dial_with_button_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_top_appliance_password_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_model1_appliance_password_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_model1_getting_started_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_front_load_appliance_password_haier_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_front_load_getting_started_haier_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_model2_appliance_password_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_model2_getting_started_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_select_display_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_select_load_location_haier_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_top_load_appliance_password_haier_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/washer/washer_top_load_getting_started_haier_page.dart' as Laundry;

class WasherNavigator extends StatelessWidget {
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
              case Routes.WASHER_LOAD_LOCATION:
                builder = (BuildContext _) => Laundry.PageWasherLoadLocation();
                break;
              case Routes.WASHER_FRONT_LOAD:
                builder = (BuildContext _) => Laundry.WasherFrontLoadType();
                break;
              case Routes.WASHER_TOP_LOAD:
                builder = (BuildContext _) => Laundry.WasherTopLoadType();
                break;
              case Routes.WASHER_FRONT_MODEL1:
                builder = (BuildContext _) => Laundry.WasherFrontModel1Description();
                break;
              case Routes.WASHER_FRONT_MODEL2_STEP1:
                builder = (BuildContext _) => Laundry.WasherFrontModel2Step1();
                break;
              case Routes.WASHER_FRONT_MODEL2_STEP2:
                builder =(BuildContext _) => Laundry.WasherFrontModel2Step2();
                break;
              case Routes.WASHER_TOP_MODEL1:
                builder = (BuildContext _) => Laundry.WasherTopModel1Description();
                break;
              case Routes.WASHER_TOP_MODEL2:
                builder = (BuildContext _) => Laundry.WasherTopModel2Description();
                break;
              case Routes.WASHER_TOP_MODEL3:
                builder = (BuildContext _) => Laundry.WasherTopModel3Description();
                break;
              case Routes.WASHER_FRONT_1_PASSWORD:
                builder = (BuildContext _) => Laundry.WasherFront1PasswordPage();
                break;
              case Routes.WASHER_FRONT_2_PASSWORD:
                builder = (BuildContext _) => Laundry.WasherFront2PasswordPage();
                break;
              case Routes.WASHER_TOP_PASSWORD:
                builder = (BuildContext _) => Laundry.WasherTopPasswordPage();
                break;
              case Routes.WASHER_FRONT_1_DISPLAY_MODEL_SELECT_FNP:
                builder = (BuildContext _) => Laundry.WasherSelectDisplayFnpPage();
                break;
              case Routes.WASHER_MODEL_1_GETTING_STARTED_FNP:
                builder = (BuildContext _) => Laundry.WasherModel1GettingStartedFnpPage();
                break;
              case Routes.WASHER_MODEL_2_GETTING_STARTED_FNP:
                builder = (BuildContext _) => Laundry.WasherModel2GettingStartedFnpPage();
                break;
              case Routes.WASHER_MODEL_1_PASSWORD_FNP:
                builder = (BuildContext _) => Laundry.WasherModel1AppliancePasswordFnpPage();
                break;
              case Routes.WASHER_MODEL_2_PASSWORD_FNP:
                builder = (BuildContext _) => Laundry.WasherModel2AppliancePasswordFnpPage();
                break;
              case Routes.WASHER_HAIER_SELECT_LOAD_LOCATION:
                builder = (BuildContext _) => Laundry.WasherSelectLoadLocationHaierPage();
                break;
              case Routes.WASHER_FRONT_LOAD_GETTING_STARTED_HAIER:
                builder = (BuildContext _) => Laundry.WasherFrontLoadGettingStartedHaierPage();
                break;
              case Routes.WASHER_FRONT_LOAD_PASSWORD_HAIER:
                builder = (BuildContext _) => Laundry.WasherFrontLoadAppliancePasswordHaierPage();
                break;
              case Routes.WASHER_TOP_LOAD_GETTING_STARTED_HAIER:
                builder = (BuildContext _) => Laundry.WasherTopLoadGettingStartedHaierPage();
                break;
              case Routes.WASHER_TOP_LOAD_PASSWORD_HAIER:
                builder = (BuildContext _) => Laundry.WasherTopLoadAppliancePasswordHaierPage();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }

            return MaterialPageRoute(
                builder: builder, settings: settings);
          },
        )
    );
  }
}