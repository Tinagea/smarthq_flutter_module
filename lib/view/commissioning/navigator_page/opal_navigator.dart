import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/opal/opal_getting_started_page.dart'
    as Opal;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/opal/opal_locate_label_page.dart'
as Opal;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/opal/opal_appliance_password_page.dart'
    as Opal;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class OpalCommonNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.OPAL_DESCRIPTION_VIEW_1,
        onGenerateRoute: (RouteSettings routeSettings) {
          WidgetBuilder builder;
          switch (routeSettings.name) {
            case Routes.OPAL_DESCRIPTION_VIEW_1:
              builder = (BuildContext _) => Opal.OpalNuggetIceMakerHome();
              break;
            case Routes.OPAL_DESCRIPTION_VIEW_2:
              builder = (BuildContext _) => Opal.OpalDescription2();
              break;
            case Routes.OPAL_DESCRIPTION_VIEW_3:
              builder = (BuildContext _) => Opal.OpalDescription3();
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
