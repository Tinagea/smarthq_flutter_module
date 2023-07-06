import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/network_data_item.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class CommissioningEditSavedNetwork extends StatefulWidget {
  @override
  _CommissioningEditSavedNetwork createState() => _CommissioningEditSavedNetwork();
}

class _CommissioningEditSavedNetwork extends State<CommissioningEditSavedNetwork> {

  late FocusNode _focusNode;
  late TextEditingController _textEditController;

  bool _buttonEnable = false;
  bool _isObscurePassword = true;
  NetworkDataItem? _wifiNetwork;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _textEditController = TextEditingController();

    Future.delayed(Duration(milliseconds: 400), () async {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    Future.delayed(Duration.zero, () {
      _wifiNetwork = BlocProvider.of<BleCommissioningCubit>(context)
          .actionFetchNetworkForEditing();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _wifiNetwork = BlocProvider.of<BleCommissioningCubit>(context).actionFetchNetworkForEditing();
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.EDIT_SAVED_NETWORK),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: false).pop();
                },
              isRightButtonShown: false
          ).setNavigationAppBar(context: context),
          body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Component.componentCommissioningBodyWithBottomItem(
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
                            text:  _wifiNetwork?.ssid ?? "",
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
                          }); },
                        controller: _textEditController,
                      ),
                    ),
                  ],
                  Component.componentBottomButton(
                    title: LocaleUtil.getString(context, LocaleUtil.SAVE)!,
                    isEnabled: _buttonEnable,
                    onTapButton: () {
                      BlocProvider.of<BleCommissioningCubit>(context).actionUpdateNetwork(_wifiNetwork, _textEditController.text);
                      Navigator.pop(context);
                    }),

                  Component.componentDescriptionTextWithLinkAction(
                      contents: LocaleUtil.getString(context, LocaleUtil.REMOVE_THIS_SAVED_NETWORK)!,
                      contentsForLink: LocaleUtil.getString(context, LocaleUtil.REMOVE_THIS_SAVED_NETWORK)!,
                      btnFunction: (){
                        DialogManager().showRemoveNetworkDialog(context: context, onOkPressed: () {
                          BlocProvider.of<BleCommissioningCubit>(context).actionRemoveNetwork(_wifiNetwork);
                          Navigator.pop(context);
                        });
                      })
              )
          ),
        )
    );
  }
}
