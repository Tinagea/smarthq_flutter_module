import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class CommissioningWifiConnectionPage extends StatefulWidget {
  @override
  _CommissioningWifiConnectionPage createState() =>
      _CommissioningWifiConnectionPage();
}

class _CommissioningWifiConnectionPage extends State<CommissioningWifiConnectionPage> with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;
  bool _isUsiType = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent))
      return;

    if (state == AppLifecycleState.resumed){
      // user returned to our app
      BlocProvider.of<CommissioningCubit>(context).actionCheckConnectedGeModuleWifi();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadingDialog = LoadingDialog();
    checkPermission();

    Future.delayed(Duration.zero, () {
      BlocProvider.of<CommissioningCubit>(context).actionCheckConnectedGeModuleWifi();
    });
  }


  @override
  void deactivate() {
    super.deactivate();
    _loadingDialog.close(context);
  }

  Future<void> checkPermission() async {
    geaLog.debug('Checking permissions');
    if (Platform.isAndroid) {
      var status = await Permission.location.status;
      // Blocked?
      if (status.isDenied || status.isRestricted) {
        // Ask the user to unblock
        geaLog.debug('permission Ask the user to unblock');
        if (await Permission.location.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          geaLog.debug('Location permission granted');
          BlocProvider.of<CommissioningCubit>(context)
              .actionRequestGeModuleReachability(true);
        } else {
          geaLog.debug('Location permission not granted');
        }
      } else {
        geaLog.debug('Permission already granted (previous execution?)');
        BlocProvider.of<CommissioningCubit>(context)
            .actionRequestGeModuleReachability(true);
      }
    } else {
      BlocProvider.of<CommissioningCubit>(context)
          .actionRequestGeModuleReachability(true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storage = RepositoryProvider.of<WifiCommissioningStorage>(context);
    if (storage.isUsiType != null && storage.isUsiType == true) {
      _isUsiType = true;
    }
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
            leftBtnFunction: () {
              if (globals.routeNameToBack == Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_3) {
                BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
              }
              BlocProvider.of<CommissioningCubit>(context).actionRequestGeModuleReachability(false);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ).setNavigationAppBar(context: context),
          body: Component.componentCommissioningBody(
              context,
              <Widget>[
                Component.componentMainPngImage(context, !_isUsiType ? ImagePath.WIFI_SELECTION : ImagePath.WIFI_SELECTION_USI),
                BaseComponent.heightSpace(50.h),
                Component.componentDescriptionTextSpanWithBox(
                  textSpan: [
                    TextSpan(
                        text: LocaleUtil.getString(
                            context, LocaleUtil.WIFI_SETTING_EXPLAIN_1)),
                    TextSpan(
                        text: LocaleUtil.getString(
                            context, LocaleUtil.WIFI_SETTING_EXPLAIN_2),
                        style: textStyle_size_18_color_yellow()),
                    TextSpan(
                        text: LocaleUtil.getString(
                            context, LocaleUtil.WIFI_SETTING_EXPLAIN_3)),
                    TextSpan(
                        text: LocaleUtil.getString(
                            context, !_isUsiType ? LocaleUtil.WIFI_SETTING_EXPLAIN_4 : LocaleUtil.WIFI_SETTING_EXPLAIN_6),
                        style: textStyle_size_18_color_yellow()),
                    TextSpan(
                        text: LocaleUtil.getString(
                            context, LocaleUtil.WIFI_SETTING_EXPLAIN_5)),
                  ],
                  marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                BaseComponent.heightSpace(25.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: Component.componentQuestionText(
                      context: context,
                      pushName: Routes.SHOW_ME_HOW_MAIN_NAVIGATOR,
                      useRootNavigator: true,
                      text: LocaleUtil.getString(
                          context, LocaleUtil.SHOW_ME_HOW)!),
                ),
              ],
              BlocConsumer<CommissioningCubit, CommissioningState> (
                  listenWhen: (previous, current) {
                    return (current.stateType == CommissioningStateType.COMMUNICATION_DATA) ||
                        (current.stateType == CommissioningStateType.CONNECTED_MODULE) || (current.stateType == CommissioningStateType.CHECK_CONNECTED_GE_MODULE_SSID);
                  },
                  listener: (context, state) {
                    geaLog.debug('Check Data1:');
                    _loadingDialog.close(context);
                    if (state.stateType == CommissioningStateType.CONNECTED_MODULE) {
                        if (state.failReason != null && state.failReason == -1) {
                          if (globals.routeNameToBack == Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_3) {
                            BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
                          } // stop only when previous page is initiating fresh ble background scan
                          BlocProvider.of<CommissioningCubit>(context)
                              .actionRequestGeModuleReachability(false);
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                    } else if (state.stateType == CommissioningStateType.COMMUNICATION_DATA) {
                      geaLog.debug('Check Data4');
                      if (state.isSuccessCommunicatingWithWifiModule == true) {
                        BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan(); // Reason to stop BLE bg scan: If control reaches here that means user already connected to wifi
                        Navigator.of(context).pushNamed(Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE);
                      } else {
                        var baseDialog = CommonBaseAlertDialog(
                            context: context,
                            title: LocaleUtil.getString(context, LocaleUtil.OOPS),
                            content: LocaleUtil.getString(context, LocaleUtil.WRONG_WIFI_PASSWORD_MESSAGE),
                            yesOnPressed: () {
                              Navigator.of(context).pushNamed(Routes.COMMON_WRONG_PASSWORD_PAGE);
                            },
                            yesString: LocaleUtil.getString(context, LocaleUtil.OK));
                        showDialog(context: context, builder: (context) => baseDialog);
                      }
                    } else if ((state.stateType == CommissioningStateType.CHECK_CONNECTED_GE_MODULE_SSID)) {
                      storage.setUsiType = false;
                      final connectedSsid = state.connectedGeModuleSsid!;
                      if (connectedSsid.startsWith("GE_OVEN")) {
                          _loadingDialog.show(context, LocaleUtil.getString(
                              context, LocaleUtil.COMMUNICATING_WITH_YOUR_APPLIANCE));

                          BlocProvider.of<CommissioningCubit>(context)
                              .actionRequestCommissioningData();

                      } else {
                        if (globals.routeNameToBack == Routes.RANGE_REMOTE_ENABLE_DESCRIPTION) {
                          globals.subRouteName = Routes.RANGE_REMOTE_ENABLE_PASSWORD_PAGE;
                          Navigator.of(context, rootNavigator: true).pushNamed(Routes.RANGE_MAIN_NAVIGATOR);
                        } else if (globals.routeNameToBack == Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_ONE) {
                          globals.subRouteName = Routes.WALL_OVEN_PRIMARY_TYPE_2_REMOTE_ENABLE_PASSWORD;
                          Navigator.of(context, rootNavigator: true).pushNamed(Routes.WALL_OVEN_MAIN_NAVIGATOR);
                        } else if (globals.routeNameToBack == Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_3) {
                          globals.subRouteName = Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_PASSWORD;
                          Navigator.of(context, rootNavigator: true).pushNamed(Routes.WALL_OVEN_MAIN_NAVIGATOR);
                        }
                      }
                    }
                  },
                  buildWhen: (previous, current) {
                    return (current.stateType == CommissioningStateType.CONNECTED_MODULE);
                  },
                  builder: (context, state) {
                    return Component.componentBottomButton(
                        title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                        isEnabled: state.isConnectedGeWifiModule == null
                            ? false
                            : state.isConnectedGeWifiModule!,
                        onTapButton: () {

                          if(_isUsiType) {
                            BlocProvider.of<CommissioningCubit>(context).checkConnectedGeModuleSsid();
                          } else {
                            _loadingDialog.show(context, LocaleUtil.getString(
                                context, LocaleUtil.COMMUNICATING_WITH_YOUR_APPLIANCE));

                            BlocProvider.of<CommissioningCubit>(context)
                                .actionRequestCommissioningData();
                          }
                        });
                  })),
        ));
  }
}