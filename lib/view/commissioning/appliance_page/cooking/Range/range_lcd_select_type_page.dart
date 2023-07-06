/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class RangeLcdSelectTypePage extends StatefulWidget {
  RangeLcdSelectTypePage({Key? key}) : super(key: key);

  _RangeLcdSelectTypePage createState() => _RangeLcdSelectTypePage();
}

class _RangeLcdSelectTypePage extends State<RangeLcdSelectTypePage>
    with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {}
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
    super.didUpdateWidget(oldWidget as RangeLcdSelectTypePage);
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
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 36.h,
              children: <Widget>[
                BleBlockListener.handleBlePairing(context: context),
                Component.componentApplianceSelectTypeTitle(title: LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_TYPE_1_PRIMARY_DESC_25)!),
                Component.componentMainSelectImageButtonWithoutBox(
                    context: context,
                    pushName: Routes.RANGE_LCD_PASSWORD_INFO_2,
                    imageName: ImagePath.WALL_OVEN_TYPE_PRIMARY_1_PAGE_2_TYPE_1),
                Component.componentMainSelectImageButtonWithoutBox(
                    context: context,
                    pushName: Routes.RANGE_LCD_FOLLOW_APPLIANCE_INSTRUCTION_PAGE,
                    imageName: ImagePath.WALL_OVEN_TYPE_PRIMARY_1_PAGE_2_TYPE_2),
              ],
            ),
          )),
    );
  }
}
