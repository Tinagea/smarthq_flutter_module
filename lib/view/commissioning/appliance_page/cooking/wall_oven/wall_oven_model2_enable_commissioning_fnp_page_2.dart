import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenModel2EnableCommissioningFnpPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
                title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
            .setNavigationAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Component.componentMainImage(context,
                          ImagePath.COOKING_WALL_OVEN_FNP_MODEL2_ENABLE_COMMISSIONING_2),
                      BaseComponent.heightSpace(16.h),
                      Component.componentTitleText(
                          title:
                              LocaleUtil.getString(context, LocaleUtil.CONNECT)!
                                  .toUpperCase(),
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                          alignText: TextAlign.left),
                      BaseComponent.heightSpace(16.h),
                      CustomRichText.addWifiTextBox(
                          spanStringList: [
                            TextSpan(
                              text: LocaleUtil.getString(
                                  context, LocaleUtil.THEN_SELECT),
                              style: textStyle_size_18_color_white(),
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.CONNECT),
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(
                              text: LocaleUtil.getString(
                                  context,
                                  LocaleUtil
                                      .AND_PRESS_THE_DIAL_TO_CONNECT_YOUR_APPLIANCE),
                              style: textStyle_size_18_color_white(),
                            ),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                          alignText: TextAlign.left),
                    ],
                  ),
                ),
                Component.pageIndicator(4, 2, size: 15.h, spacing: 6.w),
                BaseComponent.heightSpace(6.h),
                Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!
                      .toUpperCase(),
                  onTapButton: () {
                    Navigator.of(context).pushNamed(
                        Routes.WALL_OVEN_MODEL_2_STEP_4_FNP);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
