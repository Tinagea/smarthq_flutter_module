/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenEnableCommissioningHaierPage2 extends StatefulWidget {
  const WallOvenEnableCommissioningHaierPage2({Key? key}) : super(key: key);

  @override
  State<WallOvenEnableCommissioningHaierPage2> createState() =>
      _WallOvenEnableCommissioningHaierPage2State();
}

class _WallOvenEnableCommissioningHaierPage2State extends State<WallOvenEnableCommissioningHaierPage2>
    with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
    });

    _loadingDialog = LoadingDialog();
  }

  @override
  void deactivate() {
    super.deactivate();

    _loadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!,
        leftBtnFunction: () {
          Navigator.of(context).pop();
        },
      ).setNavigationAppBar(context: context),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BleCommissioningCubit, BleCommissioningState>(
            listenWhen: (previous, current) {
              return (current.stateType ==
                  BleCommissioningStateType.SHOW_PAIRING_LOADING &&
                  (ModalRoute.of(context) != null &&
                      ModalRoute.of(context)!.isCurrent));
            },
            listener: (context, state) {
              _loadingDialog.show(
                  context,
                  LocaleUtil.getString(
                      context, LocaleUtil.TRYING_TO_CONNECT_THE_APPLIANCE));
            },
          ),
          BlocListener<BleCommissioningCubit, BleCommissioningState>(
            listenWhen: (previous, current) {
              return (current.stateType ==
                  BleCommissioningStateType.HIDE_PAIRING_LOADING);
            },
            listener: (context, state) {
              _loadingDialog.close(context);
            },
          ),
          BlocListener<BleCommissioningCubit, BleCommissioningState>(
            listenWhen: (previous, current) {
              return (current.stateType ==
                  BleCommissioningStateType.FAIL_TO_CONNECT &&
                  (ModalRoute.of(context) != null &&
                      ModalRoute.of(context)!.isCurrent));
            },
            listener: (context, state) {
              DialogManager().showBleFailToConnectDialog(context: context);
            },
          ),
          BlocListener<BleCommissioningCubit, BleCommissioningState>(
            listenWhen: (previous, current) {
              return (current.stateType ==
                  BleCommissioningStateType
                      .START_PAIRING_ACTION2_RESULT &&
                  (ModalRoute.of(context) != null &&
                      ModalRoute.of(context)!.isCurrent));
            },
            listener: (context, state) {
              geaLog.debug(
                  'state.isSuccess: ${state.isSuccess}, state.applianceType: ${state.applianceType}');

              if (state.isSuccess == true) {
                globals.subRouteName =
                    Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
              } else {
                _navigateToNextPage(context);
              }
            },
          ),
        ],
        child: ListView(
          children: [
            BaseComponent.heightSpace(16.h),
            Text(
              LocaleUtil.getString(
                  context, LocaleUtil.NOW_PRESS_THIS_BUTTON_AGAIN_AND_WIFI_ICON_WILL_FLASH)!,
              style: textStyle_size_12_white_50_opacity(),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 48.w),
              child: Component.componentMainImage(context,
                  ImagePath.COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_2_SVG),
            ),
            Component.pageIndicator(3, 2, size: 8),
            BaseComponent.heightSpace(16.h),
            Divider(height: 1.h, color: colorDeepDarkCharcoal()),
            BaseComponent.heightSpace(16.h),
            Center(
              child: Component.componentTitleText(
                  title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!
                      .toUpperCase(),
                  marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
            ),
            BaseComponent.heightSpace(16.h),
            CustomRichText.addWifiTextBoxCentered(
              spanStringList: [
                TextSpan(
                  text: LocaleUtil.getString(
                      context,
                      LocaleUtil
                          .COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_3_PART_1),
                  style: textStyle_size_18_color_white(),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.wifi, size: 24, color: colorAmericanYellow()),
                ),
                TextSpan(
                  text: LocaleUtil.getString(
                      context,
                      LocaleUtil
                          .COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_3_PART_2),
                  style: textStyle_size_18_color_white(),
                ),
              ],
              marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
            ),
            BaseComponent.heightSpace(16.h),
            Component.componentBottomButton(
              title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
              onTapButton: () {
                BlocProvider.of<BleCommissioningCubit>(context)
                    .actionBleStartPairingAction2(ApplianceType.OVEN, () {
                  _navigateToNextPage(context);
                }, startContinuousScan: true);
              },
            ),
            BaseComponent.heightSpace(20.h),
          ],
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context) {
    globals.routeNameToBack =
        Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_3;
    Navigator.pushNamed(context, Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_4);
  }
}
