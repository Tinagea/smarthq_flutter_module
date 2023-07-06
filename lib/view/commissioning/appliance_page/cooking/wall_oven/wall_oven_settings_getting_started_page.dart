import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
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

class WallOvenPrimaryTypeTwoPageOneType3 extends StatefulWidget {
  @override
  _WallOvenPrimaryTypeTwoPageOneType3 createState() => _WallOvenPrimaryTypeTwoPageOneType3();
}

class _WallOvenPrimaryTypeTwoPageOneType3 extends State<WallOvenPrimaryTypeTwoPageOneType3>
    with WidgetsBindingObserver {
  late LoadingDialog _loadingDialog;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero, () {
      BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
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
      body: Component.componentCommissioningBody(
        context,
        <Widget>[
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
                globals.routeNameToBack = Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_THREE;
                Navigator.of(context).pushNamed(Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_TWO);
              }
            },
            child: Container(),
          ),
          Component.componentMainImage(
              context, ImagePath.WALL_OVEN_TYPE_PRIMARY_2_PAGE_ONE_TYPE_THREE),
          BaseComponent.heightSpace(16.h),
          Component.componentTitleText(
              title: LocaleUtil.getString(context, LocaleUtil.LETS_GET_STARTED)!
                  .toUpperCase(),
              marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
          BaseComponent.heightSpace(16),
          Component.componentDescriptionText(
              text: LocaleUtil.getString(context, LocaleUtil.OPAL_SETUP_DESC_1)!,
              marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
          BaseComponent.heightSpace(16.h),
          CustomRichText.addWifiTextBox(
            spanStringList: [
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_13),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_14),
                  style: textStyle_size_18_color_yellow()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_15),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_16),
                  style: textStyle_size_18_color_yellow()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_17),
                  style: textStyle_size_18_color_white()),
            ],
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w),

          ),
          BaseComponent.heightSpace(16.h)
        ],
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
                      ? false
                      : state.isReceiveApplianceProvisioningToken!,
                  onTapButton: () {
                    BlocProvider.of<BleCommissioningCubit>(context)
                        .actionBleStartPairingAction2(ApplianceType.OVEN,
                            () {
                          globals.routeNameToBack = Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_THREE;
                          Navigator.of(context).pushNamed(Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_TWO);
                        },startContinuousScan: true);
                  });
            }),
      ),
    );
  }
}
