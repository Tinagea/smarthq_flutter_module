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
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class SelectDishwasherType extends StatelessWidget {
  const SelectDishwasherType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!
              .toUpperCase(),
          leftBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          }).setNavigationAppBar(context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: InnerContent(),
        ),
      ),
    );
  }
}

class InnerContent extends StatelessWidget {
  const InnerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseComponent.heightSpace(16.h),
        Component.componentUpperDescriptionText(LocaleUtil.getString(
            context, LocaleUtil.DISHWASHER_TYPE)!),
        BaseComponent.heightSpace(16.h),
        applianceTypeCard(
          context: context,
          imageName: ImagePath.DISHWASHER_TYPE_DROP_DOOR_SVG,
          text: LocaleUtil.getString(context, LocaleUtil.DROP_DOOR_DISHWASHER)!,
          onTap: () {
            // Redirect page for CommonNavigatePage
            globals.subRouteName = Routes.DROP_DOOR_FNP_STEP1;
            Navigator.of(context).pushNamed(Routes.DROP_DOOR_MAIN_NAVIGATOR);
          }
        ),
        BaseComponent.heightSpace(16.h),
        applianceTypeCard(
          context: context,
          imageName: ImagePath.DISHWASHER_TYPE_DISH_DRAWER_SVG,
          text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER)!,
          onTap: () {
            Navigator.of(context).pushNamed(Routes.DISH_DRAWER_MAIN_NAVIGATOR);
          }
        ),
      ],
    );
  }

  static Widget applianceTypeCard({
    required BuildContext context,
    required String imageName,
    required String text,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 182.h,
        decoration: Component.commonCardBackgroundDecoration(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Row(
            children: [
              SvgPicture.asset(imageName, width: 100.w),
              Expanded(
                child: Text(
                  text,
                  style: textStyle_size_18_bold_color_white(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
