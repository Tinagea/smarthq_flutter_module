import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class MicrowaveApplianceInfo extends StatefulWidget {
  @override
  _MicrowaveApplianceInfo createState() => _MicrowaveApplianceInfo();
}

class _MicrowaveApplianceInfo extends State<MicrowaveApplianceInfo> {
  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                  .toUpperCase())
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
                              globals.routeNameToBack = Routes.MICROWAVE_DESCRIPTION;
                              Navigator.of(context).pushNamed(Routes.MICROWAVE_PASSWORD_INFO);
                            }
                          },
                          child: Container(),
                        ),
                        Component.componentMainImage(
                            context, ImagePath.MICROWAVE_APPLIANCE_INFO),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .MICROWAVE_APPLIANCE_INFO),
                                style: textStyle_size_18_color_white()
                            ),
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  BlocBuilder<CommissioningCubit, CommissioningState>(
                      bloc: BlocProvider.of<CommissioningCubit>(context),
                      buildWhen: (previous, current) {
                        return (current.stateType ==
                            CommissioningStateType.APT ||
                            current.stateType ==
                                CommissioningStateType.INITIAL);
                      },
                      builder: (context, state) {
                        return Component.componentBottomButton(
                            title: LocaleUtil.getString(
                                context, LocaleUtil.CONTINUE)!,
                            isEnabled: true,
                            onTapButton: () {
                              BlocProvider.of<BleCommissioningCubit>(context).actionBleStartPairingAction2(ApplianceType.MICROWAVE, () {
                                globals.routeNameToBack = Routes.MICROWAVE_DESCRIPTION;
                                Navigator.of(context).pushNamed(Routes.MICROWAVE_PASSWORD_INFO);
                              }, startContinuousScan: true);
                            });
                      })
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _loadingDialog = LoadingDialog();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
