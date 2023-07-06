import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class LaundryCenterBuiltInWifiSetup extends StatefulWidget {

  @override
  State createState() => _LaundryCenterBuiltInWifiSetup();
}

class _LaundryCenterBuiltInWifiSetup extends State<LaundryCenterBuiltInWifiSetup>
    with WidgetsBindingObserver {
  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          leftBtnFunction: () {
              Navigator.of(context).pop();
          },
        ).setNavigationAppBar(context: context),
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
                          return (current.stateType == BleCommissioningStateType.START_PAIRING_ACTION2_RESULT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                        },
                        listener: (context, state) {
                          _loadingDialog.close(context);

                          geaLog.debug('state.isSuccess: ${state.isSuccess}, state.applianceType: ${state.applianceType}');
                          if (state.isSuccess == true) {
                            globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                            Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                          }
                          else {
                            globals.routeNameToBack = Routes.LAUNDRY_CENTER_SELECT_WIFI_TYPE;
                            Navigator.of(context).pushNamed(Routes.LAUNDRY_CENTER_ENTER_PASSWORD);
                          }
                        },
                        child: Container(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 64.h),
                        child:Component.componentMainSmallImage(context,
                          ImagePath.LAUNDRY_CENTER_TEMP_WIFI_IMAGE)
                      ),
                      BaseComponent.heightSpace(16.h),
                      CustomRichText.addWifiTextBox(
                          spanStringList: [
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_SETUP_BUILT_IN_WIFI_DESCRIPTION_1),
                                style: textStyle_size_18_color_white()),
                            WidgetSpan(
                              child: Icon(
                                Icons.wifi,
                                size: 24.w,
                                color: colorSelectiveYellow(),
                              ),
                            ),
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_SETUP_BUILT_IN_WIFI_DESCRIPTION_2),
                                style: textStyle_size_18_color_white()),
                            WidgetSpan(child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                                    child: Component.componentHorizontalDivider(),
                                  )),
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_SETUP_DRYER_DESCRIPTION_1),
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_SETUP_DRYER_DESCRIPTION_2),
                                style: textStyle_size_18_color_white()),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
                      BaseComponent.heightSpace(16.h),
                    ],
                  ),
                ),

                BlocBuilder<CommissioningCubit, CommissioningState>(
                  bloc: BlocProvider.of<CommissioningCubit>(context),
                  buildWhen: (previous, current) {
                    return (current.stateType == CommissioningStateType.APT);
                  },
                  builder: (context, state) {
                    return Component.componentBottomButton(
                        title:
                        LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                        isEnabled: state.isReceiveApplianceProvisioningToken == null
                            ? false : state.isReceiveApplianceProvisioningToken!,
                        onTapButton: () {
                          BlocProvider.of<BleCommissioningCubit>(context)
                              .actionBleStartPairingAction2(ApplianceType.LAUNDRY_WASHER, () {
                                globals.routeNameToBack = Routes.LAUNDRY_CENTER_SELECT_WIFI_TYPE;
                                Navigator.of(context).pushNamed(Routes.LAUNDRY_CENTER_ENTER_PASSWORD);
                              });
                        });
                  })
              ],
            ),
          ),
        ),
      ),
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
    });

    _loadingDialog = LoadingDialog();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();

    _loadingDialog.close(context);
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
