/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenModel1GettingStartedFnpPage extends StatefulWidget {

  @override
  State createState() => _WallOvenModel1GettingStartedFnpPageState();
}

class _WallOvenModel1GettingStartedFnpPageState extends State<WallOvenModel1GettingStartedFnpPage> with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;

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
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.TRYING_TO_CONNECT_THE_APPLIANCE));
                    },
                    child: Container(),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.HIDE_PAIRING_LOADING);
                    },
                    listener: (context, state) {
                      _loadingDialog.close(context);
                    },
                    child: Container(),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.FAIL_TO_CONNECT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      DialogManager().showBleFailToConnectDialog(context: context);
                    },
                    child: Container(),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.START_PAIRING_ACTION2_RESULT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      geaLog.debug('state.isSuccess: ${state.isSuccess}, state.applianceType: ${state.applianceType}');

                      if (state.isSuccess == true) {
                        globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                        Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                      }
                      else {
                        _navigateToNextPage(context);
                      }
                    },
                    child: Container(),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        BaseComponent.heightSpace(24.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                          child: Component.componentMainImage(
                              context, ImagePath.COOKING_WALL_OVEN_FNP_MODEL1_GETTING_STARTED),
                        ),
                        BaseComponent.heightSpace(24.h),
                        Component.componentTitleText(
                            title: LocaleUtil.getString(
                                context, LocaleUtil.LETS_GET_STARTED)!
                                .toUpperCase(),
                            marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                        Component.componentDescriptionText(
                          text: LocaleUtil.getString(context,
                              LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_1)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                        ),
                        BaseComponent.heightSpace(24.h),
                        CustomRichText.addWifiTextBox(
                          spanStringList: [
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_1),
                              style: textStyle_size_18_color_white(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_2),
                              style: textStyle_size_18_color_yellow(),
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
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_3),
                              style: textStyle_size_18_color_white(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_4),
                              style: textStyle_size_18_color_yellow(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_5),
                              style: textStyle_size_18_color_white(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_6),
                              style: textStyle_size_18_color_yellow(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_7),
                              style: textStyle_size_18_color_white(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_8),
                              style: textStyle_size_18_color_yellow(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_9),
                              style: textStyle_size_18_color_white(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_10),
                              style: textStyle_size_18_color_yellow(),
                            ),
                            TextSpan(
                              text: LocaleUtil.getString(context,
                                  LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_11),
                              style: textStyle_size_18_color_white(),
                            ),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                          alignText: TextAlign.left
                        ),
                        BaseComponent.heightSpace(16.h),
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
                            isEnabled: state.isReceiveApplianceProvisioningToken == null ? false : state.isReceiveApplianceProvisioningToken!,
                            title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!,
                            onTapButton: () {
                              BlocProvider.of<BleCommissioningCubit>(context)
                                  .actionBleStartPairingAction2(ApplianceType.OVEN,
                                      () {
                                    _navigateToNextPage(context);
                                  }, startContinuousScan: true);
                            });
                      })
                ],
              ),
            ),
          ),
        ));
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.WALL_OVEN_MODEL_1_STEP_2_FNP);
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

    _loadingDialog = LoadingDialog();
  }

  @override
  void deactivate() {
    super.deactivate();

    _loadingDialog.close(context);
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
