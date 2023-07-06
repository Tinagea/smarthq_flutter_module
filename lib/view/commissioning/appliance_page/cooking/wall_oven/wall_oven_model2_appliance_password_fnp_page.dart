/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/pin_code_text_field.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenModel2AppliancePasswordFnpPage extends StatefulWidget {
  WallOvenModel2AppliancePasswordFnpPage({Key? key}) : super(key: key);

  _WallOvenModel2AppliancePasswordFnpPageState createState() => _WallOvenModel2AppliancePasswordFnpPageState();
}

class _WallOvenModel2AppliancePasswordFnpPageState extends State<WallOvenModel2AppliancePasswordFnpPage> {
  var onTapRecognizer;

  late TextEditingController _passwordTextEditingController;
  var _shouldShowBottomPinCode = true;
  var _isDisposed = false;
  TextFieldStatus _passwordTextFieldStatus = TextFieldStatus.empty;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
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
                        BleBlockListener.handleBlePairing(context: context),
                        Component.componentMainImage(context,
                            ImagePath.COOKING_WALL_OVEN_FNP_MODEL1_PASSWORD),
                        BaseComponent.heightSpace(36.h),
                        CustomRichText.customSpanListTextBox(
                            textSpanList: <TextSpan>[
                              TextSpan(
                                  text: LocaleUtil.getString(
                                      context, LocaleUtil.ENTER_PASSWORD_WALL_OVEN_TFT),
                                  style: textStyle_size_18_color_white()),
                            ]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseComponent.heightSpace(17.h),
                            Center(
                              child: Component.componentQuestionText(
                                  context: context,
                                  marginInsets: EdgeInsets.symmetric(horizontal: 33.w),
                                  text: LocaleUtil.getString(context, LocaleUtil.CAN_NOT_FIND_PASSWORD)!,
                                  alignText: TextAlign.left,
                                  onTap: () {
                                    BlocProvider.of<BleCommissioningCubit>(context)
                                        .actionDirectBleDeviceState()
                                        .then((bleState) {
                                      if (bleState == 'on') {
                                        // Stop BLE scan before going back
                                        BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
                                        // Since route is known, not using routeNameToBack
                                        Navigator.of(context)
                                            .popUntil((route) => route.settings.name == Routes.WALL_OVEN_MODEL_2_STEP_4_FNP);
                                      } else {
                                        DialogManager().showBleBluetoothEnableAlertDialog(context: context);
                                      }
                                    });
                                  }
                              ),
                            ),
                            BaseComponent.heightSpace(80.h),
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                        Component.componentDescriptionText(
                          text: LocaleUtil.getString(
                              context, LocaleUtil.ENTER_PASSWORD)!,
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
                  Component.componentBottomButton(
                      isEnabled: _passwordTextFieldStatus == TextFieldStatus.equalToMaxLength,
                      title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!,
                      onTapButton: () {
                        BlocProvider.of<CommissioningCubit>(context)
                            .actionSaveAcmPassword();
                        globals.subRouteName =
                            Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(Routes.COMMON_MAIN_NAVIGATOR)
                            .then((_) =>
                                BlocProvider.of<BleCommissioningCubit>(context)
                                    .restartContinuousScanForAppliance());
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
