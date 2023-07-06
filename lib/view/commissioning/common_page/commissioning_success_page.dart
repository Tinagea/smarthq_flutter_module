import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class CommissioningSuccessPage extends StatefulWidget {
  @override
  State createState() => _CommissioningSuccessPage();
}

class _CommissioningSuccessPage extends State<CommissioningSuccessPage>
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
    final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
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
                      globals.subRouteName = Routes.GATEWAY_PAIR_SENSOR_DESCRIPTION_PAGE;
                      Navigator.of(context, rootNavigator: true).pushNamed(Routes.GATEWAY_MAIN_NAVIGATOR);
                    }
                    else {
                      DialogManager().showFailToStartPairingDialog(context: context);
                    }
                  }
                },
                child: Container(),
              ),
              Component.componentMainImage(
                  context,
                  ImagePath.CONFIRM),
              BaseComponent.heightSpace(30.h),
              Component.componentTitleText(
                title: LocaleUtil.getString(context,
                    storage.applianceType != ApplianceType.GATEWAY
                        ? LocaleUtil.CONGRATULATIONS_YOU_ARE_ALL_SET
                        : LocaleUtil.CONGRATULATIONS_YOUR_GATEWAY_IS_CONNECTED)!,
                marginInsets: EdgeInsets.symmetric(horizontal: 30.w),
              ),
              BaseComponent.heightSpace(20.h),
              Visibility(
                visible: storage.applianceType == ApplianceType.GATEWAY,
                child: Component.componentDescriptionText(
                    text: LocaleUtil.getString(
                    context, LocaleUtil.LETS_PAIR_YOUR_SENSORS_NEXT)!,
                    marginInsets: EdgeInsets.symmetric(horizontal: 30.w))),
            ],
            Container(
              margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 60.w),
              child: Component.componentTwoBottomButton(
                  LocaleUtil.getString(context,
                      storage.applianceType == ApplianceType.GATEWAY
                          ? LocaleUtil.PAIR_SENSORS
                          : LocaleUtil.GET_STARTED)!.toUpperCase(),
                  () {
                    if (storage.applianceType == ApplianceType.GATEWAY) {
                      BlocProvider.of<BleCommissioningCubit>(context).startPairingSensor();
                    } else {
                      Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
                      BlocProvider.of<CommissioningCubit>(context).actionCommissioningSuccessful();
                      BlocProvider.of<BleCommissioningCubit>(context).actionSendUpdatedWifiLockerToCloud();
                    }
                  },
                  showButton2: storage.applianceType == ApplianceType.GATEWAY,
                  LocaleUtil.getString(context,
                      LocaleUtil.DONE_PAIRING_1)!.toUpperCase(),
                  () {
                    Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
                    SystemNavigator.pop(animated: true);
                    BlocProvider.of<CommissioningCubit>(context).actionCommissioningSuccessful();
                    BlocProvider.of<BleCommissioningCubit>(context).actionSendUpdatedWifiLockerToCloud();

                    BlocProvider.of<CommissioningCubit>(context).actionMoveToNativeBackPage();
                    BlocProvider.of<CommissioningCubit>(context).actionRequestRelaunch();
                  }
              ),
            )
          ),
        )
    );
  }
}
