import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_getting_started_fnp_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_appliance_password_fnp_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_select_type_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_multi_plus_minus_getting_started_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_single_plus_minus_getting_started_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_autofill_getting_started_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_multi_plus_minus_locate_label_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_single_plus_minus_locate_label_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_on_top_appliance_password_page.dart' as OnTop;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class OnTopNavigator extends StatelessWidget {
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
            case Routes.ON_TOP_DESCRIPTION1:
              builder =
                  (BuildContext _) => OnTop.OnTopCommissioningMain();
              break;
            case Routes.ON_TOP_DESCRIPTION2_MODEL1:
              builder = (BuildContext _) =>
                  OnTop.OnTopCommissioningModel1Step1();
              break;
            case Routes.ON_TOP_DESCRIPTION2_MODEL2:
              builder = (BuildContext _) =>
                  OnTop.OnTopCommissioningModel2Step1();
              break;
            case Routes.ON_TOP_DESCRIPTION2_MODEL3:
              builder = (BuildContext _) =>
                  OnTop.OnTopCommissioningModel3Step1();
              break;
            case Routes.ON_TOP_DESCRIPTION2_FNP_MODEL3:
              builder = (BuildContext _) =>
                  OnTop.FridgeOnTopGettingStartedFnpPage();
              break;
            case Routes.ON_TOP_DESCRIPTION3_MODEL1:
              builder = (BuildContext _) =>
                  OnTop.OnTopCommissioningModel1Step2();
              break;
            case Routes.ON_TOP_DESCRIPTION3_MODEL2:
              builder = (BuildContext _) =>
                  OnTop.OnTopCommissioningModel2Step2();
              break;
            case Routes.ON_TOP_COMMISSIONING_ENTER_PASSWORD:
              builder =
                  (BuildContext _) => OnTop.OnTopEnterPasswordPage();
              break;
            case Routes.ON_TOP_COMMISSIONING_FNP_ENTER_PASSWORD:
              builder =
                  (BuildContext _) => OnTop.FridgeOnTopAppliancePasswordFnpPage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(
              builder: builder, settings: settings);
        },
      ),
    );
  }
}
