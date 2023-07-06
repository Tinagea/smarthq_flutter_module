import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';

import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/gateway_navigator.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GatewayPairSensorGettingStartedPage extends StatefulWidget {
  final GatewayNavigatorArgs? args;

  GatewayPairSensorGettingStartedPage(this.args);

  @override
  State createState() => _GatewayPairSensorGettingStartedPage(args);
}

class _GatewayPairSensorGettingStartedPage extends State<GatewayPairSensorGettingStartedPage>
    with WidgetsBindingObserver {

  final GatewayNavigatorArgs? args;
  _GatewayPairSensorGettingStartedPage(this.args);

  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.PAIR_SENSORS),
            leftBtnFunction: RepositoryProvider.of<NativeStorage>(context).isStartPairSensor ? () {
              Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
              SystemNavigator.pop(animated: true);
          } : null ).setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Column(
                    children: setBlocListeners(),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(context,
                            ImagePath.GATEWAY_IMAGE3),
                        BaseComponent.heightSpace(16.h),
                        Component.componentGrayRoundTextBox(
                            context,
                            LocaleUtil.getString(
                                context,
                                LocaleUtil.GATEWAY_PAIR_DESCRIPTION_1)!),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title:
                      LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                      onTapButton: () {
                        Navigator.of(context).pushNamed(Routes.GATEWAY_PAIR_SENSOR_PAIRING_PAGE);
                      })
                ],
              ),
            ),
          ),
        )
    );
  }

  List<Widget> setBlocListeners() {
    return [
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
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
            if (state.isSuccessToStartParingSensor == false) {
              DialogManager().showFailToStartPairingDialogWithRetry(context: context,
                onYesPressed: () {
                  BlocProvider.of<BleCommissioningCubit>(context).startPairingSensor();
                },
                onNoPressed: () {
                  BlocProvider.of<CommissioningCubit>(context).initState();
                  BlocProvider.of<CommissioningCubit>(context).actionRequestGeModuleReachability(false);

                  BlocProvider.of<BleCommissioningCubit>(context).initState();
                  BlocProvider.of<BleCommissioningCubit>(context).actionBleStopScanning();

                  Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);

                  SystemNavigator.pop(animated: true);
                  BlocProvider.of<CommissioningCubit>(context).actionRequestRelaunch();
                }
              );
            }
          }
        },
        child: Container(),
      ),
    ];
  }


  @override
  void initState() {
    super.initState();

    _loadingDialog = LoadingDialog();

    Future.delayed(Duration.zero, () async {
      if (args != null && args?.calledFromFirstScreen == true) {
        BlocProvider.of<BleCommissioningCubit>(context).startPairingSensor();
      }
    });
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
}
