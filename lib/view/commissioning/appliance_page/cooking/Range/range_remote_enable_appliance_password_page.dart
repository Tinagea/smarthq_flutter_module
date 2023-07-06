import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/pin_code_text_field.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class PagePasswordRangeRemoteEnable extends StatefulWidget {
  PagePasswordRangeRemoteEnable({Key? key}) : super(key: key);

  _PagePasswordRangeRemoteEnable createState() => _PagePasswordRangeRemoteEnable();
}

class _PagePasswordRangeRemoteEnable extends State<PagePasswordRangeRemoteEnable> with WidgetsBindingObserver{

  TextFieldStatus _passwordTextFieldStatus = TextFieldStatus.empty;

  late TextEditingController _passwordTextEditingController;

  ScrollController _scrollController = new ScrollController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var loadingDialog = LoadingDialog();
  bool isAutoJoinSupport = true;
  var _shouldShowBottomPinCode = true;
  var _isDisposed = false;

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

    //todo restrict auto join as this module can have USI MODULE (GE_OVEN SSID)

    Future.delayed(Duration.zero, () {
      BlocProvider.of<CommissioningCubit>(context).actionCheckConnectedGeModuleWifi();
    });

    _passwordTextEditingController = TextEditingController();

  }

  @override
  void dispose() {
    _isDisposed = true;
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  void setVisibilityBottomPinCode(bool shouldShow) {
    if (_shouldShowBottomPinCode != shouldShow && !_isDisposed) {
      setState(() {
        _shouldShowBottomPinCode = shouldShow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
        onVisibilityGained: () {
          setVisibilityBottomPinCode(true);
          },
        onVisibilityLost: () {
          setVisibilityBottomPinCode(false);
          },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
            leftBtnFunction: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).popUntil((route) =>
              route.settings.name == globals.navigatorNameToBack
              );

              var routingContext = ContextUtil.instance.routingContext;
              if (routingContext != null) {
                Navigator.of(routingContext).popUntil((route) =>
                route.settings.name == Routes.RANGE_REMOTE_ENABLE_APPLIANCE_INFO
                );
              }
              },
          ).setNavigationAppBar(context: context),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: <Widget>[
                        Component.componentMainImage(context,
                            ImagePath.RANGE_HAIER_KNOB_APPLIANCE_PASSWORD_INFO),
                        BaseComponent.heightSpace(16.h),
                        CustomRichText
                            .customSpanListTextBox(textSpanList: <TextSpan>[
                          TextSpan(
                              text: LocaleUtil.getString(
                                  context, LocaleUtil.PASSWORD_ON_CONNECTED_APPLIANCE_LABEL),
                              style: textStyle_size_18_color_white()),
                        ]),
                        BaseComponent.heightSpace(16.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseComponent.heightSpace(17.h),
                            Component.componentQuestionText(
                                context: context,
                                marginInsets:
                                EdgeInsets.symmetric(horizontal: 33.w),
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .CAN_NOT_FIND_PASSWORD_BUT_UPD_ID)!,
                                onTap: () {
                                  BlocProvider.of<BleCommissioningCubit>(context)
                                      .actionDirectBleDeviceState()
                                      .then((bleState) {
                                    if (bleState == 'on') {
                                      Navigator.of(context, rootNavigator: true).pop();
                                      Navigator.of(context, rootNavigator: true).popUntil((route) =>
                                      route.settings.name == globals.navigatorNameToBack
                                      );

                                      var routingContext = ContextUtil.instance.routingContext;
                                      if (routingContext != null) {
                                        Navigator.of(routingContext).popUntil((route) =>
                                        route.settings.name == globals.routeNameToBack
                                        );
                                      }
                                    } else {
                                      DialogManager().showBleBluetoothEnableAlertDialog(context: context);
                                    }
                                  });
                                }),
                            BaseComponent.heightSpace(16.h),
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                        Component.componentDescriptionText(
                          text: LocaleUtil.getString(context, LocaleUtil.ENTER_PASSWORD)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                        ),
                        Visibility(
                          visible: _shouldShowBottomPinCode,
                          child: CommissioningPassword().getPinCodeTextField1(
                              context: context,
                              textEditingController: _passwordTextEditingController,
                              onChanged: (value) {
                                setState(() {
                                  if (value.length == 8) {
                                    _passwordTextFieldStatus = TextFieldStatus.equalToMaxLength;
                                  }
                                  else if (value.length != 0) {
                                    _passwordTextFieldStatus = TextFieldStatus.notEmpty;
                                  }
                                  else {
                                    _passwordTextFieldStatus = TextFieldStatus.empty;
                                  }
                                });
                              },
                              onCompleted: (value) {
                                BlocProvider.of<CommissioningCubit>(context)
                                    .keepACMPassword(value);
                              }),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<CommissioningCubit, CommissioningState> (
                      listenWhen: (previous, current) {
                        return (current.stateType == CommissioningStateType.COMMUNICATION_DATA) ||
                            (current.stateType == CommissioningStateType.CONNECTED_MODULE);
                      },
                      listener: (context, state) {
                        geaLog.debug('Check Data1:');
                        loadingDialog.close(context);

                        if (state.stateType == CommissioningStateType.CONNECTED_MODULE) {
                          if (state.failReason != null && state.failReason == -1) {
                            BlocProvider.of<CommissioningCubit>(context)
                                .actionRequestGeModuleReachability(false);
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        }
                        else if (state.stateType == CommissioningStateType.COMMUNICATION_DATA) {
                          geaLog.debug('Check Data4');
                          if (state.isSuccessCommunicatingWithWifiModule == true) {
                            globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                            Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                          }
                          else {
                            var baseDialog = CommonBaseAlertDialog(
                                context: context,
                                title: LocaleUtil.getString(context, LocaleUtil.OOPS),
                                content: LocaleUtil.getString(context, LocaleUtil.WRONG_WIFI_PASSWORD_MESSAGE),
                                yesOnPressed: () {},
                                yesString: LocaleUtil.getString(context, LocaleUtil.CANCEL)
                            );
                              showDialog(context: context, builder: (context) => baseDialog);
                          }
                        }
                      },
                      buildWhen: (previous, current) {
                        return (current.stateType == CommissioningStateType.CONNECTED_MODULE);
                      },
                      builder: (context, state) {
                        return Component.componentBottomButton(
                            title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                            isEnabled: (state.isConnectedGeWifiModule == null
                                ? false
                                : state.isConnectedGeWifiModule!) && (_passwordTextFieldStatus ==
                                TextFieldStatus.equalToMaxLength),
                            onTapButton: () {
                              BlocProvider.of<CommissioningCubit>(context)
                                  .actionSaveAcmPassword();
                              loadingDialog.show(context, LocaleUtil.getString(
                                  context, LocaleUtil.COMMUNICATING_WITH_YOUR_APPLIANCE));

                              BlocProvider.of<CommissioningCubit>(context)
                                  .actionRequestCommissioningData();
                            });
                      }),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}