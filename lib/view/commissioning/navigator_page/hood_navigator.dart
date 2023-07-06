import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hood/hood_select_type_page.dart' as Hood;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hood/hood_wifi_pairing_getting_started_page.dart' as Hood;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hood/hood_low_getting_started_page.dart' as Hood;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hood/hood_wifi_pairing_appliance_password_page.dart' as Hood;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/hood/hood_appliance_password_page.dart' as Hood;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class HoodNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.HOOD_MODEL_SELECT,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.HOOD_MODEL_SELECT:
              builder = (BuildContext _) => Hood.PageHoodSelectOption();
              break;
            case Routes.HOOD_DESCRIPTION2_MODEL1:
              builder = (BuildContext _) => Hood.HoodCommissioningModel1Step2();
              break;
            case Routes.HOOD_DESCRIPTION2_MODEL2:
              builder = (BuildContext _) => Hood.HoodCommissioningModel2Step2();
              break;
            case Routes.HOOD_DESCRIPTION3_MODEL1:
              builder = (BuildContext _) => Hood.HoodCommissioningModel1Step3();
              break;
            case Routes.HOOD_COMMISSIONING_ENTER_PASSWORD:
              builder = (BuildContext _) => Hood.HoodEnterPasswordStep();
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