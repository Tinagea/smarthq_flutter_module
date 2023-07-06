import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/flavourly/ui/splash_screen.dart' as Flavourly;
import 'package:smarthq_flutter_module/view/flavourly/ui/home_screen.dart' as Flavourly;
import 'package:smarthq_flutter_module/view/flavourly/ui/universal_generator.dart' as Flavourly;
import 'package:smarthq_flutter_module/view/flavourly/ui/menu_details_page.dart' as Flavourly;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class FlavourlyCommonNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.FLAVOURLY_SPLASH_SCREEN,
        onGenerateRoute: (RouteSettings routeSettings) {
          WidgetBuilder builder;
          switch (routeSettings.name) {
            case Routes.FLAVOURLY_SPLASH_SCREEN:
              builder = (BuildContext _) => Flavourly.SplashScreen();
              break;
            case Routes.FLAVOURLY_HOME_SCREEN:
              builder = (BuildContext _) => Flavourly.HomeScreen();
              break;
            case Routes.FLAVOURLY_UNIVERSAL_GENERATOR:
              builder = (BuildContext _) => Flavourly.UniversalGenerator();
              break;
            case Routes.FLAVOURLY_MENU_DETAILS_PAGE:
              builder = (BuildContext _) => Flavourly.MenuDetailsPage();
              break;
            default:
              throw Exception('Invalid route: ${routeSettings.name}');
          }

          return MaterialPageRoute(builder: builder, settings: routeSettings);
        },
      ),
    );
  }
}
/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */
