import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenModel2EnableCommissioningFnpPage3 extends StatefulWidget {
  @override
  State createState() => _WallOvenModel2EnableCommissioningFnpPage3State();
}

class _WallOvenModel2EnableCommissioningFnpPage3State
    extends State<WallOvenModel2EnableCommissioningFnpPage3>
    with WidgetsBindingObserver {
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
                      return (current.stateType ==
                              BleCommissioningStateType.SHOW_PAIRING_LOADING &&
                          (ModalRoute.of(context) != null &&
                              ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      _loadingDialog.show(
                          context,
                          LocaleUtil.getString(context,
                              LocaleUtil.TRYING_TO_CONNECT_THE_APPLIANCE));
                    },
                    child: Container(),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType ==
                          BleCommissioningStateType.HIDE_PAIRING_LOADING);
                    },
                    listener: (context, state) {
                      _loadingDialog.close(context);
                    },
                    child: Container(),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType ==
                              BleCommissioningStateType.FAIL_TO_CONNECT &&
                          (ModalRoute.of(context) != null &&
                              ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      DialogManager()
                          .showBleFailToConnectDialog(context: context);
                    },
                    child: Container(),
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
                    child: Container(),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(context,
                            ImagePath.COOKING_WALL_OVEN_FNP_MODEL2_PASSWORD),
                        BaseComponent.heightSpace(16.h),
                        Component.componentTitleText(
                            title: LocaleUtil.getString(
                                    context, LocaleUtil.READY)!
                                .toUpperCase(),
                            marginInsets:
                                EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(16.h),
                        CustomRichText.addWifiTextBox(
                            spanStringList: [
                              TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_2_PAGE_4_INSTRUCTION_PART_1),
                                style: textStyle_size_18_color_white(),
                              ),
                              TextSpan(
                                  text: LocaleUtil.getString(
                                      context, LocaleUtil.COOKING_WALL_OVEN_FNP_MODEL_2_PAGE_4_INSTRUCTION_PART_2),
                                  style: textStyle_size_18_color_yellow()),
                              TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKING_WALL_OVEN_FNP_MODEL_2_PAGE_4_INSTRUCTION_PART_3),
                                style: textStyle_size_18_color_white(),
                              ),
                            ],
                            marginInsets:
                                EdgeInsets.symmetric(horizontal: 16.w),
                            alignText: TextAlign.left),
                      ],
                    ),
                  ),
                  Component.pageIndicator(4, 3, size: 15.h, spacing: 6.w),
                  BaseComponent.heightSpace(6.h),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!
                          .toUpperCase(),
                      onTapButton: () {
                        BlocProvider.of<BleCommissioningCubit>(context)
                            .actionBleStartPairingAction2(ApplianceType.OVEN,
                                () {
                          _navigateToNextPage(context);
                        }, startContinuousScan: true);
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.of(context).pushNamed(Routes
        .WALL_OVEN_MODEL_2_STEP_5_FNP);
  }

  @override
  void initState() {
    super.initState();

    _loadingDialog = LoadingDialog();

    Future.delayed(Duration.zero, () {
      BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
    });
  }

  @override
  void deactivate() {
    super.deactivate();

    _loadingDialog.close(context);
  }
}
