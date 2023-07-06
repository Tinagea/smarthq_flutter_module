import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/connect_plus/connect_plus_getting_started_page.dart' as ConnectedPlus;
import 'package:smarthq_flutter_module/view/commissioning/common_page/connect_plus/connect_plus_password_page.dart' as ConnectedPlus;
import 'package:smarthq_flutter_module/view/commissioning/common_page/connect_plus/connect_plus_dish_remove_bottom_page.dart' as ConnectedPlus;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class ScreenArgs {
  final ApplianceType applianceType;
  ScreenArgs(this.applianceType);
}

class ConnectPlusNavigator extends StatelessWidget {
  final ApplianceType applianceType;
  ConnectPlusNavigator(this.applianceType);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.CONNECT_PLUS_STARTED_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.CONNECT_PLUS_STARTED_PAGE:
              builder = (BuildContext _) => ConnectedPlus.ConnectPlusStartedPage(applianceType);
              break;
            case Routes.CONNECT_PLUS_ENTER_PASSWORD_PAGE:
              builder = (BuildContext _) => ConnectedPlus.ConnectPlusEnterPasswordPage();
              break;
            case Routes.CONNECT_PLUS_DISH_REMOVE_BOTTOM_PAGE:
              builder = (BuildContext _) => ConnectedPlus.ConnectPlusDishRemoveBottomPage();
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