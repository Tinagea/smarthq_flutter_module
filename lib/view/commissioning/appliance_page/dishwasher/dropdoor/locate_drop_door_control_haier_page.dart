import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class LocateDropDoorControlHaierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
          leftBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          }).setNavigationAppBar(context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: _InnerContent(),
        ),
      ),
    );
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseComponent.heightSpace(16.h),
        Component.componentUpperDescriptionText(LocaleUtil.getString(context, LocaleUtil.LOCATE_DISHWASHER_CONTROL)!),
        BaseComponent.heightSpace(16.h),
        Component.componentMainSelectImageButtonDynamicSize(
          context: context,
          pushName: Routes.DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP1,
          imageName: ImagePath.DROP_DOOR_CONTROL_LOCATION_CENTRAL_FRONT_OF_DOOR_SVG,
          text: LocaleUtil.getString(context, LocaleUtil.CENTRAL_FRONT_OF_DOOR)!,
          imageWidth: 100.w,
          paddingInsets: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          marginInsets: EdgeInsets.only(bottom: 16.h),
        ),
        Component.componentMainSelectImageButtonDynamicSize(
          context: context,
          pushName: Routes.DROP_DOOR_INSIDE_TOP_HAIER_STEP1,
          imageName: ImagePath.DROP_DOOR_CONTROL_LOCATION_INSIDE_TOP_SVG,
          text: LocaleUtil.getString(context, LocaleUtil.INSIDE_TOP)!,
          imageWidth: 100.w,
          paddingInsets: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          marginInsets: EdgeInsets.only(bottom: 16.h),
        ),
      ],
    );
  }
}
