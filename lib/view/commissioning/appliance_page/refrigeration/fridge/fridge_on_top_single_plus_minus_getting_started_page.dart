import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
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
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class OnTopCommissioningModel2Step1 extends StatefulWidget {

  @override
  State createState() => _OnTopCommissioningModel2Step1();
}

class _OnTopCommissioningModel2Step1 extends State<OnTopCommissioningModel2Step1> with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)).setNavigationAppBar(context: context),
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
                        globals.routeNameToBack = Routes.ON_TOP_DESCRIPTION2_MODEL2;
                        Navigator.of(context).pushNamed(Routes.ON_TOP_DESCRIPTION3_MODEL2);
                      }
                    },
                    child: Container(),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(
                            context,
                            ImagePath.ONTOP_MAIN_MODEL2),
                        BaseComponent.heightSpace(16.h),
                        Component.componentTitleText(
                            title: LocaleUtil.getString(
                                context, LocaleUtil.LETS_GET_STARTED)!
                                .toUpperCase(),
                            marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(10.h),
                        Component.componentDescriptionText(
                          text: LocaleUtil.getString(context,
                              LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_1)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                        ),
                        BaseComponent.heightSpace(58.h),
                        CustomRichText.addWifiTextBox(
                            spanStringList: [
                              TextSpan(
                                text: LocaleUtil.getString(context,
                                    LocaleUtil.PRESS_WIFI_CONNECT_BUTTON),
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
                                    context, LocaleUtil.WILL_START_TO_FLASH),
                              )
                            ],
                            marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
                        BaseComponent.heightSpace(16.h),
                        Component.componentDescriptionTextWithLinkLabel(
                            contents: LocaleUtil.getString(
                                context, LocaleUtil.CANT_FIND_THIS_BUTTON)!,
                            contentsForLink: LocaleUtil.getString(
                                context, LocaleUtil.CONNECT_PLUS)!,
                            link: LocaleUtil.getString(
                                context, LocaleUtil.CONNECT_PLUS_HOW_TO_URL)!,
                            marginInsets: EdgeInsets.symmetric(horizontal: 29.w)),
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
                            isEnabled: state.isReceiveApplianceProvisioningToken == null
                                ? false : state.isReceiveApplianceProvisioningToken!,
                        onTapButton: () {
                          BlocProvider.of<BleCommissioningCubit>(context)
                              .actionBleStartPairingAction2(ApplianceType.REFRIGERATOR,
                                  () {
                                globals.routeNameToBack = Routes.ON_TOP_DESCRIPTION2_MODEL2;
                                Navigator.of(context).pushNamed(Routes.ON_TOP_DESCRIPTION3_MODEL2);
                              },startContinuousScan: true);
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
