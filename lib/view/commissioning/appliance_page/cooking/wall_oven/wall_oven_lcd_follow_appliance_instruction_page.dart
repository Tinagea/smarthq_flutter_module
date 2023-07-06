import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenPrimaryTypeOnePage3 extends StatefulWidget {
  @override
  _WallOvenPrimaryTypeOnePage1 createState() => _WallOvenPrimaryTypeOnePage1();
}

class _WallOvenPrimaryTypeOnePage1 extends State<WallOvenPrimaryTypeOnePage3> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
      ).setNavigationAppBar(context: context),
      body: Component.componentCommissioningBody(
        context,
        <Widget>[
          BleBlockListener.handleBlePairing(context: context),
          CustomRichText.addWifiTextBox(
            spanStringList: [
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_1_PRIMARY_DESC_14),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_1_PRIMARY_DESC_15),
                  style: textStyle_size_18_color_yellow()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_1_PRIMARY_DESC_16),
                  style: textStyle_size_18_color_white()),
            ],
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          BaseComponent.heightSpace(16.h)
        ],
        Component.componentBottomButton(
            title: LocaleUtil.getString(context, LocaleUtil.BACK_TO_HOME)!,
            isEnabled: true,
            onTapButton: () {
              BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
              Navigator.of(context, rootNavigator: true).pop();
            }),
      ),
    );
  }
}
