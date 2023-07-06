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
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class WasherFrontModel1Description extends StatefulWidget {

  @override
  State createState() => _WasherFrontModel1Description();
}

class _WasherFrontModel1Description extends State<WasherFrontModel1Description>
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
                            globals.routeNameToBack = Routes.WASHER_FRONT_MODEL1;
                            Navigator.of(context).pushNamed(Routes.WASHER_FRONT_1_PASSWORD);
                          }
                        },
                        child: Container(),
                      ),
                      Component.componentMainImage(context,
                          ImagePath.WASHER_FRONT_1_COLOR),
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
                      BaseComponent.heightSpace(48.h),
                      CustomRichText.customSpanListTextBox(
                        textSpanList: <TextSpan>[
                          TextSpan(text: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_FRONT_1_WIFI_1), style: textStyle_size_18_color_white()),
                          TextSpan(text: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_FRONT_1_WIFI_2), style: textStyle_size_18_color_yellow()),
                          TextSpan(text: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_FRONT_1_WIFI_3), style: textStyle_size_18_color_white()),
                          TextSpan(text: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_FRONT_1_WIFI_4), style: textStyle_size_18_color_yellow()),
                          TextSpan(text: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_FRONT_1_WIFI_5), style: textStyle_size_18_color_white())
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
                                        globals.routeNameToBack = Routes.WASHER_FRONT_MODEL1;
                                        Navigator.of(context).pushNamed(Routes.WASHER_FRONT_1_PASSWORD);
                                      }, startContinuousScan: true);
                                });
                          })
                    ],
                  ),
                ),
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
      BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
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