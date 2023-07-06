import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/autojoin_bloc_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/pin_code_text_field.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class DispenserEnterPasswordPage2 extends StatefulWidget {
  DispenserEnterPasswordPage2({Key? key}) : super(key: key);

  _DispenserEnterPasswordPage2 createState() => _DispenserEnterPasswordPage2();
}

class _DispenserEnterPasswordPage2 extends State<DispenserEnterPasswordPage2> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextFieldStatus _passwordTextFieldStatus = TextFieldStatus.empty;
  TextFieldStatus _geModuleTextFieldStatus = TextFieldStatus.empty;

  late TextEditingController _geModuleTextEditingController;
  late TextEditingController _passwordTextEditingController;

  FocusNode _geModuleFocusNode = FocusNode();

  ScrollController _scrollController = new ScrollController();

  var _acmPassword = "";
  var _moduleSsid = "";
  var loadingDialog = LoadingDialog();
  bool _isAutoJoinSupport = true;
  late Future<bool> _asyncFuncSupportAutojoin;

  var _shouldShowBottomPinCode = true;
  var _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _asyncFuncSupportAutojoin = CommissioningUtil.isSupportAutoJoin();

    _geModuleFocusNode.addListener(() {
      if (_geModuleFocusNode.hasFocus) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    _geModuleTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();

  }

  @override
  void dispose() {
    _isDisposed = true;
    _geModuleFocusNode.dispose();

    _geModuleTextEditingController.dispose();
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
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
              .setNavigationAppBar(context: context),
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
                            Component.componentMainImage(context,
                                ImagePath.APPLIANCE_INFORMATION_PASSWORD),
                            BaseComponent.heightSpace(16.h),
                            Visibility(
                              child: Component.componentDescriptionText(
                                  text: LocaleUtil.getString(context,
                                      LocaleUtil.APPLIANCE_NETWORK_INFO)!,
                                  marginInsets:
                                      EdgeInsets.symmetric(horizontal: 28.w)),
                              visible: _isAutoJoinSupport,
                            ),
                            Visibility(
                              child: BaseComponent.heightSpace(16.h),
                              visible: _isAutoJoinSupport,
                            ),
                            Visibility(
                              child: CommissioningPassword().getGEModuleNameTextField(
                                  context: context,
                                  title: LocaleUtil.getString(
                                      context, LocaleUtil.GE_MODULE_PREFIX),
                                  focusNode: _geModuleFocusNode,
                                  textEditingController: _geModuleTextEditingController,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.length == 4) {
                                        _geModuleTextFieldStatus = TextFieldStatus.equalToMaxLength;
                                      }
                                      else if (value.length != 0) {
                                        _geModuleTextFieldStatus = TextFieldStatus.notEmpty;
                                      }
                                      else {
                                        _geModuleTextFieldStatus = TextFieldStatus.empty;
                                      }
                                    });
                                  },
                                  onCompleted: (value) {
                                    _moduleSsid = value;
                                  }),
                              visible: _isAutoJoinSupport,
                            ),
                            Visibility(
                              child: BaseComponent.heightSpace(16.h),
                              visible: _isAutoJoinSupport,
                            ),
                            CustomRichText.customSpanListTextBox(
                                textSpanList: <TextSpan>[
                                  TextSpan(
                                      text: LocaleUtil.getString(context,
                                          LocaleUtil.ENTER_PASSWORD_TEXT_1),
                                      style: textStyle_size_18_color_white()),
                                  TextSpan(
                                      text: LocaleUtil.getString(context,
                                          LocaleUtil.ENTER_PASSWORD_TEXT_2),
                                      style: textStyle_size_18_color_yellow()),
                                  TextSpan(
                                      text: LocaleUtil.getString(context,
                                          LocaleUtil.ENTER_PASSWORD_TEXT_3),
                                      style: textStyle_size_18_color_white())
                                ]),
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
                                          BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
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
                              text: LocaleUtil.getString(
                                  context, LocaleUtil.ENTER_PASSWORD)!,
                              marginInsets:
                                  EdgeInsets.symmetric(horizontal: 28.w),
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
                                    _acmPassword = value;
                                  }),
                            ),
                          ],
                        ),
                      ),
                      AutoJoinBlocListener.handleAutoJoinResponse(loadingDialog, restartContinuousScan: true),
                      BleBlockListener.handleBlePairing(context: context),
                      Component.componentBottomButton(
                          isEnabled: (_passwordTextFieldStatus ==
                                  TextFieldStatus.equalToMaxLength) &&
                              (_geModuleTextFieldStatus ==
                                      TextFieldStatus.equalToMaxLength ||
                                  !_isAutoJoinSupport),
                          title:
                              LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                          onTapButton: () {
                            BlocProvider.of<CommissioningCubit>(context).actionSaveAcmPassword();
                            if (_isAutoJoinSupport) {
                              loadingDialog.show(
                                  context,
                                  LocaleUtil.getString(context,
                                      LocaleUtil.CONNECTING_TO_YOUR_APPLIANCE));

                              BlocProvider.of<CommissioningCubit>(context)
                                  .startProcessing(
                                      'GE_MODULE_$_moduleSsid', _acmPassword);
                            } else {
                              globals.subRouteName =
                                  Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(Routes.COMMON_MAIN_NAVIGATOR).then((_) =>
                                  BlocProvider.of<BleCommissioningCubit>(context).restartContinuousScanForAppliance());
                            }
                          })
                    ],
                  );
                },
              ),
            ),
          ),
        )
      )
    );
  }

}

