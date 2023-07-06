

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:flutter_bloc/flutter_bloc.dart';

class WallOvenPrimaryTypeThreePage3 extends StatefulWidget {
  @override
  _WallOvenPrimaryTypeThreePage3 createState() => _WallOvenPrimaryTypeThreePage3();
}

class _WallOvenPrimaryTypeThreePage3 extends State<WallOvenPrimaryTypeThreePage3> with WidgetsBindingObserver{
  late LoadingDialog _loadingDialog;

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

  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
    bool _showBleConnectedPopUp = false;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase()).setNavigationAppBar(context: context),
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
                      geaLog.debug('state.isSuccess: ${state.isSuccess}');
                      if (state.isSuccess == true) {
                        if (!_showBleConnectedPopUp) {
                          globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                          Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                        } else {
                          CommonBleAlertDialog.fromCommonBaseAlertDialog(context: context).showCommonBleAlertDialog();
                        }
                      } else {
                        if(!_showBleConnectedPopUp) {
                          geaLog.debug('BLE=> moving to common wifi page');
                          RepositoryProvider
                              .of<WifiCommissioningStorage>(context)
                              .setUsiType = true;
                          globals.navigatorNameToBack = Routes.WALL_OVEN_MAIN_NAVIGATOR;
                          globals.routeNameToBack = Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_3;
                          globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                          Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR).then((_) => _showBleConnectedPopUp = false);
                          _showBleConnectedPopUp = true;
                        }
                      }
                    },
                    child: Container(),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(
                            context, ImagePath.WALL_OVEN_TYPE_PRIMARY_3_PAGE_3),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .WALL_OVEN_TYPE_3_PRIMARY_DESC_13),
                                style: textStyle_size_18_color_white()),
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled: true,
                      onTapButton: () {
                        BlocProvider.of<BleCommissioningCubit>(context)
                            .actionBleStartPairingAction2(ApplianceType.OVEN,
                                () {
                              RepositoryProvider.of<WifiCommissioningStorage>(context).setUsiType = true;
                              globals.navigatorNameToBack = Routes.WALL_OVEN_MAIN_NAVIGATOR;
                              globals.routeNameToBack = Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_3;
                              globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                            }, startContinuousScan: true);
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
