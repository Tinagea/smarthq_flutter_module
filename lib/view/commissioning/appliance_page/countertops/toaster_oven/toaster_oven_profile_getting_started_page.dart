import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
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
import 'package:smarthq_flutter_module/globals.dart' as globals;

class ToasterOvenProfileCommissioningStep1 extends StatefulWidget {
  @override
  State createState() => _ToasterOvenProfileCommissioningStep1();
}

class _ToasterOvenProfileCommissioningStep1 extends State<ToasterOvenProfileCommissioningStep1> with WidgetsBindingObserver {
  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: true).pop();
              })
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
                            return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING &&
                                (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
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
                            return (current.stateType == BleCommissioningStateType.FAIL_TO_CONNECT &&
                                (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                          },
                          listener: (context, state) {
                            DialogManager().showBleFailToConnectDialog(context: context);
                          },
                          child: Container(),
                        ),
                        BlocListener<BleCommissioningCubit, BleCommissioningState>(
                          listenWhen: (previous, current) {
                            return (current.stateType == BleCommissioningStateType.START_PAIRING_ACTION2_RESULT &&
                                (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                          },
                          listener: (context, state) {
                            geaLog.debug('state.isSuccess: ${state.isSuccess}, state.applianceType: ${state.applianceType}');

                            if (state.isSuccess == true) {
                              globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                              Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                            } else {
                              DialogManager().showPairingFailedDialog(
                                context,
                                content: LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN_FAILED_DIALOG)                              
                                );
                            }
                          },
                          child: Container(),
                        ),
                        Container(margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0), child: Component.componentMainImage(context, ImagePath.PROFILE_TOASTER_OVEN_SCREEN1)),
                        Component.componentTitleText(
                            title: LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN_LETS_GET_STARTED)!, marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(8.h),
                        Component.componentDescriptionText(
                            text: LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN_SETUP_WILL_TAKE_ABOUT)!, marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(20.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.PRESS)! + " ", style: textStyle_size_18_color_white()),
                            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN_WARM), style: textStyle_size_18_color_yellow()),
                            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.AND), style: textStyle_size_18_color_white()),
                            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN_REHEAT)! + " ", style: textStyle_size_18_color_yellow()),
                            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN_INSTRUCTIONS), style: textStyle_size_18_color_white())
                          ],
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
                            title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                            isEnabled: state.isReceiveApplianceProvisioningToken == null ? false : state.isReceiveApplianceProvisioningToken!,
                            onTapButton: () {
                              BlocProvider.of<BleCommissioningCubit>(context).actionBleStartPairingAction2(ApplianceType.TOASTER_OVEN, () {
                                DialogManager().showPairingFailedDialog(
                                  context,
                                  content: LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN_FAILED_DIALOG)                              
                                  );
                              });
                            });
                      })
                ],
              ),
            ),
          ),
        )
    );
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