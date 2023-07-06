import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class PageWaterProductsSelectType extends StatefulWidget {
  PageWaterProductsSelectType({Key? key}) : super(key: key);

  _PageWaterProductsSelectType createState() => _PageWaterProductsSelectType();
}

class _PageWaterProductsSelectType extends State<PageWaterProductsSelectType>
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
    super.didUpdateWidget(oldWidget as PageWaterProductsSelectType);
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
              title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!
                  .toUpperCase(),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: true).pop();
              }).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: <Widget>[
                Component.componentApplianceVerticalListTile(context: context,
                    title: LocaleUtil.getString(
                        context, LocaleUtil.WHOLE_HOME_WATER_FILTER),
                    imagePath: ImagePath.WATER_FILTER_SELECTOR,
                    isLongIcon: true,
                    iconWidth: 80.w,
                    clickedFunction: () {
                      Navigator.pushNamed(
                          context, Routes.WATER_FILTER_DESCRIPTION);
                    }),
                Component.componentApplianceVerticalListTile(context: context,
                    title: LocaleUtil.getString(
                        context, LocaleUtil.HOUSEHOLD_WATER_SOFTENER),
                    imagePath: ImagePath.WATER_SOFTENER_SELECTOR,
                    isLongIcon: true,
                    iconWidth: 80.w,
                    clickedFunction: () {
                      Navigator.pushNamed(
                          context, Routes.WATER_SOFTENER_DESCRIPTION);
                    }),
                Component.componentApplianceVerticalListTile(context: context,
                    title: LocaleUtil.getString(
                        context, LocaleUtil.WATER_HEATER),
                    imagePath: ImagePath.WATER_HEATER_SELECTOR,
                    isLongIcon: true,
                    iconWidth: 80.w,
                    clickedFunction: () {
                      Navigator.pushNamed(
                          context, Routes.WATER_HEATER_DESCRIPTION);
                    }),
              ],
            ),
          )),
    );
  }
}