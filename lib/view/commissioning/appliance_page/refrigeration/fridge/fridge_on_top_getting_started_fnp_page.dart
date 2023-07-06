import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class FridgeOnTopGettingStartedFnpPage extends StatefulWidget {
  @override
  State createState() => _OnTopCommissioningFnPModel3Step1();
}

class _OnTopCommissioningFnPModel3Step1
    extends State<FridgeOnTopGettingStartedFnpPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
            leftBtnFunction: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }).setNavigationAppBar(context: context),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Component.componentMainImageDynamicSize(
                        context: context,
                        imagePath: ImagePath.ONTOP_MAIN_FNP_MODEL3,
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.w, vertical: 64.h)),
                    Component.componentTitleText(
                      title: LocaleUtil.getString(
                          context, LocaleUtil.LETS_GET_STARTED)!
                          .toUpperCase(),
                      marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                      alignText: TextAlign.left
                    ),
                    BaseComponent.heightSpace(10.h),
                    Component.componentDescriptionText(
                      text: LocaleUtil.getString(context,
                          LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_1)!,
                      marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                    ),
                    BaseComponent.heightSpace(10.h),
                    CustomRichText.addWifiTextBox(
                      spanStringList: [
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_1,
                          ),
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_2,
                          ),
                            style: textStyle_size_18_color_yellow()
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            ImagePath.ONTOP_MENU_ICON,
                          ),
                        ),
                        TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_3,
                            ),
                        ),
                        TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_4,
                            ),
                            style: textStyle_size_18_color_yellow()
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_5,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            ImagePath.ONTOP_CONFIRM_ICON,
                          ),
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_6,
                          ),
                        ),
                        TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_7,
                            ),
                            style: textStyle_size_18_color_yellow()
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_8,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            ImagePath.ONTOP_UP_ICON,
                          ),
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_9,
                          ),
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_10,
                          ),
                            style: textStyle_size_18_color_yellow()
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_11,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(
                            ImagePath.ONTOP_CONFIRM_ICON,
                          ),
                        ),
                        TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_12,
                            ),
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_13,
                          ),
                            style: textStyle_size_18_color_yellow()
                        ),
                        TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_14,
                            ),
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_15,
                          ),
                            style: textStyle_size_18_color_yellow()
                        ),
                        TextSpan(
                          text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_16,
                          ),
                        )
                      ],
                      marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                    ),
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
                  isEnabled: state.isReceiveApplianceProvisioningToken == true,
                  title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                  onTapButton: () {
                    _navigateToNextPage(context);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context) {
    globals.routeNameToBack = Routes.ON_TOP_DESCRIPTION2_FNP_MODEL3;
    Navigator.of(context)
        .pushNamed(Routes.ON_TOP_COMMISSIONING_FNP_ENTER_PASSWORD);
  }

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

    print('AppLifecycleState: $state}');
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
