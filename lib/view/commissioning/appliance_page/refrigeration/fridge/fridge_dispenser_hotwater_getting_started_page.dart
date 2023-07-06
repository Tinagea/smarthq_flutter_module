import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class DispenserCommissioningModel1Step1 extends StatefulWidget {

  @override
  State createState() => _DispenserCommissioningModel1Step1();

}


class _DispenserCommissioningModel1Step1 extends State<DispenserCommissioningModel1Step1> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
              .setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(context,
                            ImagePath.DISPENSER_TOP_CONTROLLER1_COLOR),
                        BaseComponent.heightSpace(16.h),
                        Component.componentTitleText(
                            title: LocaleUtil.getString(
                                context, LocaleUtil.LETS_GET_STARTED)!
                                .toUpperCase(),
                            marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(16.h),
                        Component.componentDescriptionText(
                          text: LocaleUtil.getString(context,
                              LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_1)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                        ),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(context,
                                    LocaleUtil.DISPENSER_MODEL1_INSTRUCTION1),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: LocaleUtil.getString(context,
                                    LocaleUtil.SETTINGS),
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(
                                text: LocaleUtil.getString(context,
                                    LocaleUtil.DISPENSER_MODEL1_INSTRUCTION2),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: 'WiFi',
                                style: textStyle_size_18_color_yellow()),
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                        Component.componentDescriptionTextWithLinkLabel(
                          contents: LocaleUtil.getString(
                              context, LocaleUtil.WIFI_NOT_SELECTABLE)!,
                          contentsForLink: LocaleUtil.getString(
                              context, LocaleUtil.CONNECT_PLUS)!,
                          link: LocaleUtil.getString(
                              context, LocaleUtil.CONNECT_PLUS_HOW_TO_URL)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 29.w),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CommissioningCubit, CommissioningState>(
                      bloc: BlocProvider.of<CommissioningCubit>(context),
                      buildWhen: (previous, current) {
                        return (current.stateType == CommissioningStateType.APT ||
                            current.stateType == CommissioningStateType.INITIAL);
                      },
                      builder: (context, state) {
                        return Component.componentBottomButton(
                            title:
                            LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                            isEnabled: state.isReceiveApplianceProvisioningToken == null
                                ? false : state.isReceiveApplianceProvisioningToken!,
                            onTapButton: () {
                              geaLog.debug("DispenserCommissioningModel1Step1 on tap");
                              Navigator.of(context).pushNamed(Routes.DISPENSER_DESCRIPTION3_MODEL1);
                            });
                      })
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero, () {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
      BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent))
      return;

    geaLog.debug('AppLifecycleState: $state}');
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    }
  }
}
