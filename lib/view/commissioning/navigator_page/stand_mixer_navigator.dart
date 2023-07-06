/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/stand_mixer/stand_mixer_getting_started_page.dart' as StandMixer;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/stand_mixer/stand_mixer_locate_label_page.dart' as StandMixer;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/stand_mixer/stand_mixer_appliance_password_page.dart' as StandMixer;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class StandMixerNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.STAND_MIXER_COMMISSIONING_STEP_1_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.STAND_MIXER_COMMISSIONING_STEP_1_PAGE:
              builder = (BuildContext _) => StandMixer.StandMixerCommissioningStep1Page();
              break;
            case Routes.STAND_MIXER_COMMISSIONING_STEP_2_PAGE:
              builder = (BuildContext _) => StandMixer.StandMixerCommissioningStep2Page();
              break;
            case Routes.STAND_MIXER_COMMISSIONING_ENTER_PASSWORD_STEP_PAGE:
              builder = (BuildContext _) => StandMixer.StandMixerEnterPasswordStepPage();
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