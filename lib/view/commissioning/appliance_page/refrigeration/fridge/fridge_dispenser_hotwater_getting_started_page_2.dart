import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
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
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class DispenserCommissioningModel1Step2 extends StatefulWidget {

  @override
  State createState() => _DispenserCommissioningModel1Step2();
}

class _DispenserCommissioningModel1Step2 extends State<DispenserCommissioningModel1Step2> {

  late LoadingDialog _loadingDialog;

  @override
  void initState() {
    super.initState();

    _loadingDialog = LoadingDialog();
  }

  @override
  void deactivate() {
    super.deactivate();

    _loadingDialog.close(context);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
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
                              globals.routeNameToBack = Routes.DISPENSER_DESCRIPTION3_MODEL1;
                              Navigator.of(context).pushNamed(Routes.DISPENSER_COMMISSIONING_ENTER_PASSWORD1);
                            }
                          },
                          child: Container(),
                        ),
                        Component.componentMainImage(context,
                            ImagePath.DISPENSER_TOP_CONTROLLER1_COLOR),
                        BaseComponent.heightSpace(16.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .TAP)! + " ",
                                style: textStyle_size_18_color_white()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .TURN_ON)!  + " ",
                                style: textStyle_size_18_color_yellow()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .DISPENSER_DESCRIPTION_2_TEXT_1),
                                style: textStyle_size_18_color_white()
                            ),
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                        Component.componentDescriptionTextWithLinkLabel(
                          contents: LocaleUtil.getString(
                              context, LocaleUtil.WIFI_NOT_SELECTABLE)!,
                          contentsForLink: LocaleUtil.getString(
                              context, LocaleUtil.CONNECT_PLUS)!,
                          link: LocaleUtil.getString(
                              context, LocaleUtil.CONNECT_PLUS_HOW_TO_URL)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 29.w),
                        ),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      onTapButton: () {
                        BlocProvider.of<BleCommissioningCubit>(context)
                            .actionBleStartPairingAction2(ApplianceType.REFRIGERATOR,
                                () {
                              globals.routeNameToBack = Routes.DISPENSER_DESCRIPTION3_MODEL1;
                              Navigator.of(context).pushNamed(Routes.DISPENSER_COMMISSIONING_ENTER_PASSWORD1);
                            },startContinuousScan: true);
                      }
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
