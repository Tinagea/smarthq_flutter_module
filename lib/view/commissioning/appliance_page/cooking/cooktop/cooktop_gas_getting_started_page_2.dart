import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';

class PageCooktopGasStep2 extends StatefulWidget {
  @override
  _PageCooktopGasStep2 createState() => _PageCooktopGasStep2();
}

class _PageCooktopGasStep2 extends State<PageCooktopGasStep2> {
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
                        Component.componentMainImage(
                            context, ImagePath.COOKTOP_GAS_STEP_2),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.addWifiTextBox(
                          spanStringList:[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKTOP_GAS_STEP_1_TEXT_1),
                                style: textStyle_size_18_color_white()
                            ),
                            WidgetSpan(
                              child: Icon(
                                Icons.remove,
                                size: 24.w,
                                color: colorSelectiveYellow(),
                              ),
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKTOP_GAS_STEP_1_TEXT_2),
                                style: textStyle_size_18_color_white()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKTOP_GAS_STEP_1_TEXT_3),
                                style: textStyle_size_18_color_yellow()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKTOP_GAS_STEP_1_TEXT_4),
                                style: textStyle_size_18_color_white()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .COOKTOP_GAS_STEP_1_TEXT_5),
                                style: textStyle_size_18_color_yellow()
                            ),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      onTapButton: () {
                        Navigator.of(context)
                            .pushNamed(Routes.COOKTOP_GAS_STEP_3);
                      }
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
