import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherTopLoadType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE),
          leftBtnFunction: () {
            Navigator.of(context).pop();
          },
        ).setNavigationAppBar(context: context),
        body: SingleChildScrollView(
          child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: [
                Component.componentApplianceSelectTypeTitle(
                    title: LocaleUtil.getString(context, LocaleUtil.WASHER_WHICH_ONE)!),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.WASHER_TOP_MODEL3,
                  imageName: ImagePath.WASHER_TOP_3),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.WASHER_TOP_MODEL1,
                  imageName: ImagePath.WASHER_TOP_1),
              Component.componentMainSelectImageButton(
                  context: context,
                  pushName: Routes.WASHER_TOP_MODEL2,
                  imageName: ImagePath.WASHER_TOP_2)
            ]
          ),
        ),
      ),
    );
  }
}