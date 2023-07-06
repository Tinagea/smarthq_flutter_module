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

class AcLocateLabelHaierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase()).setNavigationAppBar(context: context),
      body: Component.componentCommissioningBody(
        context,
        <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Component.componentMainImage(
              context,
              ImagePath.HAIER_AC_LABLE_LOCATION,
            ),
          ),
          BaseComponent.heightSpace(16.h),
          CustomRichText.customSpanListTextBoxCenter(
            textSpanList: <TextSpan>[
              TextSpan(
                text: LocaleUtil.getString(context, LocaleUtil.AC_LOCATE_LABEL_DESCRIPTION_1),
                style: textStyle_size_18_color_white(),
              ),
            ],
          ),
        ],
        Component.componentBottomButton(
          title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
          onTapButton: () {
            Navigator.of(context).pushNamed(Routes.HAIER_AC_APPLIANCE_PASSWORD_PAGE);
          },
        ),
      ),
    );
  }
}
