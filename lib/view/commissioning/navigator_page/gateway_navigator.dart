import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/gateway/gateway_select_gateway_list_page.dart' as Gateway;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/gateway/gateway_getting_started_page.dart' as Gateway;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/gateway/gateway_getting_started_page_2.dart' as Gateway;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/gateway/gateway_select_gateway_page.dart' as Gateway;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/gateway/gateway_pair_sensor_getting_started_page.dart' as Gateway;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/gateway/gateway_pair_sensor_pairing_page.dart' as Gateway;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/gateway/gateway_pair_sensor_success_page.dart' as Gateway;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/gateway/gateway_pair_sensor_failure_page.dart' as Gateway;
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart' as Common;

class GatewayNavigatorArgs {
  final bool? calledFromFirstScreen;
  GatewayNavigatorArgs({
    this.calledFromFirstScreen
  });
}

class GatewayNavigator extends StatelessWidget {
  final GatewayNavigatorArgs? args;

  GatewayNavigator(this.args);

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
            case Routes.GATEWAY_SELECT_GATEWAY_PAGE:
              builder = (BuildContext _) => Gateway.GatewaySelectGatewayPage();
              break;
            case Routes.GATEWAY_SELECT_GATEWAY_LIST_PAGE:
              builder = (BuildContext _) => Gateway.GatewaySelectGatewayListPage();
              break;
            case Routes.GATEWAY_STARTED_PAGE:
              builder = (BuildContext _) => Gateway.GatewayGettingStartedPage();
              break;
            case Routes.GATEWAY_DESCRIPTION_PAGE:
              builder = (BuildContext _) => Gateway.GatewayGettingStartedPage2();
              break;
            case Routes.GATEWAY_PAIR_SENSOR_DESCRIPTION_PAGE:
              builder = (BuildContext _) => Gateway.GatewayPairSensorGettingStartedPage(args);
              break;
            case Routes.GATEWAY_PAIR_SENSOR_PAIRING_PAGE:
              builder = (BuildContext _) => Gateway.GatewayPairSensorPairingPage();
              break;
            case Routes.GATEWAY_PAIR_SENSOR_SUCCESS_PAGE:
              builder = (BuildContext _) => Gateway.GatewayPairSensorSuccessPage();
              break;
            case Routes.GATEWAY_PAIR_SENSOR_FAILURE_PAGE:
              builder = (BuildContext _) => Gateway.GatewayPairSensorFailurePage();
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