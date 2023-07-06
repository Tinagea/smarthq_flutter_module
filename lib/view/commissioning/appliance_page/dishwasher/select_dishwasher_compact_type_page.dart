/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class SelectDishwasherCompactType extends StatelessWidget {
  const SelectDishwasherCompactType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
              .toUpperCase(),
          leftBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          }).setNavigationAppBar(context: context),
      body:

      SingleChildScrollView(
          child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: <Widget>[
                Component.componentUpperDescriptionText(LocaleUtil.getString(
                    context, LocaleUtil.DISHWASHER_TYPE)!),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.DISHWASHER_BUILT_IN)!,
                    imagePath: ImagePath.DISHWASHER_TYPE_DROP_DOOR_SVG,
                    isLongIcon: true,
                    clickedFunction:() {
                      Navigator.pushNamed(context, Routes.DISHWASHER_HOME);
                    }),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.DISHWASHER_COMPACT)!,
                    imagePath: ImagePath.DISHWASHER_TYPE_COMPACT_SVG,
                    isLongIcon: true,
                    clickedFunction:() {
                      Navigator.pushNamed(context, Routes.DISHWASHER_COMPACT);
                    }),
                ]
              )
          )
      );
  }
}
