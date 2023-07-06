/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/pin_code_text_field.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class RangeAppliancePasswordFnpPage extends StatefulWidget {
  const RangeAppliancePasswordFnpPage({Key? key}) : super(key: key);

  @override
  State<RangeAppliancePasswordFnpPage> createState() => _RangeAppliancePasswordFnpPageState();
}

class _RangeAppliancePasswordFnpPageState extends State<RangeAppliancePasswordFnpPage> {

  late TextEditingController _passwordTextEditingController;
  var _shouldShowBottomPinCode = true;
  var _isDisposed = false;
  TextFieldStatus _passwordTextFieldStatus = TextFieldStatus.empty;

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
    child: Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!,
        leftBtnFunction: () {
          Navigator.of(context).pop();
        },
      ).setNavigationAppBar(context: context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Component.componentMainImage(context,
                          ImagePath.COOKING_RANGE_FNP_MODEL_1_PASSWORD),
                    ),
                    CustomRichText.customSpanListTextBox(
                      textSpanList: <TextSpan>[
                        TextSpan(
                            text: LocaleUtil.getString(
                                context,
                                LocaleUtil
                                    .ENTER_THE_PASSWORD_FOUND_ON_YOUR_WALL_OVEN_DISPLAY),
                            style: textStyle_size_18_color_white()),
                      ],
                    ),
                  ],
                ),
              ),
              Component.componentDescriptionText(
                text: LocaleUtil.getString(context, LocaleUtil.ENTER_PASSWORD)!,
                marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
              ),
              BaseComponent.heightSpace(16.h),
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
              Component.componentBottomButton(
                isEnabled: _passwordTextFieldStatus == TextFieldStatus.equalToMaxLength,
                title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                onTapButton: () {
                  BlocProvider.of<CommissioningCubit>(context)
                      .actionSaveAcmPassword();
                  globals.subRouteName =
                      Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                },
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
