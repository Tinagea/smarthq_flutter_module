import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class CommissioningAddOtherNetwork extends StatefulWidget {
  @override
  _CommissioningAddOtherNetwork createState() => _CommissioningAddOtherNetwork();
}

class _CommissioningAddOtherNetwork extends State<CommissioningAddOtherNetwork> {

  late TextEditingController _ssidEditController;
  late TextEditingController _securityTypeEditController;
  late TextEditingController _passwordEditController;

  bool _isNetworkName = false;
  bool _isSecurityName = false;
  bool _isNetworkPassword = false;
  String securityName = '';

  late FocusNode _ssidFocusNode;
  late FocusNode _securityTypeFocusNode;
  late FocusNode _passwordFocusNode;

  ScrollController _scrollController = new ScrollController();

  late LoadingDialog _loadingDialog;
  Picker? _picker;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _ssidEditController = TextEditingController();
    _securityTypeEditController = TextEditingController();
    _passwordEditController = TextEditingController();

    _ssidFocusNode = FocusNode();
    _securityTypeFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _ssidFocusNode.addListener(() {
      if (_ssidFocusNode.hasFocus) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    _securityTypeFocusNode.addListener(() {
      if (_securityTypeFocusNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    _loadingDialog = LoadingDialog();

    Future.delayed(Duration(milliseconds: 400), () async {
      FocusScope.of(context).requestFocus(_ssidFocusNode);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _ssidFocusNode.dispose();
    _securityTypeFocusNode.dispose();
    _passwordFocusNode.dispose();

    _ssidEditController.dispose();
    _securityTypeEditController.dispose();
    _passwordEditController.dispose();

    _loadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_OTHER_NETWORK)).setNavigationAppBar(context: context),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Component.componentCommissioningBody(
                context,
                <Widget>[
                  BaseComponent.heightSpace(15.h),
                  Component.componentInformationText(text: LocaleUtil.getString(context, LocaleUtil.ENTER_NETWORK_NAME)!, marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                  BaseComponent.heightSpace(10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextField(
                      focusNode: _ssidFocusNode,
                      style: textStyle_size_30_color_yellow(),
                      decoration: new InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                          hintText: LocaleUtil.getString(context, LocaleUtil.NAME),
                          labelStyle: new TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          )
                      ),
                      onChanged: (text) {
                        setState(() {
                          _isNetworkName = (text.length > 0);
                        });
                      },
                      controller: _ssidEditController,
                      onTap: () {
                        _picker?.doCancel(context);
                      },
                    ),
                  ),
                  BaseComponent.heightSpace(15.h),
                  Component.componentInformationText(text: LocaleUtil.getString(context, LocaleUtil.SECURITY)!, marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                  BaseComponent.heightSpace(10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextField(
                      readOnly: true,
                      focusNode: _securityTypeFocusNode,
                      style: textStyle_size_30_color_yellow(),
                      onTap:() {
                        _picker = _showPicker(context);
                      },
                      decoration: new InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                          hintText: LocaleUtil.getString(context, LocaleUtil.SELECT_SECURITY_TYPE),
                          labelStyle: new TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          )
                      ),
                      onChanged: (text) {
                        setState(() {
                          _securityTypeEditController.text = '';
                        });
                      },
                      controller: _securityTypeEditController,
                    ),
                  ),
                  BaseComponent.heightSpace(15.h),
                  Component.componentInformationText(text: LocaleUtil.getString(context, LocaleUtil.ENTER_HOME_NETWORK_PASSWORD)!, marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                  BaseComponent.heightSpace(10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextField(
                      focusNode: _passwordFocusNode,
                      style: textStyle_size_30_color_yellow(),
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: new InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                          hintText: LocaleUtil.getString(context, LocaleUtil.PASSWORD),
                          labelStyle: new TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          )
                      ),
                      onChanged: (text) {
                        setState(() {
                          String? securityType;
                          String securityTypeName = _securityTypeEditController.text;
                          final isBleCommissioning = storage.savedStartByBleCommissioning;
                          if (isBleCommissioning!) {
                            securityType = BleCommissioningSecurityType.TYPE_MAP[securityTypeName];
                          }
                          else {
                            securityType = CommissioningSecurityType.TYPE_MAP[securityTypeName];
                          }
                          final eSecurityType = CommissioningUtil.getAPSecurityType(securityType!, isBleCommissioning);
                          geaLog.debug("sSecurityType: $eSecurityType");
                          if (eSecurityType == APSecurityType.openSecurity) {
                            _isNetworkPassword = true;
                            _passwordEditController.text = "";
                          }
                          else {
                            _isNetworkPassword = (text.length > 0);
                          }
                        });
                      },
                      controller: _passwordEditController,
                      onTap: () {
                        _picker?.doCancel(context);
                      },
                    ),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.NETWORK_STATUS_DISCONNECT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      _loadingDialog.close(context);
                      _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.RETRYING_TO_CONNECT_YOUR_APPLIANCE));
                      var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
                      bleCubit.initBleCommissioningNetworkListState();
                      bleCubit.actionRetryPairing();
                    },
                    child: Container(),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.RETRY_PAIRING_RESULT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      _loadingDialog.close(context);

                      if (state.isSuccess == true) {
                        Navigator.pop(context);
                      }
                      else {
                        DialogManager().showBleDisconnectedDialog(context: context, onYesPressed: () {
                          if (storage.savedStartByBleCommissioning == true) {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        });
                      }
                    },
                    child: Container(),
                  ),
                ],
                Component.componentBottomButton(
                    title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!,
                    isEnabled: _isNetworkName && _isNetworkPassword && _isSecurityName,
                    onTapButton: () {
                      String? securityType;
                      if (storage.savedStartByBleCommissioning == true) {
                        securityType = BleCommissioningSecurityType.TYPE_MAP[_securityTypeEditController.text];
                        var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
                        //TODO replace encrypt type from string
                        bleCubit.keepSsidNSecurityTypeNEncryptType(_ssidEditController.text, securityType, "");
                        bleCubit.actionBleSaveSelectedNetworkInformation(_passwordEditController.text);

                        bleCubit.keepSelectedIndex(-1);
                        bleCubit.actionBleSaveSelectedNetworkIndex();
                      }
                      else {
                        securityType = CommissioningSecurityType.TYPE_MAP[_securityTypeEditController.text];
                        var cubit = BlocProvider.of<CommissioningCubit>(context);
                        cubit.keepSsidNSecurityType(_ssidEditController.text, securityType);
                        cubit.actionSaveSelectedNetworkInformation(_passwordEditController.text);
                      }

                      Navigator.of(context).pushNamed(Routes.COMMON_COMMUNICATION_CLOUD_PAGE);
                    }
                ),
                scrollController: _scrollController
            ),
          ),
        )
    );
  }
  
  Picker? _showPicker(BuildContext context) {

    List<String>? securityTypeList;
    final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
    if (storage.savedStartByBleCommissioning == true) {
      securityTypeList = BleCommissioningSecurityTypeName.SecurityTypeList;
    }
    else {
      securityTypeList = CommissioningSecurityTypeName.SecurityTypeList;
    }

    String pickerData = jsonEncode(securityTypeList);
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(pickerData: JsonDecoder().convert(pickerData)),
        title: Text(LocaleUtil.getString(context, LocaleUtil.SELECT_SECURITY_TYPE)!.toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 15.0)),
        changeToFirst: false,
        textAlign: TextAlign.left,
        itemExtent: 40,
        confirmTextStyle: TextStyle(color: Colors.blue, fontSize: 15.0),
        cancelTextStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
        textStyle: TextStyle(color: Colors.black, fontSize: 20.0),
        selectedTextStyle: TextStyle(color: Colors.black, fontSize: 20.0),
        columnPadding: const EdgeInsets.all(8.0),
        height: 180.h,
        headerColor: Colors.white,
        containerColor: Colors.white,
        backgroundColor: Colors.white,
        confirmText: LocaleUtil.getString(context, LocaleUtil.SELECT),
        onCancel: () {
          _picker = null;
        },
        onConfirm: (Picker picker, List value) {
          String securityTypeName = picker.getSelectedValues().first;
          _securityTypeEditController.text = securityTypeName;
          _picker = null;

          setState(() {
            _isSecurityName = (securityTypeName.length > 0);

            String? securityType;
            final isBleCommissioning = storage.savedStartByBleCommissioning;
            if (isBleCommissioning!) {
              securityType = BleCommissioningSecurityType.TYPE_MAP[securityTypeName];
            }
            else {
              securityType = CommissioningSecurityType.TYPE_MAP[securityTypeName];
            }

            final eSecurityType = CommissioningUtil.getAPSecurityType(securityType!, isBleCommissioning);
            geaLog.debug("sSecurityType: $eSecurityType");

            if (eSecurityType == APSecurityType.openSecurity) {
              _isNetworkPassword = true;
              _passwordEditController.text = ""; // clear password

              DialogManager().showOpenSecurityWarningDialog(
                  context: context, onYesPressed: (){
                  });

            }
            else if (eSecurityType == APSecurityType.unknownSecurity) {
              final passwordText = _passwordEditController.text;
              _isNetworkPassword = (passwordText.length > 0);

              DialogManager().showUnknownSecurityWarningDialog(
                  context: context, onYesPressed: (){
              });

            }
            else if (eSecurityType == APSecurityType.weakSecurity) {
              final passwordText = _passwordEditController.text;
              _isNetworkPassword = (passwordText.length > 0);

              DialogManager().showWeakSecurityWarningDialog(
                  context: context, onYesPressed: (){
                  });

            }
            else {
              final passwordText = _passwordEditController.text;
              _isNetworkPassword = (passwordText.length > 0);
            }
          });
        }
    );

    final currentState = _scaffoldKey.currentState;
    if (currentState != null) {
      picker.show(currentState);
      return picker;
    } else {
      return null;
    }
  }
}
