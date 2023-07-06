import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class PageCooktopGasStep3 extends StatefulWidget {
  @override
  _PageCooktopGasStep3 createState() => _PageCooktopGasStep3();
}

class _PageCooktopGasStep3 extends State<PageCooktopGasStep3> with WidgetsBindingObserver{
  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                  .toUpperCase())
              .setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        BlocListener<BleCommissioningCubit, BleCommissioningState>(
                          listenWhen: (previous, current) {
                            return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING && ModalRoute.of(context)!.isCurrent);
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
                            return (current.stateType == BleCommissioningStateType.FAIL_TO_CONNECT && ModalRoute.of(context)!.isCurrent);
                          },
                          listener: (context, state) {
                            DialogManager().showBleFailToConnectDialog(context: context);
                          },
                          child: Container(),
                        ),
                        BlocListener<BleCommissioningCubit, BleCommissioningState>(
                          listenWhen: (previous, current) {
                            return (current.stateType == BleCommissioningStateType.START_PAIRING_ACTION2_RESULT && ModalRoute.of(context)!.isCurrent);
                          },
                          listener: (context, state) {
                            if (state.isSuccess == true) {
                              globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                              Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                            }
                            else {
                              globals.routeNameToBack = Routes.COOKTOP_GAS_STEP_3;
                              Navigator.of(context).pushNamed(Routes.COOKTOP_APPLIANCE_INFO_GAS);
                            }
                          },
                          child: Container(),
                        ),
                        Component.componentMainImage(
                            context, ImagePath.COOKTOP_GAS_STEP_3),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.addWifiTextBox(
                          spanStringList:[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKTOP_GAS_STEP_2_TEXT_1),
                                style: textStyle_size_18_color_white()
                            ),
                            WidgetSpan(
                              child: Icon(
                                Icons.add,
                                size: 24.w,
                                color: colorSelectiveYellow(),
                              ),
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKTOP_GAS_STEP_2_TEXT_2),
                                style: textStyle_size_18_color_white()
                            ),
                            WidgetSpan(
                              child: Icon(
                                Icons.wifi,
                                size: 24.w,
                                color: colorSelectiveYellow(),
                              ),
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKTOP_GAS_STEP_2_TEXT_3),
                                style: textStyle_size_18_color_white()
                            ),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      onTapButton: () {
                        BlocProvider.of<BleCommissioningCubit>(context)
                            .actionBleStartPairingAction2(ApplianceType.GAS_COOKTOP,
                                () {
                              globals.routeNameToBack =
                                  Routes.COOKTOP_GAS_STEP_3;
                              Navigator.of(context).pushNamed(
                                  Routes.COOKTOP_APPLIANCE_INFO_GAS);
                            },startContinuousScan: true);
                      }
                  ),
                ],
              ),
            ),
          ),
        ));
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
