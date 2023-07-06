// file: air_appliance_type_page.dart
// date: Sep/28/2021
// brief: About air appliance type page.
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

enum AirConditionerType {
  wac,
  pac,
  dfs,
  dehumidifier
}

class AirApplianceTypePage extends StatelessWidget {
  AirApplianceTypePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),)
          .setNavigationAppBar(context: context, leadingRequired: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              BaseComponent.heightSpace(22.h),
              GridView.count(
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 15.h,
                crossAxisCount: 2,
                children: [
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(context, LocaleUtil.WINDOWS_AC)!,
                      imagePath: ImagePath.WAC_TYPE_IMAGE_PATH,
                      clickedFunction: (){
                        Navigator.pushNamed(
                          context, Routes.WINDOW_AC_MAIN_NAVIGATOR,
                        );
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(context, LocaleUtil.PORTABLE_AC)!,
                      imagePath: ImagePath.PAC_TYPE_IMAGE_PATH,
                      clickedFunction: (){
                        Navigator.pushNamed(
                          context, Routes.PORTABLE_AC_MAIN_NAVIGATOR,
                        );
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(context, LocaleUtil.DUCTLESS_AC)!,
                      imagePath: ImagePath.DFS_TYPE_IMAGE_PATH,
                      clickedFunction: (){
                        Navigator.pushNamed(
                          context, Routes.DUCTLESS_MAIN_NAVIGATOR,
                        );
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(context, LocaleUtil.DEHUMIDIFIER)!,
                      imagePath: ImagePath.DEHUMIDIFIER_TYPE_IMAGE_PATH,
                      clickedFunction: (){
                        Navigator.pushNamed(
                          context, Routes.DEHUMIDIFIER_MAIN_NAVIGATOR,
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
