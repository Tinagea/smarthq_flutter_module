import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/microwave/microwave_locate_label_page.dart' as Microwave;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/microwave/microwave_getting_started_page.dart' as Microwave;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/microwave/microwave_appliance_password_page.dart' as Microwave;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class MicrowaveNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.MICROWAVE_DESCRIPTION,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.MICROWAVE_DESCRIPTION:
              builder = (BuildContext _) => Microwave.MicrowaveDescription();
              break;
            case Routes.MICROWAVE_APPLIANCE_INFO:
              builder = (BuildContext _) => Microwave.MicrowaveApplianceInfo();
              break;
            case Routes.MICROWAVE_PASSWORD_INFO:
              builder = (BuildContext _) => Microwave.MicrowavePasswordInfo();
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