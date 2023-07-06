import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/under_counter_icemaker/under_counter_icemaker_navigate_page.dart' as UnderCounter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/under_counter_icemaker/under_counter_icemaker_getting_started_page.dart' as UnderCounter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/under_counter_icemaker/under_counter_icemaker_locate_labed_page.dart' as UnderCounter;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/under_counter_icemaker/under_counter_icemaker_appliance_password_page.dart' as UnderCounter;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class UnderCounterIcemakerNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.UNDER_COUNTER_ICE_MAKER_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.UNDER_COUNTER_ICE_MAKER_NAVIGATE_PAGE:
              builder = (BuildContext _) => UnderCounter.UnderCounterIcemakerNavigatePage();
              break;
            case Routes.UNDER_COUNTER_ICE_MAKER_DESCRIPTION:
              builder = (BuildContext _) => UnderCounter.PageUnderCounterIcemakerDescription();
              break;
            case Routes.UNDER_COUNTER_ICE_MAKER_APPLIANCE_INFO:
              builder = (BuildContext _) => UnderCounter.PageUnderCounterIcemakerApplianceInfo();
              break;
            case Routes.UNDER_COUNTER_ICE_MAKER_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => UnderCounter.PageUnderCounterIcemakerPassword();
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