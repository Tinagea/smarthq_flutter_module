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
import 'package:smarthq_flutter_module/view/common/styles.dart';

class DropDoorInsideTopEnableCommissioningHaierPage2 extends StatelessWidget {
  const DropDoorInsideTopEnableCommissioningHaierPage2({Key? key}) : super(key: key);

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
  const _InnerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Text(
            LocaleUtil.getString(
                context, LocaleUtil.NOW_PRESS_THIS_BUTTON_AGAIN_AND)!,
            style: textStyle_size_12_white_50_opacity(),
            textAlign: TextAlign.center,
          ),
          height: 36.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
          child: SvgPicture.asset(
            ImagePath.DROP_DOOR_INSIDE_TOP_CONTROL_HAIER_STEP_3,
          ),
        ),
        Component.pageIndicator(3, 2, size: 6.w),
        BaseComponent.heightSpace(16.h),
        Divider(thickness: 1.h, height: 1.h, color: colorDeepDarkCharcoal()),
        BaseComponent.heightSpace(24.h),
        Component.componentTitleText(
            title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!
                .toUpperCase(),
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: CustomRichText.addWifiTextBoxCentered(
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
            spanStringList: [
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_3_PART_1),
                style: textStyle_size_18_color_white(),
              ),
              WidgetSpan(
                child: Icon(
                  Icons.wifi,
                  size: 24,
                  color: colorPigmentRed(),
                ),
              ),
              TextSpan(
                text: LocaleUtil.getString(
                    context,
                    LocaleUtil
                        .DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_3_PART_2),
                style: textStyle_size_18_color_white(),
              ),
            ],
          ),
        ),
        Spacer(),
        Component.componentBottomButton(
            title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
            onTapButton: () {
              Navigator.of(context)
                  .pushNamed(Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP4);
            }),
        BaseComponent.heightSpace(20.h),
      ],
    );
  }
}
