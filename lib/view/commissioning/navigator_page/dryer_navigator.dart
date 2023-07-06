import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_select_load_type_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_top_select_type_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_front_select_type_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_front_buttons_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_front_lcd_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_top_dial_only_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_top_dial_with_slider_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_front_buttons_appliance_password_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_front_lcd_getting_started_page_2.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_top_dial_with_button_getting_started_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_top_appliance_password_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_front_lcd_appliance_password_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_getting_started_haier_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_model1_appliance_password_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_appliance_password_haier_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_model1_getting_started_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_model2_appliance_password_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_model2_getting_started_fnp_page.dart' as Laundry;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/dryer/dryer_select_display_fnp_page.dart' as Laundry;

class DryerNavigator extends StatelessWidget {
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
              case Routes.DRYER_LOAD_LOCATION:
                builder = (BuildContext _) => Laundry.PageDryerLoadLocation();
                break;
              case Routes.DRYER_FRONT_LOAD:
                builder = (BuildContext _) => Laundry.DryerFrontLoadType();
                break;
              case Routes.DRYER_TOP_LOAD:
                builder = (BuildContext _) => Laundry.DryerTopLoadType();
                break;
              case Routes.DRYER_FRONT_MODEL1:
                builder = (BuildContext _) => Laundry.DryerFrontModel1Description();
                break;
              case Routes.DRYER_FRONT_MODEL2_STEP1:
                builder = (BuildContext _) => Laundry.DryerFrontModel2Step1();
                break;
              case Routes.DRYER_FRONT_MODEL2_STEP2:
                builder = (BuildContext _) => Laundry.DryerFrontModel2Step2();
                break;
              case Routes.DRYER_TOP_MODEL1:
                builder = (BuildContext _) => Laundry.DryerTopModel1Description();
                break;
              case Routes.DRYER_TOP_MODEL2:
                builder = (BuildContext _) => Laundry.DryerTopModel2Description();
                break;
              case Routes.DRYER_TOP_MODEL3:
                builder = (BuildContext _) => Laundry.DryerTopModel3Description();
                break;
              case Routes.DRYER_FRONT_1_PASSWORD:
                builder = (BuildContext _) => Laundry.DryerFront1PasswordPage();
                break;
              case Routes.DRYER_FRONT_2_PASSWORD:
                builder = (BuildContext _) => Laundry.DryerFront2PasswordPage();
                break;
              case Routes.DRYER_TOP_PASSWORD:
                builder = (BuildContext _) => Laundry.DryerTopPasswordPage();
                break;
              case Routes.DRYER_FRONT_1_DISPLAY_MODEL_SELECT_FNP:
                builder = (BuildContext _) => Laundry.DryerSelectDisplayFnpPage();
                break;
              case Routes.DRYER_MODEL_1_GETTING_STARTED_FNP:
                builder = (BuildContext _) => Laundry.DryerModel1GettingStartedFnpPage();
                break;
              case Routes.DRYER_MODEL_2_GETTING_STARTED_FNP:
                builder = (BuildContext _) => Laundry.DryerModel2GettingStartedFnpPage();
                break;
              case Routes.DRYER_MODEL_1_PASSWORD_FNP:
                builder = (BuildContext _) => Laundry.DryerModel1AppliancePasswordFnpPage();
                break;
              case Routes.DRYER_MODEL_2_PASSWORD_FNP:
                builder = (BuildContext _) => Laundry.DryerModel2AppliancePasswordFnpPage();
                break;
              case Routes.DRYER_MODEL_1_GETTING_STARTED_HAIER:
                builder = (BuildContext _) => Laundry.DryerGettingStartedHaierPage();
                break;
              case Routes.DRYER_MODEL_1_PASSWORD_HAIER:
                builder = (BuildContext _) => Laundry.DryerAppliancePasswordHaierPage();
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