import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class GatewayPairSensorFailurePage extends StatefulWidget {
  @override
  State createState() => _GatewayPairSensorFailurePage();
}

class _GatewayPairSensorFailurePage extends State<GatewayPairSensorFailurePage>
    with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;

  @override
  void initState() {
    super.initState();
    _loadingDialog = LoadingDialog();
  }

  @override
  void dispose() {
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
    if (state == AppLifecycleState.resumed) {
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.PAIR_SENSORS)!
                  .toUpperCase())
              .setNavigationAppBar(context: context, leadingRequired: false, actionRequired: false),
          body: Component.componentCommissioningBody(
            context,
            <Widget>[
              BlocListener<BleCommissioningCubit, BleCommissioningState>(
                listenWhen: (previous, current) {
                  return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                },
                listener: (context, state) {
                  _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.TRYING_TO_START_PAIRING));
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
                  return (current.stateType == BleCommissioningStateType.START_PAIRING_SENSOR_RESULT
                      && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                },
                listener: (context, state) {
                  if (state.isSuccessToStartParingSensor != null) {
                    if (state.isSuccessToStartParingSensor!) {
                      Navigator.of(context).popUntil((route) => route.settings.name == Routes.GATEWAY_PAIR_SENSOR_DESCRIPTION_PAGE);
                    }
                    else {
                      DialogManager().showFailToStartPairingDialog(context: context);
                    }
                  }
                },
                child: Container(),
              ),
              BaseComponent.heightSpace(24.h),
              Component.componentMainImage(context,
                  ImagePath.GATEWAY_IMAGE3),
              BaseComponent.heightSpace(30.h),
              Component.componentInformationText(
                  text: LocaleUtil.getString(context,
                      LocaleUtil.GATEWAY_PAIR_FAILURE_DESCRIPTION_1)!,
                  marginInsets: EdgeInsets.symmetric(horizontal: 30.w)),
              BaseComponent.heightSpace(50.h),
              Component.componentDescriptionText(
                  text: LocaleUtil.getString(context,
                      LocaleUtil.SOMETHING_WENT_WRONG_RETRY_TEXT_2)!,
                  marginInsets: EdgeInsets.symmetric(horizontal: 30.w))
            ],
            Container(
                margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 60.w),
                child: Component.componentTwoBottomButton(
                    LocaleUtil.getString(context,
                        LocaleUtil.RETRY)!.toUpperCase(),
                    () {
                      BlocProvider.of<BleCommissioningCubit>(context).startPairingSensor(shouldFetchSensorList: false);
                    },
                    LocaleUtil.getString(context,
                        LocaleUtil.CANCEL)!.toUpperCase(),
                    () {
                      Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);

                      SystemNavigator.pop(animated: true);
                      BlocProvider.of<CommissioningCubit>(context).actionMoveToNativeBackPage();

                      BlocProvider.of<CommissioningCubit>(context).actionRequestRelaunch();
                    })
            ),
          ),
        )
    );
  }
}
