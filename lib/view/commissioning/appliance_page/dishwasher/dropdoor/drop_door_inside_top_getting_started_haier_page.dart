/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class DropDoorInsideTopGettingStartedHaierPage extends StatefulWidget {
  const DropDoorInsideTopGettingStartedHaierPage({Key? key}) : super(key: key);

  @override
  State<DropDoorInsideTopGettingStartedHaierPage> createState() =>
      _DropDoorInsideTopGettingStartedHaierPageState();
}

class _DropDoorInsideTopGettingStartedHaierPageState
    extends State<DropDoorInsideTopGettingStartedHaierPage>
    with WidgetsBindingObserver {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
            .toUpperCase(),
        leftBtnFunction: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
      ).setNavigationAppBar(context: context),
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: IntrinsicHeight(child: _InnerContent()),
            ),
          );
        },
      ),
    );
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Text(
            LocaleUtil.getString(
                context, LocaleUtil.THIS_IS_YOUR_CONTROL_PANEL)!,
            style: textStyle_size_12_white_50_opacity(),
            textAlign: TextAlign.center,
          ),
          height: 36.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
          child: SvgPicture.asset(
            ImagePath.DROP_DOOR_INSIDE_TOP_CONTROL_HAIER_STEP_1,
          ),
        ),
        Component.pageIndicator(3, 0, size: 6.w),
        BaseComponent.heightSpace(16.h),
        Divider(thickness: 1.h, height: 1.h, color: colorDeepDarkCharcoal()),
        BaseComponent.heightSpace(24.h),
        Component.componentTitleText(
            title: LocaleUtil.getString(context, LocaleUtil.LETS_GET_STARTED)!
                .toUpperCase(),
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: CustomRichText.addWifiTextBoxCentered(
            spanStringList: [
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_1_PART_1),
                style: textStyle_size_18_color_white(),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_1_PART_2),
                style: textStyle_size_18_color_white_50_opacity(),
              ),
            ],
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        ),
        Spacer(),
        BlocBuilder<CommissioningCubit, CommissioningState>(
          bloc: BlocProvider.of<CommissioningCubit>(context),
          buildWhen: (previous, current) {
            return (current.stateType == CommissioningStateType.APT);
          },
          builder: (context, state) {
            return Component.componentBottomButton(
              title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
              isEnabled: state.isReceiveApplianceProvisioningToken == true,
              onTapButton: () {
                Navigator.of(context)
                    .pushNamed(Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP2);
              },
            );
          },
        ),
        BaseComponent.heightSpace(20.h),
      ],
    );
  }
}
