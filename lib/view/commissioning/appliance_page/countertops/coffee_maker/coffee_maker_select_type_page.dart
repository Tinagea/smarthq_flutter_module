import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class PageBrewApplianceSelectDisplay extends StatefulWidget {
  PageBrewApplianceSelectDisplay({Key? key}) : super(key: key);

  _PageBrewApplianceSelectDisplay createState() =>
      _PageBrewApplianceSelectDisplay();
}

class _PageBrewApplianceSelectDisplay
    extends State<PageBrewApplianceSelectDisplay>
    with WidgetsBindingObserver {
  var cont = 0;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget as PageBrewApplianceSelectDisplay);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: true).pop();
              }).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: <Widget>[
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.COFFEE_BREWER)!,
                    imagePath: ImagePath.COUNTERTOP_COFFEEMAKER,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.COFFEEMAKER_MAIN_NAVIGATOR,
                      );
                    }),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW)!,
                    imagePath: ImagePath.COUNTERTOP_GRIND_BREW,
                    clickedFunction: () {
                      globals.subRouteName = Routes.GRIND_BREW_DESCRIPTION_MODEL;
                      Navigator.pushNamed(
                        context, Routes.GRIND_BREW_MAIN_NAVIGATOR,
                      );
                    }),
              ],
            ),
          )
      ),
    );
  }
}
