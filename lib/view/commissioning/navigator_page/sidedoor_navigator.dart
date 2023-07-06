import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_side_door_getting_started_page.dart' as FridgeSideDoor;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_side_door_locate_label_page.dart' as FridgeSideDoor;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_side_door_appliance_password_page.dart' as FridgeSideDoor;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class SidedoorNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.SIDE_DOOR_DESCRIPTION1,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.SIDE_DOOR_DESCRIPTION1:
              builder = (BuildContext _) => FridgeSideDoor.SideDoorDescription1();
              break;
            case Routes.SIDE_DOOR_DESCRIPTION2:
              builder = (BuildContext _) => FridgeSideDoor.SideDoorDescription2();
              break;
            case Routes.SIDE_DOOR_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => FridgeSideDoor.SideDoorEnterPasswordPage();
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