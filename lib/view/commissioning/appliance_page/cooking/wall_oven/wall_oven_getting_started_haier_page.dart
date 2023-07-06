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
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenGettingStartedHaierPage extends StatefulWidget {
  const WallOvenGettingStartedHaierPage({Key? key}) : super(key: key);

  @override
  State<WallOvenGettingStartedHaierPage> createState() => _WallOvenGettingStartedHaierPageState();
}

class _WallOvenGettingStartedHaierPageState extends State<WallOvenGettingStartedHaierPage> with WidgetsBindingObserver {

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
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
      ).setNavigationAppBar(context: context),
      body: ListView(
        children: [
          BaseComponent.heightSpace(16.h),
          Text(
            LocaleUtil.getString(
                context, LocaleUtil.THIS_IS_YOUR_CONTROL_PANEL)!,
            style: textStyle_size_12_white_50_opacity(),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Component.componentMainImage(
                context, ImagePath.COOKING_WALL_OVEN_HAIER_MODEL_1_DISPLAY_SVG),
          ),
          Component.pageIndicator(3, 0, size: 8),
          BaseComponent.heightSpace(16.h),
          Divider(height: 1.h, color: colorDeepDarkCharcoal()),
          BaseComponent.heightSpace(16.h),
          Center(
            child: Component.componentTitleText(
                title: LocaleUtil.getString(context, LocaleUtil.LETS_GET_STARTED)!
                    .toUpperCase(),
                marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
          ),
          BaseComponent.heightSpace(16.h),
          CustomRichText.addWifiTextBoxCentered(
            spanStringList: [
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_1_PART_1),
                style: textStyle_size_18_color_white(),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context, LocaleUtil.COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_1_PART_2),
                style: textStyle_size_18_color_white_50_opacity(),
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
                isEnabled: state.isReceiveApplianceProvisioningToken == true,
                title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                onTapButton: () {
                  Navigator.of(context)
                      .pushNamed(Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_2);
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

