/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class RangeGettingStartedFnpPage extends StatefulWidget {
  const RangeGettingStartedFnpPage({Key? key}) : super(key: key);

  @override
  State<RangeGettingStartedFnpPage> createState() => _RangeGettingStartedFnpPageState();
}

class _RangeGettingStartedFnpPageState extends State<RangeGettingStartedFnpPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    var cubit = BlocProvider.of<CommissioningCubit>(context);
    cubit.initState();
    cubit.actionRequestApplicationProvisioningToken();
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

    if (state == AppLifecycleState.resumed) {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!,
        leftBtnFunction: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
      ).setNavigationAppBar(context: context),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(32.w),
            child: Component.componentMainImage(
                context, ImagePath.COOKING_RANGE_FNP_MODEL_1_DISPLAY),
          ),
          BaseComponent.heightSpace(16.h),
          CustomRichText.addWifiTextBox(
            spanStringList: [
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_1),
                style: textStyle_size_18_color_white(),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_2),
                style: textStyle_size_18_color_yellow(),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.menu,
                  size: 20,
                  color: const Color(0xffffbb00),
                ),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_3),
                style: textStyle_size_18_color_white(),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_4),
                style: textStyle_size_18_color_yellow(),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_5),
                style: textStyle_size_18_color_white(),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_6),
                style: textStyle_size_18_color_yellow(),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_7),
                style: textStyle_size_18_color_white(),
              ),
            ],
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          BaseComponent.heightSpace(16.h),
          BlocBuilder<CommissioningCubit, CommissioningState>(
            bloc: BlocProvider.of<CommissioningCubit>(context),
            buildWhen: (previous, current) {
              return (current.stateType == CommissioningStateType.APT);
            },
            builder: (context, state) {
              return Component.componentBottomButton(
                isEnabled: state.isReceiveApplianceProvisioningToken == null
                    ? false
                    : state.isReceiveApplianceProvisioningToken!,
                title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                onTapButton: () {
                  Navigator.of(context)
                      .pushNamed(Routes.RANGE_FNP_ENTER_PASSWORD);
                },
              );
            },
          ),
          BaseComponent.heightSpace(20.h),
        ],
      ),
    );
  }
}
