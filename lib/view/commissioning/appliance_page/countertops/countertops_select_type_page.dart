import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class PageCounterTopApplianceSelectDisplay extends StatefulWidget {
  PageCounterTopApplianceSelectDisplay({Key? key}) : super(key: key);

  _PageCounterTopApplianceSelectDisplay createState() =>
      _PageCounterTopApplianceSelectDisplay();
}

class _PageCounterTopApplianceSelectDisplay
    extends State<PageCounterTopApplianceSelectDisplay>
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
    super.didUpdateWidget(oldWidget as PageCounterTopApplianceSelectDisplay);
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
              title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
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
                  title: LocaleUtil.getString(context, LocaleUtil.DRIP_COFFEE_MAKER)!,
                  imagePath: ImagePath.COUNTERTOP_COFFEEMAKER,
                  clickedFunction: () {
                    Navigator.pushNamed(
                      context, Routes.BREW_APPLIANCE_SELECTION_PAGE,
                    );
                  }
                ),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.ESPRESSO_MACHINE)!,
                    imagePath: ImagePath.COUNTERTOP_ESPRESSO,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.ESPRESSO_SELECT_NAVIGATOR,
                      );
                    }
                ),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.OPAL_NUGGET_ICE_MAKER)!,
                    imagePath: ImagePath.COUNTERTOP_OPAL_NUGGET,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.OPAL_MAIN_NAVIGATOR,
                      );
                    }
                ),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER)!,
                    imagePath: ImagePath.COUNTERTOP_STAND_MIXER,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.STAND_MIXER_MAIN_NAVIGATOR,
                      );
                    }
                ),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.COUNTER_TOP_TOASTER_OVEN)!,
                    imagePath: ImagePath.COUNTERTOP_TOASTER_OVEN,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.TOASTER_OVEN_SELECT_NAVIGATOR,
                      );
                    }
                ),
              ],
            ),
          )),
    );
  }
}
