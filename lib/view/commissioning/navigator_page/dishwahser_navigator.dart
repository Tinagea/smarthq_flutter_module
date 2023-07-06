import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishwasher_getting_started_page.dart' as Dishwasher;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishwasher_locate_label_page.dart' as Dishwasher;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishwasher_appliance_password_page.dart' as Dishwasher;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/select_dishwasher_compact_type_page.dart' as Dishwasher;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishwasher_compact_page.dart' as Dishwasher;


import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class DishwasherNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.DISHWASHER_DESCRIPTION1_MODEL1,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.DISHWASHER_HOME:
              builder = (BuildContext _) => Dishwasher.DishwasherHome();
              break;
            case Routes.DISHWASHER_DESCRIPTION1_MODEL1:
              builder = (BuildContext _) => Dishwasher.SelectDishwasherCompactType();
              break;
            case Routes.DISHWASHER_DESCRIPTION2_MODEL2:
              builder = (BuildContext _) => Dishwasher.DishwasherDescription2();
              break;
            case Routes.DISHWASHER_DESCRIPTION3_MODEL3:
              builder = (BuildContext _) => Dishwasher.DishwasherDescription3();
              break;
            case Routes.DISHWASHER_COMPACT:
              builder = (BuildContext _) => Dishwasher.DishwasherCompactPage();
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