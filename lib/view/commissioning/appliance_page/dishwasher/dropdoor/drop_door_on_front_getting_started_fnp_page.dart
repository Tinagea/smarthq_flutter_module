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
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class DropDoorGettingStartedFnpPage extends StatefulWidget {
  const DropDoorGettingStartedFnpPage({Key? key}) : super(key: key);

  @override
  State<DropDoorGettingStartedFnpPage> createState() => _DropDoorGettingStartedFnpPageState();
}

class _DropDoorGettingStartedFnpPageState extends State<DropDoorGettingStartedFnpPage> with WidgetsBindingObserver {
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

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent)) return;

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
    return Component.componentBaseContent(
      context: context,
      title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
      innerContent: _InnerContent(),
      footerContent: _FooterContent(),
    );
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Component.componentMainImage(context, ImagePath.DROP_DOOR_INSIDE_TOP_CONTROL_STEP_1_SVG),
        ),
        BaseComponent.heightSpace(16.h),
        Divider(thickness: 1.h, height: 1.h, color: colorDeepDarkCharcoal()),
        BaseComponent.heightSpace(24.h),
        Component.componentTitleText(
          title: LocaleUtil.getString(context, LocaleUtil.LETS_GET_STARTED)!.toUpperCase(),
          marginInsets: EdgeInsets.symmetric(horizontal: 15.w),
        ),
        Component.componentDescriptionText(
          text: LocaleUtil.getString(context, LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_1)!,
          marginInsets: EdgeInsets.symmetric(horizontal: 15.w),
        ),
        BaseComponent.heightSpace(16.h),
        CustomRichText.addWifiTextBox(
          spanStringList: [
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DROP_DOOR_FNP_INSTRUCTION_1_PART_1),
              style: textStyle_size_18_color_white(),
            ),
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DROP_DOOR_FNP_INSTRUCTION_1_PART_2),
              style: textStyle_size_18_color_yellow(),
            ),
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DROP_DOOR_FNP_INSTRUCTION_1_PART_3),
              style: textStyle_size_18_color_white(),
            ),
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DROP_DOOR_FNP_INSTRUCTION_1_PART_4),
              style: textStyle_size_18_color_yellow(),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: SvgPicture.asset(
                ImagePath.DISHWASHER_START_ICON,
                height: 16,
              ),
            ),
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DROP_DOOR_FNP_INSTRUCTION_1_PART_5),
              style: textStyle_size_18_color_white(),
            ),
            WidgetSpan(
              child: Icon(
                Icons.wifi,
                size: 24,
                color: colorSelectiveYellow(),
              ),
            ),
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DROP_DOOR_FNP_INSTRUCTION_1_PART_6),
              style: textStyle_size_18_color_white(),
            ),
          ],
        ),
      ],
    );
  }
}

class _FooterContent extends StatelessWidget {
  const _FooterContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommissioningCubit, CommissioningState>(
      bloc: BlocProvider.of<CommissioningCubit>(context),
      buildWhen: (previous, current) {
        return (current.stateType == CommissioningStateType.APT);
      },
      builder: (context, state) {
        return Component.componentBottomButton(
          title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
          isEnabled: state.isReceiveApplianceProvisioningToken == true,
          onTapButton: () {
            Navigator.of(context).pushNamed(Routes.DROP_DOOR_FNP_STEP2);
          },
        );
      },
    );
  }
}
