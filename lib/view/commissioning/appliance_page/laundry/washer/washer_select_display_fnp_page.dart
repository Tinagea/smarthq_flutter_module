import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class WasherSelectDisplayFnpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE),
          leftBtnFunction: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
        ).setNavigationAppBar(context: context),
        body: ListView(
          children: <Widget>[
            Component.componentApplianceSelectTypeTitle(
                title: LocaleUtil.getString(
                    context, LocaleUtil.LAUNDRY_FRONT_2_STEP_3_DISPLAY_MODEL)!),
            BaseComponent.heightSpace(20.h),
            Component.componentMainSelectImageButton(
                context: context,
                pushName: Routes.WASHER_MODEL_1_GETTING_STARTED_FNP,
                imageName: ImagePath.LAUNDRY_FRONT_DISPLAY_1_FNP,
                marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                paddingInsets: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w)
            ),
            BaseComponent.heightSpace(16.h),
            Component.componentMainSelectImageButton(
                context: context,
                pushName: Routes.WASHER_MODEL_2_GETTING_STARTED_FNP,
                imageName: ImagePath.LAUNDRY_FRONT_DISPLAY_2_FNP,
                marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                paddingInsets: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w)
            )
          ],
        ),
      ),
    );
  }
}