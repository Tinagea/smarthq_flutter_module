import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/countertops_select_type_page.dart' as CoffeeMaker;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/coffee_maker/coffee_maker_getting_started_page.dart' as CoffeeMaker;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/coffee_maker/coffee_maker_locate_label_page.dart' as CoffeeMaker;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/coffee_maker/coffee_maker_appliance_password_page.dart' as CoffeeMaker;


class CoffeeMakerNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.COFFEEMAKER_DESCRIPTION1_MODEL1,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.COUNTER_TOP_APPLIANCE_SELECTION_PAGE:
              builder = (BuildContext _) => CoffeeMaker.PageCounterTopApplianceSelectDisplay();
              break;
            case Routes.COFFEEMAKER_DESCRIPTION1_MODEL1:
              builder = (BuildContext _) => CoffeeMaker.CoffeeMakerHome();
              break;
            case Routes.COFFEEMAKER_DESCRIPTION2_MODEL2:
              builder = (BuildContext _) => CoffeeMaker.CoffeeMakerDescription();
              break;
            case Routes.COFFEEMAKER_DESCRIPTION3_MODEL3:
              builder = (BuildContext _) => CoffeeMaker.CoffeeMakerPassword();
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