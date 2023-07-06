/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WallOvenEnableCommissioningHaierPage1 extends StatelessWidget {
  const WallOvenEnableCommissioningHaierPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!,
        leftBtnFunction: () {
          Navigator.of(context).pop();
        },
      ).setNavigationAppBar(context: context),
      body: ListView(
        children: [
          BaseComponent.heightSpace(16.h),
          Text(
            LocaleUtil.getString(
                context, LocaleUtil.ENSURE_THERE_IS_NO_COOKING_IN_PROGRESS)!,
            style: textStyle_size_12_white_50_opacity(),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 16.w),
            child: SvgPicture.asset(
              ImagePath.COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_1_SVG,
              width: 200.w,
            ),
          ),
          Component.pageIndicator(3, 1, size: 8),
          BaseComponent.heightSpace(16.h),
          Divider(height: 1.h, color: colorDeepDarkCharcoal()),
          BaseComponent.heightSpace(16.h),
          Center(
            child: Component.componentTitleText(
                title: LocaleUtil.getString(context, LocaleUtil.SETTING)!
                    .toUpperCase(),
                marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
          ),
          BaseComponent.heightSpace(16.h),
          CustomRichText.addWifiTextBoxCentered(
            spanStringList: [
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_2_PART_1),
                style: textStyle_size_18_color_white(),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_2_PART_2),
                style: textStyle_size_18_color_yellow(),
              ),
              WidgetSpan(
                child: Icon(
                  Icons.power_settings_new,
                  size: 24,
                  color: colorAmericanYellow(),
                ),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_2_PART_3),
                style: textStyle_size_18_color_white(),
              ),
            ],
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          BaseComponent.heightSpace(16.h),
          Component.componentBottomButton(
            title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
            onTapButton: () {
              Navigator.of(context)
                  .pushNamed(Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_3);
            },
          ),
          BaseComponent.heightSpace(20.h),
        ],
      ),
    );
  }
}
