/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class WasherModel2AppliancePasswordFnpPage extends StatefulWidget {
  WasherModel2AppliancePasswordFnpPage({Key? key}) : super(key: key);

  _WasherModel2AppliancePasswordFnpPageState createState() => _WasherModel2AppliancePasswordFnpPageState();
}

class _WasherModel2AppliancePasswordFnpPageState extends State<WasherModel2AppliancePasswordFnpPage> {
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
                        BaseComponent.heightSpace(16.h),
                        Component.componentMainImage(context,
                            ImagePath.LAUNDRY_FRONT_1_PASSWORD_2_FNP),
                        BaseComponent.heightSpace(40.h),
                        CustomRichText.richTextDescriptionWithCard(
                            RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: LocaleUtil.getString(context,
                                              LocaleUtil.LAUNDRY_WASHER_FNP_FRONT_2_ENTER_PASSWORD_1),
                                          style: textStyle_size_18_color_white()
                                      ),
                                      TextSpan(
                                          text: LocaleUtil.getString(context,
                                              LocaleUtil.LAUNDRY_WASHER_FNP_FRONT_2_ENTER_PASSWORD_2),
                                          style: textStyle_size_18_color_yellow()
                                      ),
                                      TextSpan(
                                          text: LocaleUtil.getString(context,
                                              LocaleUtil.LAUNDRY_WASHER_FNP_FRONT_2_ENTER_PASSWORD_3),
                                          style: textStyle_size_18_color_white()
                                      )
                                    ]
                                )),
                            EdgeInsets.symmetric(horizontal: 16.w)),
                        BaseComponent.heightSpace(40.h),
                        Component.componentDescriptionText(
                          text: LocaleUtil.getString(context,
                              LocaleUtil.ENTER_PASSWORD)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                        ),
                        BaseComponent.heightSpace(20.h),
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
                          })
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
