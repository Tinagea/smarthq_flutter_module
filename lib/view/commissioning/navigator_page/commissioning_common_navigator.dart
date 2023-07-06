import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_choose_home_network_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_choose_home_network_list_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_other_network_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_something_wrong_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_something_wrong_relaunch_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_something_wrong_retry_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_success_detail_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_success_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_wifi_connection_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_wrong_password_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_communication_cloud_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_connect_saved_network_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_edit_saved_network_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_wrong_network_password_page.dart' as Common;
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_saved_network_list_page.dart' as Common;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class CommissioningCommonNavigator extends StatelessWidget {
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
            case Routes.COMMON_MAIN_WRONG_PAGE:
              builder = (BuildContext _) => Common.CommissioningSomethingWrongPage();
              break;
            case Routes.COMMON_MAIN_WRONG_RELAUNCH_PAGE:
              builder = (BuildContext _) => Common.CommissioningSomethingWrongRelaunchPage();
              break;
            case Routes.COMMON_MAIN_WRONG_RETRY_PAGE:
              builder = (BuildContext _) => Common.CommissioningSomethingWrongRetryPage();
              break;
            case Routes.COMMON_MAIN_SUCCESS_DETAIL_PAGE:
              builder = (BuildContext _) => Common.CommissioningSuccessDetailPage();
              break;
            case Routes.COMMON_MAIN_SUCCESS_PAGE:
              builder = (BuildContext _) => Common.CommissioningSuccessPage();
              break;
            case Routes.COMMON_COMMUNICATION_CLOUD_PAGE:
              builder = (BuildContext _) => Common.CommissioningCommunicationCloudPage();
              break;
            case Routes.COMMON_CHOOSE_HOME_NETWORK_PAGE:
              builder = (BuildContext _) => Common.CommissioningChooseHomeNetwork();
              break;
            case Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE:
              builder = (BuildContext _) => Common.CommissioningChooseHomeNetworkList();
              break;
            case Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE:
              builder = (BuildContext _) => Common.CommissioningWifiConnectionPage();
              break;
            case Routes.COMMON_WRONG_PASSWORD_PAGE:
              builder = (BuildContext _) => Common.CommissioningWrongPassword();
              break;
            case Routes.COMMON_ADD_OTHER_NETWORK_PAGE:
              builder = (BuildContext _) => Common.CommissioningAddOtherNetwork();
              break;
            case Routes.COMMON_WRONG_NETWORK_PASSWORD_PAGE:
              builder = (BuildContext _) => Common.CommissioningWrongNetworkPassword();
              break;
            case Routes.COMMON_CONNECTING_SAVED_NETWORK:
              builder = (BuildContext _) => Common.CommissioningConnectSavedNetworkPage();
              break;
            case Routes.COMMON_EDIT_SAVED_NETWORK_PAGE:
              builder = (BuildContext _) => Common.CommissioningEditSavedNetwork();
              break;
            case Routes.COMMON_SAVED_NETWORK_LIST:
              builder = (BuildContext _) => Common.CommissioningSavedNetworkList();
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