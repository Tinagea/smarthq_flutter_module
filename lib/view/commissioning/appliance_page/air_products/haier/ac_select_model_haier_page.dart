import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class AcSelectModelHaierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
        leftBtnFunction: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ).setNavigationAppBar(context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 10.w,
            children: <Widget>[
              Component.componentUpperDescriptionText(LocaleUtil.getString(context, LocaleUtil.WHICH_ONE_LOOK_LIKE)!),
              Component.componentMainSelectImageButton(
                context: context,
                pushName: Routes.HAIER_AC_APPLIANCE_WIFI_TYPE_SELECTION_PAGE,
                imageName: ImagePath.HAIER_WALL_SPLIT_AC,
                text: LocaleUtil.getString(context, LocaleUtil.HI_WALL_SPLIT)!,
                paddingInsets: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              ),
              Component.componentMainSelectImageButton(
                context: context,
                pushName: Routes.HAIER_AC_APPLIANCE_WIFI_TYPE_SELECTION_PAGE,
                imageName: ImagePath.HAIER_DUCTED_AC,
                text: LocaleUtil.getString(context, LocaleUtil.DUCTED)!,
                paddingInsets: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              ),
              BaseComponent.heightSpace(20.h)
            ],
          ),
        ),
      ),
    );
  }
}
