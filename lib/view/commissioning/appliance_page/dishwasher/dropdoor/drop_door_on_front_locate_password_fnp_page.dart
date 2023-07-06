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

class DropDoorOnFrontLocatePasswordFnpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component.componentBaseContent(
      context: context,
      title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
          .toUpperCase(),
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: SvgPicture.asset(
            ImagePath.DROP_DOOR_ON_FRONT_OF_DOOR_LOCATE_PASSWORD_SVG,
            height: 280.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
          child: CustomRichText.addWifiTextBox(
            spanStringList: [
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .DROP_DOOR_PASSWORD_LOCATION_TEXT_1),
                style: textStyle_size_18_color_white(),
              ),
            ],
          ),
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
      title:
      LocaleUtil.getString(context, LocaleUtil.CONTINUE)!.toUpperCase(),
      onTapButton: () {
        Navigator.of(context)
            .pushNamed(Routes.DROP_DOOR_FNP_STEP3);
      },
    );
  }
}

