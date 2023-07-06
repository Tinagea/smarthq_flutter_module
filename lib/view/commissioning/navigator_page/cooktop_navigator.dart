import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_gas_getting_started_page.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_gas_getting_started_page_2.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_gas_getting_started_page_3.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_induction_getting_started_page_3.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_appliance_password_page.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_select_type_page.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_induction_getting_started_page.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_induction_getting_started_page_2.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_locate_label_page.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooktop/cooktop_electric_getting_started_page.dart' as Cooktop;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class CooktopInductionNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.COOKTOP_SELECT,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.COOKTOP_SELECT:
              builder = (BuildContext _) => Cooktop.PageCooktopSelectOption();
              break;
            case Routes.COOKTOP_INDUCTION_DESCRIPTION:
              builder = (BuildContext _) => Cooktop.PageCooktopInductionDescription();
              break;
            case Routes.COOKTOP_INDUCTION_ADD:
              builder = (BuildContext _) => Cooktop.PageCooktopInductionAdd();
              break;
            case Routes.COOKTOP_INDUCTION_OFF:
              builder = (BuildContext _) => Cooktop.PageCooktopInductionOff();
              break;

            case Routes.COOKTOP_GAS_DESCRIPTION:
              builder = (BuildContext _) => Cooktop.PageCooktopGasDescription();
              break;
            case Routes.COOKTOP_GAS_STEP_2:
              builder = (BuildContext _) => Cooktop.PageCooktopGasStep2();
              break;
            case Routes.COOKTOP_GAS_STEP_3:
              builder = (BuildContext _) => Cooktop.PageCooktopGasStep3();
              break;
            case Routes.COOKTOP_APPLIANCE_INFO_GAS:
              builder = (BuildContext _) => Cooktop.PageCooktopApplianceInfo();
              break;
            case Routes.COOKTOP_APPLIANCE_INFO_INDUCTION:
              builder = (BuildContext _) => Cooktop.PageCooktopApplianceInfo();
              break;
            case Routes.COOKTOP_APPLIANCE_INFO_ELECTRIC:
              builder = (BuildContext _) => Cooktop.PageCooktopApplianceInfo();
              break;
            case Routes.COOKTOP_PASSWORD_INFO:
              builder = (BuildContext _) => Cooktop.PageCooktopPasswordInfo();
              break;
            case Routes.COOKTOP_ELECTRIC_DESCRIPTION:
              builder = (BuildContext _) => Cooktop.PageCooktopElectricDescription();
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