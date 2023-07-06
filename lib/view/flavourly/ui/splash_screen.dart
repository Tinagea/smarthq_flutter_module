import 'dart:async';
import 'package:smarthq_flutter_module/view/flavourly/common/app_bar.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/locale_util.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/text_styles.dart';
import 'package:smarthq_flutter_module/view/flavourly/constants/image_path.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/utils.dart';
import 'package:flutter/material.dart';

import '../../common/constant/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     Timer(Duration(seconds: 3), () {
       Navigator.of(context).pushNamed(Routes.FLAVOURLY_HOME_SCREEN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: LocaleUtil.APP_BAR_HEADING,
      ).setNavigationAppBar(context: context, leadingRequired: false, actionRequired: false),
      body: Container(
        decoration: BoxDecoration(color: Colors.black87),
        child: Stack(children: <Widget>[
          Utils.componentFullScreenImage(context, ImagePath.SPLASH_SCREEN_SIGN_IN_IMAGE),
          Positioned(
              bottom: 350,
              left: 20,
              child: Text(
                "Recipes",
                style: textStyle_size_custom_color_white_bold(fontSize: 91),
              )),
          Positioned(
              bottom: 290,
              left: 20,
              child: Text(
                "by Geneva",
                style: textStyle_size_custom_color_purple_semi_bold(fontSize: 38),
              )),
          Positioned(
              bottom: 160,
              left: 20,
              child: Text(
                "With artificial intelligence, let Geneva\n create a one of a kind recipe based\n on your ingredients and\n preferences",
                style: textStyle_size_custom_color_white(fontSize: 28),
              )),
        ]),
      ),
    );
  }
}
