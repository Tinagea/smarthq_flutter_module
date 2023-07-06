import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageFridgeSelectDisplay extends StatelessWidget {
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
                  pushName: Routes.DISPENSER_DESCRIPTION2_MODEL1,
                  imageName: ImagePath.DISPENSER_TOP_CONTROLLER1),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.DISPENSER_DESCRIPTION2_MODEL2,
                  imageName: ImagePath.DISPENSER_TOP_CONTROLLER2),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.DISPENSER_DESCRIPTION2_MODEL3,
                  imageName: ImagePath.DISPENSER_TOP_CONTROLLER3)
            ],
          ),
        ),
      ),
    );
  }
}
