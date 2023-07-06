import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/pin_code_text_field.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class GrindBrewEnterPasswordPage extends StatefulWidget {
  GrindBrewEnterPasswordPage({Key? key}) : super(key: key);

  _GrindBrewEnterPasswordPage createState() => _GrindBrewEnterPasswordPage();
}

class _GrindBrewEnterPasswordPage extends State<GrindBrewEnterPasswordPage> {
  var onTapRecognizer;

  bool _buttonEnable = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    Future.delayed(Duration(milliseconds: 400), () async {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {

    _focusNode.dispose();
    _textEditingController.dispose();
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
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Component.componentMainImage(context,
                            ImagePath.WIFI_CONNECT_SCREEN),
                        BaseComponent.heightSpace(16.h),
                        CustomRichText.customSpanListTextBox(
                            textSpanList: <TextSpan>[
                              TextSpan(
                                  text: LocaleUtil.getString(
                                      context, LocaleUtil.ENTER_PASSWORD_TEXT_1),
                                  style: textStyle_size_18_color_white()),
                              TextSpan(
                                  text: LocaleUtil.getString(
                                      context, LocaleUtil.ENTER_PASSWORD_TEXT_2),
                                  style: textStyle_size_18_color_yellow()),
                              TextSpan(
                                  text: LocaleUtil.getString(
                                      context, LocaleUtil.FOUND_ON_YOUR_GRIND_BREW_DISPLAY),
                                  style: textStyle_size_18_color_white()),
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
                                }
                            ),
                            BaseComponent.heightSpace(90.h),
                          ],
                        ),
                        Component.componentDescriptionText(
                          text: LocaleUtil.getString(
                              context, LocaleUtil.ENTER_PASSWORD)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                        ),
                        CommissioningPassword().getPinCodeTextField(
                            context: context,
                            focusNode: _focusNode,
                            textEditingController: _textEditingController,
                            onChanged: (value) {
                              setState(() {
                                _buttonEnable = (value.length == 8);
                              });
                            },
                            onCompleted: (value) {
                              BlocProvider.of<CommissioningCubit>(context).keepACMPassword(value);
                            }),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      isEnabled: _buttonEnable,
                      title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                      onTapButton: () {
                        BlocProvider.of<CommissioningCubit>(context)
                            .actionSaveAcmPassword();
                        globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                      })
                ],
              ),
            ),
          ),
        )
    );
  }

}
