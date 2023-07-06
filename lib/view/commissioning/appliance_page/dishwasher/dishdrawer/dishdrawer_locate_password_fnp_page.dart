import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class DishDrawerLocatePasswordFnpPage extends StatelessWidget {
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
  const _InnerContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseComponent.heightSpace(16.h),
        Component.componentMainImage(context, ImagePath.DISHDRAWER_COMMISSIONING_LOCATE_PASSWORD_SVG),
        BaseComponent.heightSpace(16.h),
        CustomRichText.customSpanListTextBox(
          textSpanList: [
            TextSpan(
              text: LocaleUtil.getString(context, LocaleUtil.DISHDRAWER_ENTERPASSWORD_TEXT_1),
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
      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!.toUpperCase(),
      onTapButton: () {
        Navigator.of(context).pushNamed(Routes.DISH_DRAWER_ENTER_PASSWORD_PAGE);
      },
    );
  }
}
