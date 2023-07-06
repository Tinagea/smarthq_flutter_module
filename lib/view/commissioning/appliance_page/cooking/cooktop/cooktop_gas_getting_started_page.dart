import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class PageCooktopGasDescription extends StatefulWidget {
  @override
  State createState() => _PageCooktopGasDescription();
}


class _PageCooktopGasDescription extends State<PageCooktopGasDescription> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                        BaseComponent.heightSpace(40.h),
                        Component.componentMainImage(context,
                            ImagePath.COOKTOP_GAS_DESCRIPTION),
                        BaseComponent.heightSpace(40.h),
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
                                      LocaleUtil.COOKTOP_GAS_DESCRIPTION_TEXT_1),
                                  style: textStyle_size_18_color_white()),
                              TextSpan(
                                  text: LocaleUtil.getString(context,
                                      LocaleUtil.COOKTOP_GAS_DESCRIPTION_TEXT_2),
                                  style: textStyle_size_18_color_yellow()),
                              TextSpan(
                                  text: LocaleUtil.getString(context,
                                      LocaleUtil.COOKTOP_GAS_DESCRIPTION_TEXT_3),
                                  style: textStyle_size_18_color_white()),
                              TextSpan(
                                  text: LocaleUtil.getString(context,
                                      LocaleUtil.COOKTOP_GAS_DESCRIPTION_TEXT_4),
                                  style: textStyle_size_18_color_yellow()),
                              TextSpan(
                                  text: LocaleUtil.getString(context,
                                      LocaleUtil.COOKTOP_GAS_DESCRIPTION_TEXT_5),
                                  style: textStyle_size_18_color_white()),
                            ],
                            marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
                        BaseComponent.heightSpace(16.h),

                      ],
                    ),
                  ),
                  BlocBuilder<CommissioningCubit, CommissioningState>(
                      bloc: BlocProvider.of<CommissioningCubit>(context),
                      buildWhen: (previous, current) {
                        return (current.stateType ==
                            CommissioningStateType.APT ||
                            current.stateType ==
                                CommissioningStateType.INITIAL);
                      },
                      builder: (context, state) {
                        return Component.componentBottomButton(
                            title:
                            LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                            isEnabled:
                            state.isReceiveApplianceProvisioningToken ==
                                null
                                ? false
                                : state.isReceiveApplianceProvisioningToken!,
                            onTapButton: () {
                              Navigator.of(context).pushNamed(Routes.COOKTOP_GAS_STEP_2);
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
    });
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
    if (state == AppLifecycleState.resumed) {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    }
  }
}
