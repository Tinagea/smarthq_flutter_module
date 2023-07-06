import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/portable_ac/portable_ac_wifi_getting_started_page.dart' as PotableAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/portable_ac/portable_ac_locate_label_page.dart' as PotableAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/portable_ac/portable_ac_appliance_password_page.dart' as PotableAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/portable_ac/portable_ac_select_type_page.dart' as PotableAC;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/portable_ac/portable_ac_timer_getting_started_page.dart' as PotableAC;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class PortableAcNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.PORTABLE_AC_MAIN_NAVIGATOR,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.PORTABLE_AC_MAIN_NAVIGATOR:
              builder = (BuildContext _) => PotableAC.PagePortableACSelectType();
              break;
            case Routes.PORTABLE_AC_TIMER_DESCRIPTION:
              builder = (BuildContext _) => PotableAC.PortableACCommissioningModel1Step1();
              break;
            case Routes.PORTABLE_AC_WIFI_DESCRIPTION:
              builder = (BuildContext _) => PotableAC.PortableACCommissioningModel2Step1();
              break;
            case Routes.PORTABLE_AC_APPLIANCE_INFO:
              builder = (BuildContext _) => PotableAC.PortableACApplianceInfoPage();
              break;
            case Routes.PORTABLE_AC_APPLIANCE_PASSWORD:
              builder = (BuildContext _) => PotableAC.PortableACPasswordPage();
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