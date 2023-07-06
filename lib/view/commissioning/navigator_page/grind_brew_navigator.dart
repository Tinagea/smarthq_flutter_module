import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/coffee_maker/grind_brew_getting_started_page.dart' as GrindBrew;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/coffee_maker/grind_brew_appliance_password_page.dart' as GrindBrewPassword;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class GrindBrewNavigator extends StatelessWidget {

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
              builder = (BuildContext _) => Common.CommonNavigatePage();
              break;
            case Routes.GRIND_BREW_DESCRIPTION_MODEL:
              builder = (BuildContext _) => GrindBrew.GrindBrewCommissioningHome();
              break;
            case Routes.GRIND_BREW_ENTER_PASSWORD:
              builder = (BuildContext _) => GrindBrewPassword.GrindBrewEnterPasswordPage();
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