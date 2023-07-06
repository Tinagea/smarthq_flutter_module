import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/wine_center/wine_center_navigate_page.dart' as WineCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/wine_center/wine_center_getting_started_page.dart' as WineCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/wine_center/wine_center_locate_label_page.dart' as WineCenter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/wine_center/wine_center_appliance_password_page.dart' as WineCenter;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class WineCenterNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.WINE_CENTER_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.WINE_CENTER_NAVIGATE_PAGE:
              builder = (BuildContext _) => WineCenter.WineCenterNavigatePage();
              break;
            case Routes.WINE_CENTER_DESCRIPTION:
              builder = (BuildContext _) => WineCenter.PageWineCenterDescription();
              break;
            case Routes.WINE_CENTER_APPLIANCE_INFO:
              builder = (BuildContext _) => WineCenter.PageWineCenterApplianceInfo();
              break;
            case Routes.WINE_CENTER_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => WineCenter.PageWineCenterPassword();
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