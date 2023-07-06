
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_enable_commissioning_haier_page_1.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_enable_commissioning_haier_page_2.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_enter_password_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_getting_started_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_model1_appliance_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_model1_getting_started_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_model2_enable_commissioning_fnp_page_1.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_model2_enable_commissioning_fnp_page_2.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_model2_enable_commissioning_fnp_page_3.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_model2_appliance_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_model2_getting_started_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/wall_oven/wall_oven_select_display_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class WallOvenNavigatorFnp extends StatelessWidget {
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
            case Routes.WALL_OVEN_MODEL_SELECTION_FNP:
              builder = (BuildContext _) => WallOvenSelectDisplayFnpPage();
              break;
            case Routes.WALL_OVEN_MODEL_1_STEP_1_FNP:
              builder = (BuildContext _) => WallOvenModel1GettingStartedFnpPage();
              break;
            case Routes.WALL_OVEN_MODEL_1_STEP_2_FNP:
              builder = (BuildContext _) => WallOvenModel1AppliancePasswordFnpPage();
              break;
            case Routes.WALL_OVEN_MODEL_2_STEP_1_FNP:
              builder = (BuildContext _) => WallOvenModel2GettingStartedFnpPage();
              break;
            case Routes.WALL_OVEN_MODEL_2_STEP_2_FNP:
              builder = (BuildContext _) => WallOvenModel2EnableCommissioningFnpPage1();
              break;
            case Routes.WALL_OVEN_MODEL_2_STEP_3_FNP:
              builder = (BuildContext _) => WallOvenModel2EnableCommissioningFnpPage2();
              break;
            case Routes.WALL_OVEN_MODEL_2_STEP_4_FNP:
              builder = (BuildContext _) => WallOvenModel2EnableCommissioningFnpPage3();
              break;
            case Routes.WALL_OVEN_MODEL_2_STEP_5_FNP:
              builder = (BuildContext _) => WallOvenModel2AppliancePasswordFnpPage();
              break;
            case Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_1:
              builder = (BuildContext _) => WallOvenGettingStartedHaierPage();
              break;
            case Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_2:
              builder = (BuildContext _) => WallOvenEnableCommissioningHaierPage1();
              break;
            case Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_3:
              builder = (BuildContext _) => WallOvenEnableCommissioningHaierPage2();
              break;
            case Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_4:
              builder = (BuildContext _) => WallOvenEnterPasswordHaierPage();
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