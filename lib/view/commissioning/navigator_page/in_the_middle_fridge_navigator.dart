import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_in_the_middle_appliance_password_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_in_the_middle_enable_commissioning_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_in_the_middle_getting_started_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_in_the_middle_locate_label_fnp_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class InTheMiddleFridgeNavigator extends StatelessWidget {
  InTheMiddleFridgeNavigator({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.IN_THE_MIDDLE_STEP1,
        onGenerateRoute: (RouteSettings settings) {
          final WidgetBuilder builder;
          switch (settings.name) {
            case Routes.IN_THE_MIDDLE_STEP1:
              builder = (_) => FridgeInTheMiddleGettingStartedFnpPage();
              break;
            case Routes.IN_THE_MIDDLE_STEP2:
              builder = (_) => FridgeInTheMiddleEnableCommissioningFnpPage();
              break;
            case Routes.IN_THE_MIDDLE_STEP3:
              builder = (_) => FridgeInTheMiddleLocateLabelFnpPage();
              break;
            case Routes.IN_THE_MIDDLE_STEP4:
              builder = (_) => FridgeInTheMiddleAppliancePasswordFnpPage();
              break;
            default:
              builder = (_) => FridgeInTheMiddleGettingStartedFnpPage();
              break;
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
