/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class DishDrawerInsideTopEnableCommissioningFnpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component.componentBaseContent(
      context: context,
      title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
      innerContent: _InnerContent(),
      footerContent: _FooterContent(),
    );
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseComponent.heightSpace(16.h),
        Text(
          LocaleUtil.getString(context, LocaleUtil.PRESS_AND_HOLD_FOR_4S_AGAIN)! + "\n", // To always show 2 lines
          style: textStyle_size_12_white_50_opacity(),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Component.componentMainImage(context, ImagePath.DISHDRAWER_COMMISSIONING_INSIDE_TOP_STEP_2_SVG),
        ),
        BaseComponent.heightSpace(16.h),
        Component.componentTitleText(
          title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!.toUpperCase(),
          marginInsets: EdgeInsets.symmetric(horizontal: 15.w),
        ),
        BaseComponent.heightSpace(32.h),
        CustomRichText.addWifiTextBox(
          spanStringList: [
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_INSIDE_TOP_INSTRUCTION_2_PART_1),
              style: textStyle_size_18_color_white(),
            ),
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_INSIDE_TOP_INSTRUCTION_2_PART_2),
              style: textStyle_size_18_color_yellow(),
            ),
            WidgetSpan(
              child: SvgPicture.asset(ImagePath.DISHDRAWER_COMMISSIONING_INSIDE_TOP_FORWARD_ARROW_SVG),
            ),
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_INSIDE_TOP_INSTRUCTION_2_PART_3),
              style: textStyle_size_18_color_white(),
            ),
          ],
        ),
      ],
    );
  }
}

class _FooterContent extends StatelessWidget {
  const _FooterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Component.componentBottomButton(
      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
      onTapButton: () {
        Navigator.of(context).pushNamed(Routes.DISH_DRAWER_LOCATE_PASSWORD_PAGE);
      },
    );
  }
}
