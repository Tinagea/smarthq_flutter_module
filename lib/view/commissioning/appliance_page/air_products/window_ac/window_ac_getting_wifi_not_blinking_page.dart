import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class WindowACWifiNotBlinking extends StatefulWidget {
  @override
  _WindowACWifiNotBlinkingState createState() => _WindowACWifiNotBlinkingState();
}

class _WindowACWifiNotBlinkingState extends State<WindowACWifiNotBlinking> with WidgetsBindingObserver{
  late LoadingDialog _loadingDialog;

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

    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          ).setNavigationAppBar(context: context),
      body: Component.componentCommissioningBodyWithBottomItem(
        context,
        <Widget>[
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
                globals.routeNameToBack = Routes.WINDOW_AC_PAGE_4;
                Navigator.of(context).pushNamed(Routes.WINDOW_AC_PAGE_2);
              }
            },
            child: Container(),
          ),

          Component.componentMainPngImage(
              context, ImagePath.WINDOWS_AC_WIFI_CONNECT),
          BaseComponent.heightSpace(16),
          CustomRichText.addWifiTextBox(
            spanStringList: [
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WINDOW_AC_SETUP_DESC_11),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WINDOW_AC_SETUP_DESC_12),
                  style: textStyle_size_18_color_yellow()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WINDOW_AC_SETUP_DESC_13),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WINDOW_AC_SETUP_DESC_14),
                  style: textStyle_size_18_color_yellow()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WINDOW_AC_SETUP_DESC_15),
                  style: textStyle_size_18_color_white()),
            ],
            marginInsets: EdgeInsets.symmetric(horizontal: 16),

          ),
          BaseComponent.heightSpace(16)
        ],
        Component.componentWhiteOutlinedButton(LocaleUtil.getString(context, LocaleUtil.LIGHT_IS_NOT_BLINKING)!, () {
          globals.routeNameToBack = Routes.WINDOW_AC_PAGE_4;
          Navigator.of(context).pushNamed(Routes.WINDOW_AC_PAGE_5);
        }),
        BlocBuilder<CommissioningCubit, CommissioningState>(
            bloc: BlocProvider.of<CommissioningCubit>(context),
            buildWhen: (previous, current) {
              return (current.stateType == CommissioningStateType.APT ||
                  current.stateType == CommissioningStateType.INITIAL);
            },
            builder: (context, state) {
              return Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.LIGHT_IS_BLINKING)!,
                  isEnabled: state.isReceiveApplianceProvisioningToken == null
                      ? false : state.isReceiveApplianceProvisioningToken!,
                  onTapButton: () {
                    BlocProvider.of<BleCommissioningCubit>(context)
                        .actionBleStartPairingAction2List([ApplianceType.AIR_CONDITIONER,ApplianceType.BUILT_IN_AC], () {
                          geaLog.debug("WindowACHome on tap");
                          globals.routeNameToBack = Routes.WINDOW_AC_PAGE_4;
                          Navigator.of(context).pushNamed(Routes.WINDOW_AC_PAGE_2);
                        });
                  });
            }),
      ),
    );
}}
