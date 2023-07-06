
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/haier/ac_built_in_wifi_getting_started_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/haier/ac_appliance_password_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/haier/ac_locate_label_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/haier/ac_select_model_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/haier/ac_select_wifi_type_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/haier/ac_wifi_adapter_getting_started_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/haier/ac_wifi_adapter_enable_commissioning_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class HaierACNavigator extends StatelessWidget {
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
              builder = (BuildContext _) => CommonNavigatePage();
              break;
            case Routes.HAIER_AC_APPLIANCE_CHOOSE_MODEL_PAGE:
              builder = (BuildContext _) => AcSelectModelHaierPage();
              break;
            case Routes.HAIER_AC_APPLIANCE_WIFI_TYPE_SELECTION_PAGE:
              builder = (BuildContext _) => AcSelectWifiTypeHaierPage();
              break;
            case Routes.HAIER_AC_APPLIANCE_BUILT_IN_WIFI_DESCRIPTION_PAGE:
              builder = (BuildContext _) => AcBuildInWifiGettingStartedHaierPage();
              break;
            case Routes.HAIER_AC_APPLIANCE_USB_WIFI_DESCRIPTION_PAGE_ONE:
              builder = (BuildContext _) => AcWifiAdapterGettingStartedHaierPage();
              break;
            case Routes.HAIER_AC_APPLIANCE_USB_WIFI_DESCRIPTION_PAGE_TWO:
              builder = (BuildContext _) => AcWifiAdapterEnableCommissioningHaierPage();
              break;
            case Routes.HAIER_AC_APPLIANCE_INFO_PAGE:
              builder = (BuildContext _) => AcLocateLabelHaierPage();
              break;
            case Routes.HAIER_AC_APPLIANCE_PASSWORD_PAGE:
              builder = (BuildContext _) => AcAppliancePasswordHaierPage();
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