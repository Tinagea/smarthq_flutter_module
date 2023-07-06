import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class OpalDescription2 extends StatefulWidget {
  @override
  _OpalDescription2State createState() => _OpalDescription2State();
}

class _OpalDescription2State extends State<OpalDescription2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
              leftBtnFunction: () {
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        BleBlockListener.handleBlePairing(context: context),
                        BaseComponent.heightSpace(66.h),
                        Padding(
                          padding: EdgeInsets.only(left: 28.0.w, right: 28.0.w, top: 0, bottom: 0),
                          child: Component.componentMainImage(
                              context, ImagePath.OPAL_INFO),
                        ),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .SMALL_APPLIANCES_PASSWORD_SETUP_DESC_1),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .SMALL_APPLIANCES_PASSWORD_SETUP_DESC_2),
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .SMALL_APPLIANCES_PASSWORD_SETUP_DESC_3),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.OPAL_PASSWORD_DESC_1),
                                style: textStyle_size_18_color_white()),
                          ],
                        ),
                        BaseComponent.heightSpace(16),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(
                          context, LocaleUtil.CONTINUE)!,
                      isEnabled: true,
                      onTapButton: () {
                        Navigator.of(context)
                            .pushNamed(Routes.OPAL_DESCRIPTION_VIEW_3);
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
