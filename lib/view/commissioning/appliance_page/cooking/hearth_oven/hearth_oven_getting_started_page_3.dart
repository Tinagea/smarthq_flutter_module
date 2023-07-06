import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';

class HearthOvenWifiInfo extends StatefulWidget {
  @override
  _HearthOvenWifiInfo createState() => _HearthOvenWifiInfo();
}

class _HearthOvenWifiInfo extends State<HearthOvenWifiInfo> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                  .toUpperCase())
              .setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        BleBlockListener.handleBlePairing(context: context),
                        Component.componentMainImage(
                            context, ImagePath.HEARTH_OVEN_WIFI_INFO),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .HEARTH_OVEN_WIFI_TEXT_1),
                                style: textStyle_size_18_color_white()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .HEARTH_OVEN_PREFERENCE_TEXT_5),
                                style: textStyle_size_18_color_yellow()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .HEARTH_OVEN_WIFI_TEXT_2),
                                style: textStyle_size_18_color_white()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .HEARTH_OVEN_PREFERENCE_TEXT_5),
                                style: textStyle_size_18_color_yellow()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .HEARTH_OVEN_WIFI_TEXT_3),
                                style: textStyle_size_18_color_white()
                            ),
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled: true,
                      onTapButton: () {
                        Navigator.of(context)
                            .pushNamed(Routes.HEARTH_OVEN_PASSWORD_INFO);
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
