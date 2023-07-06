import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class DishDrawerLocateControlFnpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Component.componentBaseContent(
      context: context,
      title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
      innerContent: _InnerContent(),
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
        Component.componentUpperDescriptionText(LocaleUtil.getString(context, LocaleUtil.LOCATE_DISHDRAWER_CONTROL)!),
        BaseComponent.heightSpace(16.h),
        Component.componentMainSelectImageButtonDynamicSize(
          context: context,
          pushName: Routes.DISH_DRAWER_ON_FRONT_OF_DOOR_STEP1_PATH,
          imageName: ImagePath.DISHDRAWER_COMMISSIONING_ON_FRONT_OF_DOOR_SVG,
          text: LocaleUtil.getString(context, LocaleUtil.ON_FRONT_OF_DOOR)!,
          imageWidth: 100.w,
          paddingInsets: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        ),
        BaseComponent.heightSpace(16.h),
        Component.componentMainSelectImageButtonDynamicSize(
          context: context,
          pushName: Routes.DISH_DRAWER_INSIDE_TOP_STEP1,
          imageName: ImagePath.DISHDRAWER_COMMISSIONING_INSIDE_TOP_SVG,
          text: LocaleUtil.getString(context, LocaleUtil.INSIDE_TOP)!,
          imageWidth: 100.w,
          paddingInsets: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        ),
      ],
    );
  }
}
