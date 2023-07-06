import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_haier_knob_locate_label_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_haier_knob_getting_started_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_haier_knob_appliance_password_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_lcd_locate_label_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_lcd_getting_started_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_lcd_appliance_password_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_pro_range_getting_started_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_pro_range_appliance_password_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_remote_enable_getting_started_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_remote_enable_locate_label_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_remote_enable_appliance_password_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_select_type_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_settings_getting_started_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_select_button_type_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_common_locate_label_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_common_appliance_password_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_wifi_connect_getting_started_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_navigate_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_lcd_follow_appliance_instruction_page.dart' as Range;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/Range/range_lcd_select_type_page.dart' as Range;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class RangeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.RANGE_NAVIGATE_PAGE,
        onGenerateRoute: (RouteSettings routeSettings) {
          WidgetBuilder builder;
          switch (routeSettings.name) {
            case Routes.RANGE_NAVIGATE_PAGE:
              builder = (BuildContext _) => Range.RangeNavigatePage();
              break;
            case Routes.RANGE_SELECT:
              builder = (BuildContext _) => Range.PageRangeSelectType();
              break;
            case Routes.RANGE_LCD_DESCRIPTION:
              builder = (BuildContext _) => Range.RangeLcdDescription();
              break;
            case Routes.RANGE_LCD_APPLIANCE_INFO:
              builder = (BuildContext _) => Range.RangeLcdApplianceInfo();
              break;
            case Routes.RANGE_LCD_SELECT_TYPE_PAGE:
              builder = (BuildContext _) => Range.RangeLcdSelectTypePage();
              break;
            case Routes.RANGE_LCD_FOLLOW_APPLIANCE_INSTRUCTION_PAGE:
              builder = (BuildContext _) => Range.RangeLcdFollowApplianceInstructionPage();
              break;
            case Routes.RANGE_LCD_PASSWORD_INFO:
              builder = (BuildContext _) => Range.RangeLcdPasswordInfo(isFirstTimeShown: true);
              break;
            case Routes.RANGE_LCD_PASSWORD_INFO_2:
              builder = (BuildContext _) => Range.RangeLcdPasswordInfo(isFirstTimeShown: false);
              break;
            case Routes.RANGE_HAIER_KNOB_DESCRIPTION:
              builder = (BuildContext _) => Range.RangeHairAppKnobDescription();
              break;
            case Routes.RANGE_PRO_RANGE_DESCRIPTION:
              builder = (BuildContext _) => Range.RangeProRangeDescription();
              break;
            case Routes.RANGE_TOUCH_BUTTONS_SELECTION_TYPE:
              builder = (BuildContext _) => Range.PageRangeTouchButtonsSelectType();
              break;
            case Routes.RANGE_REMOTE_ENABLE_DESCRIPTION:
              builder = (BuildContext _) => Range.RangeRemoteEnableDescription();
              break;
            case Routes.RANGE_WIFI_CONNECT_DESCRIPTION:
              builder = (BuildContext _) => Range.RangeWifiConnectDescription();
              break;
            case Routes.RANGE_SETTINGS_DESCRIPTION:
              builder = (BuildContext _) => Range.RangeSettingsDescription();
              break;
            case Routes.RANGE_HAIER_KNOB_APPLIANCE_INFO:
              builder = (BuildContext _) => Range.RangeHairAppKnobApplianceInfo();
              break;
            case Routes.RANGE_HAIER_KNOB_APPLIANCE_PASSWORD_INFO:
              builder = (BuildContext _) => Range.RangeHairAppKnobPasswordInfo();
              break;
            case Routes.RANGE_PRO_RANGE_PASSWORD_INFO:
              builder = (BuildContext _) => Range.RangeProRangePasswordInfo();
              break;
            case Routes.RANGE_TYPE_TWO_COMMON_APPLIANCE_INFO:
              builder = (BuildContext _) => Range.RangeTypeTwoCommonApplianceInfo();
              break;
            case Routes.RANGE_REMOTE_ENABLE_APPLIANCE_INFO:
              builder = (BuildContext _) => Range.RangeTypeTwoRemoteEnabledApplianceInfo();
              break;
            case Routes.RANGE_TYPE_TWO_COMMON_PASSWORD_INFO:
              builder = (BuildContext _) => Range.RangeTypeTwoCommonPasswordInfo();
              break;
            case Routes.RANGE_REMOTE_ENABLE_PASSWORD_PAGE:
              builder = (BuildContext _) => Range.PagePasswordRangeRemoteEnable();
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
