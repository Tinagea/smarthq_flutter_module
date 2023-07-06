import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowMeHowAndroidPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Component.componentMainImage(
                        context,
                        ImagePath.SHOW_ME_HOW_ANDROID_MAINIMAGE4_PATH),
                    BaseComponent.heightSpace(16.h),
                    CustomRichText.customSpanListTextBox(
                      textSpanList: <TextSpan>[
                        TextSpan(
                            text: LocaleUtil.getString(context, LocaleUtil.SHOW_ME_HOW_ANDROID_PAGE4_DESCRIPTION)! + " \"",
                            style: textStyle_size_18_color_white()),
                        TextSpan(
                            text: LocaleUtil.getString(context, LocaleUtil.WIFI),
                            style: textStyle_size_18_color_yellow()),
                        TextSpan(
                            text: "\"",
                            style: textStyle_size_18_color_white())
                      ],
                      marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
