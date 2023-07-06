import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class CommissioningChooseHomeNetwork extends StatefulWidget {
  @override
  _CommissioningChooseHomeNetwork createState() => _CommissioningChooseHomeNetwork();
}

class _CommissioningChooseHomeNetwork extends State<CommissioningChooseHomeNetwork> {

  late FocusNode _focusNode;
  late LoadingDialog _loadingDialog;
  late TextEditingController _textEditController;

  late ScrollController _scrollController;

  bool _buttonEnable = false;
  bool _shouldRememberNetwork = false;
  bool _isObscurePassword = true;
  bool _isWifiLockerSupported = false;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _loadingDialog = LoadingDialog();
    _textEditController = TextEditingController();

    _scrollController = ScrollController();

    Future.delayed(Duration.zero, () async {
      setState(() {
        BlocProvider.of<BleCommissioningCubit>(context)
            .actionGetIsWifiLockerAvailable()
            .then((value) {
          _isWifiLockerSupported = value;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _focusNode.dispose();
    _textEditController.dispose();
    _scrollController.dispose();

    _loadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    String? wifiList = ModalRoute.of(context)?.settings.arguments as String?;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
              .setNavigationAppBar(context: context),
          body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Component.componentCommissioningBody(
                context,
                <Widget>[
                  Component.componentMainImage(
                      context,
                      ImagePath.WIFI_ROUTER),
                  BaseComponent.heightSpace(16.h),
                  Component.componentDescriptionTextSpanWithBox(
                    textSpan: [
                      TextSpan(text: LocaleUtil.getString(context, LocaleUtil.ENTER_PASSWORD_FOR)),
                      TextSpan(
                          text: wifiList,
                          style: textStyle_size_18_color_yellow()),
                    ],
                    marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  BaseComponent.heightSpace(86.h),
                  Component.componentDescriptionText(
                      text: LocaleUtil.getString(context, LocaleUtil.ENTER_PASSWORD)!,
                      marginInsets: EdgeInsets.symmetric(horizontal: 30.w)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextField(
                      focusNode: _focusNode,
                      style: textStyle_size_30_color_yellow(),
                      obscureText: _isObscurePassword,
                      obscuringCharacter: "*",
                      autofocus: false,
                      decoration: new InputDecoration(
                          labelStyle: new TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey),
                            onPressed: (){
                              setState(() {
                                _isObscurePassword = !_isObscurePassword;
                              });
                            },
                          )
                      ),
                      onChanged: (text) {
                        setState(() {
                          _buttonEnable = (text.length > 0);
                        });
                      },
                      controller: _textEditController,
                    ),
                  ),
                  Visibility(
                      visible: (_isWifiLockerSupported),
                      child: Column(
                        children: [
                          BaseComponent.heightSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_shouldRememberNetwork) {
                                      _shouldRememberNetwork = false;
                                    } else {
                                      _shouldRememberNetwork = true;
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Component.componentCheckIcon(_shouldRememberNetwork),
                                    Text(
                                        LocaleUtil.getString(context, LocaleUtil.REMEMBER_THIS_NETWORK)!,
                                        style: textStyle_size_12_color_old_silver()
                                    ),
                                  ],
                                ),
                              ),
                              BaseComponent.widthSpace(10.w),
                              GestureDetector(
                                onTap: () {
                                  DialogManager().showRememberThisNetworkDialog(context);
                                },
                                child: Component.componentInfoIcon(),
                              )
                            ],
                          ),
                        ],
                      )
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
                          final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
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
                    isEnabled: _buttonEnable,
                    onTapButton: () {

                      final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
                      if (storage.savedStartByBleCommissioning == true) {
                        var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
                        bleCubit.actionBleSaveSelectedNetworkInformation(_textEditController.text);
                        bleCubit.actionSaveSelectedNetwork(_shouldRememberNetwork, _textEditController.text);
                        bleCubit.actionBleSaveSelectedNetworkIndex();
                      }
                      else {
                        var commissioningCubit = BlocProvider.of<CommissioningCubit>(context);
                        commissioningCubit.actionSaveSelectedNetworkInformation(_textEditController.text);

                        final ssid = commissioningCubit.actionGetKeptSsid();
                        final securityType = commissioningCubit.actionGetKeptSecurityType();

                        BlocProvider.of<BleCommissioningCubit>(context).actionSaveNetwork(_shouldRememberNetwork, ssid, _textEditController.text, securityType);
                      }

                      Navigator.of(context).pushNamed(Routes.COMMON_COMMUNICATION_CLOUD_PAGE);
                    }
                ),
                scrollController: _scrollController
              )
          ),
        )
    );
  }
}
