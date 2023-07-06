import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_select_type_page.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_hotwater_getting_started_page.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_led_getting_started_page.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_autofill_getting_started_page.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_hotwater_getting_started_page_2.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_led_getting_started_page_2.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_autofill_getting_started_page_2.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_hotwater_appliance_password_page.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_dispenser_appliance_password_page.dart' as FridgeDispenser;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class DispenserNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.DISPENSER_MODEL_SELECT,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.DISPENSER_MODEL_SELECT:
              builder = (BuildContext _) => FridgeDispenser.PageFridgeSelectDisplay();
              break;
            case Routes.DISPENSER_DESCRIPTION2_MODEL1:
              builder = (BuildContext _) => FridgeDispenser.DispenserCommissioningModel1Step1();
              break;
            case Routes.DISPENSER_DESCRIPTION2_MODEL2:
              builder = (BuildContext _) => FridgeDispenser.DispenserCommissioningModel2Step1();
              break;
            case Routes.DISPENSER_DESCRIPTION2_MODEL3:
              builder = (BuildContext _) => FridgeDispenser.DispenserCommissioningModel3Step1();
              break;
            case Routes.DISPENSER_DESCRIPTION3_MODEL1:
              builder = (BuildContext _) => FridgeDispenser.DispenserCommissioningModel1Step2();
              break;
            case Routes.DISPENSER_DESCRIPTION3_MODEL2:
              builder = (BuildContext _) => FridgeDispenser.DispenserCommissioningModel2Step2();
              break;
            case Routes.DISPENSER_DESCRIPTION3_MODEL3:
            builder = (BuildContext _) => FridgeDispenser.DispenserCommissioningModel3Step2();
            break;
            case Routes.DISPENSER_COMMISSIONING_ENTER_PASSWORD1:
              builder = (BuildContext _) => FridgeDispenser.DispenserEnterPasswordPage1();
              break;
            case Routes.DISPENSER_COMMISSIONING_ENTER_PASSWORD2:
            builder = (BuildContext _) => FridgeDispenser.DispenserEnterPasswordPage2();
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