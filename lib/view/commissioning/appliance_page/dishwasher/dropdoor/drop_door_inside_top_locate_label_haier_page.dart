import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class DropDoorInsideTopLocateLabelHaierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
            .toUpperCase(),
        leftBtnFunction: () {
          Navigator.of(context, rootNavigator: false).pop();
        },
      ).setNavigationAppBar(context: context),
      body: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: IntrinsicHeight(child: _InnerContent()),
            ),
          );
        },
      ),
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
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
          child: SvgPicture.asset(
            ImagePath.DROP_DOOR_INSIDE_TOP_CONTROL_HAIER_LOCATE_PASSWORD,
            height: 280.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomRichText.addWifiTextBoxCentered(
            spanStringList: [
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .DROP_DOOR_INSIDE_TOP_HAIER_PASSWORD_LOCATION_TEXT_1),
                style: textStyle_size_18_color_white(),
              ),
            ],
          ),
        ),
        Spacer(),
        Component.componentBottomButton(
          title:
              LocaleUtil.getString(context, LocaleUtil.CONTINUE)!.toUpperCase(),
          onTapButton: () {
            Navigator.of(context)
                .pushNamed(Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP5);
          },
        ),
        BaseComponent.heightSpace(20.h),
      ],
    );
  }
}
