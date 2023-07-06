import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class ConnectPlusEnterPasswordPage extends StatefulWidget {
  ConnectPlusEnterPasswordPage({Key? key}) : super(key: key);

  _ConnectPlusEnterPasswordPage createState() => _ConnectPlusEnterPasswordPage();
}

class _ConnectPlusEnterPasswordPage extends State<ConnectPlusEnterPasswordPage> {
  var onTapRecognizer;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextFieldStatus _passwordTextFieldStatus = TextFieldStatus.empty;
  TextFieldStatus _geModuleTextFieldStatus = TextFieldStatus.empty;

  FocusNode _geModuleFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  ScrollController _scrollController = new ScrollController();

  var _acmPassword = "";
  var _moduleSsid = "";
  late var _loadingDialog;
  bool _isAutoJoinSupport = true;
  late Future<bool> _asyncFuncSupportAutojoin;

  @override
  void initState() {
    super.initState();

    _asyncFuncSupportAutojoin = CommissioningUtil.isSupportAutoJoin();

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    _geModuleFocusNode.addListener(() {
      if (_geModuleFocusNode.hasFocus) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    _loadingDialog = LoadingDialog();
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ConnectPlusPasswordPage.deactivate');

    _loadingDialog.close(context);
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _geModuleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)).setNavigationAppBar(context: context),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: FutureBuilder(
                future: _asyncFuncSupportAutojoin,
                initialData: _isAutoJoinSupport,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      _isAutoJoinSupport = snapshot.data as bool;
                    }
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children: <Widget>[
                            Component.componentMainImage(context, ImagePath.CONNECT_PLUS_START),
                            BaseComponent.heightSpace(16.h),
                            Visibility(
                              child: Component.componentDescriptionText(
                                  text: LocaleUtil.getString(context, LocaleUtil.APPLIANCE_NETWORK_INFO)!, marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                              visible: _isAutoJoinSupport,
                            ),
                            Visibility(
                              child: BaseComponent.heightSpace(16.h),
                              visible: _isAutoJoinSupport,
                            ),
                            Visibility(
                              child: Component.componentGeModuleNameTextfield(context, 'GE_MODULE_ ', _geModuleFocusNode, (textFieldStatus) {
                                setState(() {
                                  _geModuleTextFieldStatus = textFieldStatus;
                                });
                              }, (textValue) {
                                _moduleSsid = textValue;
                              }),
                              visible: _isAutoJoinSupport,
                            ),
                            Visibility(
                              child: BaseComponent.heightSpace(16.h),
                              visible: _isAutoJoinSupport,
                            ),
                            CustomRichText.customSpanListTextBox(textSpanList: <TextSpan>[
                              TextSpan(text: LocaleUtil.getString(context, LocaleUtil.ENTER_PASSWORD_TEXT_1), style: textStyle_size_18_bold_color_white()),
                              TextSpan(text: LocaleUtil.getString(context, LocaleUtil.ENTER_PASSWORD_TEXT_2), style: textStyle_size_18_bold_color_yellow()),
                              TextSpan(text: LocaleUtil.getString(context, LocaleUtil.FOUND_ON_THE_BACK_OF_CONNECT_PLUS), style: textStyle_size_18_bold_color_white())
                            ]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseComponent.heightSpace(17.h),
                                Component.componentQuestionText(
                                    context: context,
                                    marginInsets: EdgeInsets.symmetric(horizontal: 33.w),
                                    text: LocaleUtil.getString(context, LocaleUtil.CAN_NOT_FIND_PASSWORD_BUT_UPD_ID)!,
                                    onTap: () {
                                      BlocProvider.of<BleCommissioningCubit>(context)
                                          .actionDirectBleDeviceState()
                                          .then((bleState) {
                                        if (bleState == 'on') {
                                          Navigator.of(context)
                                              .popUntil((route) => route.settings.name == globals.routeNameToBack);
                                        } else {
                                          DialogManager().showBleBluetoothEnableAlertDialog(context: context);
                                        }
                                      });
                                    }),
                                BaseComponent.heightSpace(90.h),
                              ],
                            ),
                            Component.componentDescriptionText(
                              text: LocaleUtil.getString(context, LocaleUtil.ENTER_PASSWORD)!,
                              marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                            ),
                            Component.componentPincodeTextfield(context, _passwordFocusNode, (textFieldStatus) {
                              setState(() {
                                _passwordTextFieldStatus = textFieldStatus;
                              });
                            }, (textValue) {
                              BlocProvider.of<CommissioningCubit>(context).keepACMPassword(textValue);
                              _acmPassword = textValue;
                            }),
                          ],
                        ),
                      ),
                      BlocListener<CommissioningCubit, CommissioningState>(
                        listenWhen: (previous, current) {
                          return current.stateType == CommissioningStateType.AUTO_JOIN &&
                              RepositoryProvider.of<BleCommissioningStorage>(context).applianceType != ApplianceType.DISHWASHER;
                        },
                        listener: (context, state) {
                          if (state.stateType == CommissioningStateType.AUTO_JOIN) {
                            if (state.autoJoinStatusType != null) {
                              _loadingDialog.close(context);
                              if (state.autoJoinStatusType == AutoJoinStatusType.success) {
                                geaLog.debug("auto join success");
                                globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                                Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                              } else if (state.autoJoinStatusType == AutoJoinStatusType.fail || state.autoJoinStatusType == AutoJoinStatusType.unSupport) {
                                geaLog.debug("auto join failed or unsupported");
                                var autoConnectFailDialog = CommonBaseAlertDialog(
                                    context: context,
                                    title: LocaleUtil.getString(context, LocaleUtil.OOPS),
                                    content: LocaleUtil.getString(context, LocaleUtil.AUTO_JOIN_FAILED_TRY_MANUALLY),
                                    yesOnPressed: () {
                                      globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                                      Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                                    },
                                    yesString: LocaleUtil.getString(context, LocaleUtil.OK));
                                showDialog(context: context, builder: (context) => autoConnectFailDialog);
                              }
                            }
                          }
                        },
                        child: Container(),
                      ),
                      Component.componentBottomButton(
                          isEnabled: (_passwordTextFieldStatus == TextFieldStatus.equalToMaxLength) &&
                              (_geModuleTextFieldStatus == TextFieldStatus.equalToMaxLength || !_isAutoJoinSupport),
                          title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                          onTapButton: () {
                            BlocProvider.of<CommissioningCubit>(context).actionSaveAcmPassword();
                            if (RepositoryProvider.of<BleCommissioningStorage>(context).applianceType == ApplianceType.DISHWASHER) {
                              BlocProvider.of<CommissioningCubit>(context).keepAcmSSID(_moduleSsid);
                              Navigator.of(context).pushNamed(Routes.CONNECT_PLUS_DISH_REMOVE_BOTTOM_PAGE);
                            } else {
                              if (_isAutoJoinSupport) {
                                _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.CONNECTING_TO_YOUR_APPLIANCE));
                                BlocProvider.of<CommissioningCubit>(context).startProcessing('GE_MODULE_$_moduleSsid', _acmPassword);
                              } else {
                                globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                                Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                              }
                            }
                          })
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
