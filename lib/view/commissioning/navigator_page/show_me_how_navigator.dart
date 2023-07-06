import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphone_container_page.dart' as ShowMeHow;
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphonex_container_page.dart' as ShowMeHow;
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/android/show_me_how_android_container_page.dart' as ShowMeHow;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class ShowMeHowNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String showMeHowRoute = Routes.SHOW_ME_HOW_MAIN_ANDROID;
    if (Platform.isIOS) {
      if (MediaQuery.of(context).viewPadding.bottom > 0) {
        showMeHowRoute = Routes.SHOW_ME_HOW_MAIN_IPHONEX;
      } else {
        showMeHowRoute = Routes.SHOW_ME_HOW_MAIN_IPHONE;
      }
    }
    return Navigator(
      initialRoute: showMeHowRoute,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case Routes.SHOW_ME_HOW_MAIN_IPHONE:
            builder = (BuildContext _) => ShowMeHow.ShowMeHowIphoneMain();
            break;
          case Routes.SHOW_ME_HOW_MAIN_IPHONEX:
            builder = (BuildContext _) => ShowMeHow.ShowMeHowIphoneXMain();
            break;
          case Routes.SHOW_ME_HOW_MAIN_ANDROID:
            builder = (BuildContext _) => ShowMeHow.ShowMeHowAndroidMain();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}