import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/autojoin_bloc_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class LaundryCenterEnterPasswordPage extends StatefulWidget {
  LaundryCenterEnterPasswordPage({Key? key}) : super(key: key);

  _LaundryCenterEnterPasswordPage createState() => _LaundryCenterEnterPasswordPage();
}

class _LaundryCenterEnterPasswordPage extends State<LaundryCenterEnterPasswordPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextFieldStatus _passwordTextFieldStatus = TextFieldStatus.empty;
  TextFieldStatus _geModuleTextFieldStatus = TextFieldStatus.empty;

  FocusNode _geModuleFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  var _acmPassword = "";
  var _moduleSsid = "";
  var loadingDialog = LoadingDialog();
  ScrollController _scrollController = new ScrollController();
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
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child:Component.componentMainImage(context,
                                ImagePath.LAUNDRY_CENTER_ENTER_PASSWORD)
                            ),
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
                              child: Component.componentGeModuleNameTextfield(
                                  context, 'GE_MODULE_ ', _geModuleFocusNode,
                                  (textFieldStatus) {
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
                                      style: textStyle_size_18_color_white()),
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
                            Component.componentPincodeTextfield(
                                context, _passwordFocusNode, (textFieldStatus) {
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
                      AutoJoinBlocListener.handleAutoJoinResponse(loadingDialog),
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
                                  .pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                            }
                          })
                    ],
                  );
                },
              ),
            ),
          ),
        )
    );
  }
}
