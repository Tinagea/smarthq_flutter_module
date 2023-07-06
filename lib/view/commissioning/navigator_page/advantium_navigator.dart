import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/advantium/adavantium_navigate_page.dart' as Advantium;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/advantium/advantium_getting_started_page.dart' as Advantium;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/advantium/advantium_appliance_password_page.dart' as Advantium;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class AdvantiumNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.ADVANTIUM_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.ADVANTIUM_NAVIGATE_PAGE:
              builder = (BuildContext _) => Advantium.AdvantiumNavigatePage();
              break;
            case Routes.ADVANTIUM_DESCRIPTION:
              builder = (BuildContext _) => Advantium.PageAdvantiumDescription();
              break;
            case Routes.ADVANTIUM_PASSWORD_INFO:
              builder = (BuildContext _) => Advantium.PageAdvantiumPassword(isFirstTimeShown: true);
              break;
            case Routes.ADVANTIUM_PASSWORD_INFO_1:
              builder = (BuildContext _) => Advantium.PageAdvantiumPassword(isFirstTimeShown: false);
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