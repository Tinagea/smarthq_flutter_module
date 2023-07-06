/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenModel2GettingStartedFnpPage extends StatefulWidget {
  @override
  State createState() => _WallOvenModel2GettingStartedFnpPageState();
}

class _WallOvenModel2GettingStartedFnpPageState
    extends State<WallOvenModel2GettingStartedFnpPage>
    with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
                  title:
                      LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
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
                            ImagePath.COOKING_WALL_OVEN_FNP_MODEL2_GETTING_STARTED),
                        BaseComponent.heightSpace(16.h),
                        Component.componentTitleText(
                            title: LocaleUtil.getString(
                                    context, LocaleUtil.LETS_GET_STARTED)!
                                .toUpperCase(),
                            marginInsets:
                                EdgeInsets.symmetric(horizontal: 28.w),
                            alignText: TextAlign.left),
                        BaseComponent.heightSpace(10.h),
                        Component.componentDescriptionText(
                            text: LocaleUtil.getString(
                                context,
                                LocaleUtil
                                    .CONNECTED_PLUS_DESCRIPTION_1_TEXT_1)!,
                            marginInsets:
                                EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(38.h),
                        CustomRichText.addWifiTextBox(
                            spanStringList: [
                              TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .TOUCH_YOUR_DISPLAY_TO_WAKE_IT_UP),
                                style: textStyle_size_18_color_white(),
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.menu,
                                  size: 24,
                                  color: const Color(0xffffbb00),
                                ),
                              ),
                              TextSpan(
                                text: LocaleUtil.getString(context,
                                    LocaleUtil.SELECT_SETTINGS_AND_GO_TO),
                                style: textStyle_size_18_color_white(),
                              ),
                              TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.WI_FI_CONNECT),
                                style: textStyle_size_18_color_yellow(),
                              ),
                              TextSpan(
                                text: ".",
                                style: textStyle_size_18_color_white(),
                              ),
                            ],
                            marginInsets:
                                EdgeInsets.symmetric(horizontal: 16.w),
                            alignText: TextAlign.left),
                        // BaseComponent.heightSpace(6.h),
                      ],
                    ),
                  ),
                  Component.pageIndicator(4, 0, size: 15.h, spacing: 6.w),
                  BaseComponent.heightSpace(6.h),
                  BlocBuilder<CommissioningCubit, CommissioningState>(
                      bloc: BlocProvider.of<CommissioningCubit>(context),
                      buildWhen: (previous, current) {
                        return (current.stateType == CommissioningStateType.APT ||
                            current.stateType == CommissioningStateType.INITIAL);
                      },
                      builder: (context, state) {
                        return Component.componentBottomButton(
                            isEnabled: state.isReceiveApplianceProvisioningToken == null ? false : state.isReceiveApplianceProvisioningToken!,
                            title:
                                LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                            onTapButton: () {
                              Navigator.of(context).pushNamed(Routes
                                  .WALL_OVEN_MODEL_2_STEP_2_FNP);
                            });
                      })
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero, () {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
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
