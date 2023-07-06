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
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class FridgeInTheMiddleGettingStartedFnpPage extends StatefulWidget {
  const FridgeInTheMiddleGettingStartedFnpPage({Key? key}) : super(key: key);

  @override
  State<FridgeInTheMiddleGettingStartedFnpPage> createState() => _FridgeInTheMiddleGettingStartedFnpPageState();
}

class _FridgeInTheMiddleGettingStartedFnpPageState extends State<FridgeInTheMiddleGettingStartedFnpPage>
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
        title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
        leftBtnFunction: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ).setNavigationAppBar(context: context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Component.componentMainImageDynamicSize(
                      context: context,
                      imagePath: ImagePath.IN_THE_MIDDLE_INSTRUCTION_1,
                      padding: EdgeInsets.symmetric(horizontal: 64.w)),
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
                  BaseComponent.heightSpace(32.h),
                  CustomRichText.addWifiTextBox(
                    spanStringList: [
                      TextSpan(
                        text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .IN_THE_MIDDLE_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_1),
                        style: textStyle_size_18_color_white(),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child:
                            SvgPicture.asset(ImagePath.LOCK_ICON, height: 16),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .IN_THE_MIDDLE_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_2),
                        style: textStyle_size_18_color_white(),
                      )
                    ],
                    marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  BaseComponent.heightSpace(16.h),
                ],
              ),
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
                isEnabled: state.isReceiveApplianceProvisioningToken == null
                    ? false
                    : state.isReceiveApplianceProvisioningToken!,
                title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                onTapButton: () {
                  Navigator.of(context).pushNamed(Routes.IN_THE_MIDDLE_STEP2);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
