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
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class GatewayPairSensorSuccessPage extends StatefulWidget {
  @override
  State createState() => _GatewayPairSensorSuccessPage();
}

class _GatewayPairSensorSuccessPage extends State<GatewayPairSensorSuccessPage> with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;
  late TextEditingController _nickNameTextEditingController;
  var _isDonePairing = true;

  @override
  void initState() {
    super.initState();
    _loadingDialog = LoadingDialog();
    _nickNameTextEditingController = TextEditingController();
    _nickNameTextEditingController.text = "Sensor";
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
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                  .toUpperCase())
              .setNavigationAppBar(context: context, leadingRequired: false, actionRequired: false),
          body: Component.componentCommissioningBody(
            context,
            <Widget>[
              Column(
                children: setBlocListeners(),
              ),
              BaseComponent.heightSpace(24.h),
              Component.componentMainImage(
                  context,
                  ImagePath.CONFIRM),
              BaseComponent.heightSpace(30.h),
              Component.componentTitleText(
                title: LocaleUtil.getString(context, LocaleUtil.SENSOR_IS_PAIRED_1)!,
                marginInsets: EdgeInsets.symmetric(horizontal: 30.w),
              ),
              BaseComponent.heightSpace(20.h),
              Component.componentDescriptionText(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.ENTER_A_NICKNAME_1)!,
                  marginInsets: EdgeInsets.symmetric(horizontal: 30.w)),
              // BaseComponent.heightSpace(2.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                child: TextField(
                  maxLength: 10,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                  enableSuggestions: false,
                  textAlign: TextAlign.left,
                  style: textStyle_size_24_color_yellow(),
                  controller: _nickNameTextEditingController,
                  decoration: InputDecoration(
                    hintText: 'Nickname',
                    hintStyle: textStyle_size_24_color_old_silver(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                        // style: BorderStyle.none
                      ),
                    ),
                  ),
                ),
              )
            ],
            Container(
                margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 60.w),
                child: Component.componentTwoBottomButton(
                    LocaleUtil.getString(context,
                        LocaleUtil.PAIR_MORE_SENSORS_1)!.toUpperCase(),
                    () {
                      _isDonePairing = false;
                      final nickname = _nickNameTextEditingController.text;
                      BlocProvider.of<BleCommissioningCubit>(context).postNickName(nickname);
                    },
                    LocaleUtil.getString(context,
                        LocaleUtil.DONE_PAIRING_1)!.toUpperCase(),
                    () {
                      _isDonePairing = true;
                      final nickname = _nickNameTextEditingController.text;
                      BlocProvider.of<BleCommissioningCubit>(context).postNickName(nickname);
                    })
            ),
          ),
        )
    );
  }

  List<Widget> setBlocListeners() {
    return [
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.SHOW_CLOUD_LOADING
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.COMMUNICATING_WITH_CLOUD));
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.HIDE_CLOUD_LOADING);
        },
        listener: (context, state) {
          _loadingDialog.close(context);
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.POST_NICKNAME_RESULT
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          if (state.isSuccessToPostNickName != null && state.isSuccessToPostNickName!) {
            if (_isDonePairing) {

              Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
              SystemNavigator.pop(animated: true);
              BlocProvider.of<CommissioningCubit>(context).actionCommissioningSuccessful();
              BlocProvider.of<BleCommissioningCubit>(context).actionSendUpdatedWifiLockerToCloud();

              BlocProvider.of<CommissioningCubit>(context).actionMoveToNativeBackPage();
              BlocProvider.of<CommissioningCubit>(context).actionRequestRelaunch();
            } else {

              BlocProvider.of<BleCommissioningCubit>(context).startPairingSensor();
            }
          }
        },
        child: Container(),
      ),
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
    ];
  }

}

