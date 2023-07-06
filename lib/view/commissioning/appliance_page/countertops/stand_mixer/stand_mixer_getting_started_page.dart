import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class StandMixerCommissioningStep1Page extends StatefulWidget {

  @override
  State createState() => _StandMixerCommissioningStep1Page();

}

class _StandMixerCommissioningStep1Page extends State<StandMixerCommissioningStep1Page> with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;

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
                            return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING &&
                                    ModalRoute.of(context)!.isCurrent);
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
                                    ModalRoute.of(context)!.isCurrent);
                          },
                          listener: (context, state) {
                            DialogManager().showBleFailToConnectDialog(context: context);
                          },
                          child: Container(),
                        ),
                        BlocListener<BleCommissioningCubit, BleCommissioningState>(
                          listenWhen: (previous, current) {
                            return (current.stateType == BleCommissioningStateType.START_PAIRING_ACTION2_RESULT &&
                                    ModalRoute.of(context)!.isCurrent);
                          },
                          listener: (context, state) {
                            if (state.isSuccess == true) {
                              globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                              Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                            } else {
                              DialogManager().showPairingFailedDialog(
                                context,
                                content: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_FAILED_DIALOG)
                              );
                            }
                          },
                          child: Container(),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.w),
                          child: Component.componentMainImage(context,
                            ImagePath.STAND_MIXER_IMAGE1)),
                        Component.componentTitleText(
                            title: (LocaleUtil.getString(context, LocaleUtil.LETS_GET_STARTED)!).toUpperCase(),
                            marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(8.h),
                        Component.componentDescriptionText(
                            text: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_SETUP_WILL_TAKE_ABOUT)!,
                            marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(20.h),
                        CustomRichText.addWifiTextBox(
                          spanStringList: [
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_ROTATE_KNOB)! + " ",
                                style: textStyle_size_18_color_grey()),
                            WidgetSpan(
                              child: Icon(
                                Icons.phone_iphone,
                                size: 21.w,
                                color: colorAmericanYellow(),
                              ),
                            ),
                            TextSpan(
                              text: ". " + LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_PRESS_AND_HOLD)! + " ",
                              style: textStyle_size_18_color_grey()),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.CENTER_BUTTON)! + " ",
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.FOR)! + " ",
                                style: textStyle_size_18_color_grey()),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.THREE_SECONDS)! + " ",
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_TO_BEGIN_COMMISSIONING),
                                style: textStyle_size_18_color_grey()),
                            TextSpan(
                              text: "\n \n" + LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_IF_DONE_CORRECTLY_1)! + " ",
                              style: textStyle_size_18_color_grey()),
                            WidgetSpan(
                              child: Icon(
                                Icons.wifi_outlined,
                                size: 21.w,
                                color: colorAmericanYellow(),
                              ),
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_IF_DONE_CORRECTLY_2)! + " ",
                                style: textStyle_size_18_color_grey())
                            
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
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
                            title:
                            LocaleUtil.getString(context, LocaleUtil.START)!,
                            isEnabled:
                            state.isReceiveApplianceProvisioningToken == null
                              ? false
                              : state.isReceiveApplianceProvisioningToken!,
                            onTapButton: () {
                              BlocProvider.of<BleCommissioningCubit>(context)
                                  .actionBleStartPairingAction2(ApplianceType.STAND_MIXER, () {
                                    DialogManager().showPairingFailedDialog(
                                      context,
                                      content: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_FAILED_DIALOG)
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

    var cubit = BlocProvider.of<CommissioningCubit>(context);
    cubit.initState();
    cubit.actionRequestApplicationProvisioningToken();
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
}
