import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class DishDrawerOnFrontEnableCommissioningPage2 extends StatelessWidget {
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
        Text(
          LocaleUtil.getString(context, LocaleUtil.NOW_PRESS_THIS_BUTTON_AGAIN_AND)! + "\n", // To always show 2 lines
          style: textStyle_size_12_white_50_opacity(),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Component.componentMainImage(context, ImagePath.DISHDRAWER_COMMISSIONING_INFO_3_SVG),
        ),
        BaseComponent.heightSpace(16.h),
        Component.pageIndicator(3, 2),
        BaseComponent.heightSpace(16.h),
        Divider(
          height: 1,
          color: colorDeepDarkCharcoal(),
        ),
        BaseComponent.heightSpace(16.h),
        Component.componentTitleText(
          title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!.toUpperCase(),
          marginInsets: EdgeInsets.symmetric(horizontal: 15.w),
        ),
        BaseComponent.heightSpace(16.h),
        CustomRichText.addWifiTextBox(
          spanStringList: [
            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_1), style: textStyle_size_18_color_white()),
            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_2), style: textStyle_size_18_color_yellow()),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: SvgPicture.asset(
                ImagePath.DISHDRAWER_START_ICON_FNP,
              ),
            ),
            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_3), style: textStyle_size_18_color_white()),
            WidgetSpan(
              child: Icon(
                Icons.wifi,
                size: 24,
                color: colorPigmentRed(),
              ),
            ),
            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_4), style: textStyle_size_18_color_white()),
            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_5), style: textStyle_size_18_color_white_50_opacity()),
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
