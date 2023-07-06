import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class PageRangeSelectType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE),
          leftBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ).setNavigationAppBar(context: context),
        body: SingleChildScrollView(
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 20.h,
            children: <Widget>[
              Component.componentApplianceSelectTypeTitle(
                  title: LocaleUtil.getString(context, LocaleUtil.WHICH_ONE_LOOK_LIKE)!),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.RANGE_LCD_PASSWORD_INFO,
                  imageName: ImagePath.RANGE_LCD),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.RANGE_TOUCH_BUTTONS_SELECTION_TYPE,
                  imageName: ImagePath.RANGE_TOUCH_BUTTONS),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.RANGE_HAIER_KNOB_DESCRIPTION,
                  imageName: ImagePath.RANGE_HAIER_KNOB),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.RANGE_PRO_RANGE_DESCRIPTION,
                  imageName: ImagePath.RANGE_PRO_RANGE)
            ],
          ),
        ),
      ),
    );
  }
}
