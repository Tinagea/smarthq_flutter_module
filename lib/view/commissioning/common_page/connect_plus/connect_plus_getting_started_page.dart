import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class ConnectPlusStartedPage extends StatefulWidget {
  final ApplianceType applianceType;
  ConnectPlusStartedPage(this.applianceType);

  @override
  State createState() {
    geaLog.debug('ConnectPlusStartedPage.createState');
    return _ConnectPlusStartedPage(applianceType);
  }
}

class _ConnectPlusStartedPage extends State<ConnectPlusStartedPage> with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;

  final ApplianceType applianceType;
  _ConnectPlusStartedPage(this.applianceType);

  @override
  Widget build(BuildContext context) {
    geaLog.debug('ConnectPlusStartedPage.build ${ApplianceErd.getApplianceName(ApplianceErd.getApplianceErd(applianceType), context)}');
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
            leftBtnFunction: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ).setNavigationAppBar(context: context),
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
                        globals.routeNameToBack = Routes.CONNECT_PLUS_STARTED_PAGE;
                        Navigator.of(context).pushNamed(Routes.CONNECT_PLUS_ENTER_PASSWORD_PAGE);
                      }
                    },
                    child: Container(),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(
                            context, ImagePath.CONNECT_PLUS_START),
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
                        BaseComponent.heightSpace(24.h),
                        Component.componentGrayRoundTextBox(
                            context,
                            LocaleUtil.getString(
                                context,
                                LocaleUtil
                                    .CONNECTED_PLUS_DESCRIPTION_1_TEXT_2)!),
                        BaseComponent.heightSpace(16.h),
                        Component.componentDescriptionTextWithLinkLabel(
                            contents: LocaleUtil.getString(context,
                                LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_3)!,
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
                                .actionBleStartPairingAction2(applianceType, () {
                                  globals.routeNameToBack = Routes.CONNECT_PLUS_STARTED_PAGE;
                                  Navigator.of(context).pushNamed(Routes.CONNECT_PLUS_ENTER_PASSWORD_PAGE);
                                });
                          });
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    geaLog.debug('ConnectPlusStartedPage.initState');

    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero, () {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    });

    _loadingDialog = LoadingDialog();
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ConnectPlusStartedPage.deactivate');

    _loadingDialog.close(context);
  }

  @override
  void dispose() {
    geaLog.debug('ConnectPlusStartedPage.dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    geaLog.debug('ConnectPlusStartedPage.didChangeAppLifecycleState');
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
