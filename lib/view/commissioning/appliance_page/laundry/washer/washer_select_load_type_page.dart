import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageWasherLoadLocation extends StatelessWidget {
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
                title: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_LOAD_LOCATION)!),
              Component.componentApplianceVerticalListTile(
                  context: context,
                  title: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_FRONT_LOAD)!,
                  imagePath: ImagePath.LAUNDRY_WASHER_FRONT_LOAD,
                  isLongIcon: true,
                  clickedFunction:() {
                    Navigator.of(context).pushNamed(Routes.WASHER_FRONT_LOAD);
                  }),
              Component.componentApplianceVerticalListTile(
                  context: context,
                  title: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_TOP_LOAD)!,
                  imagePath: ImagePath.LAUNDRY_WASHER_TOP_LOAD,
                  isLongIcon: true,
                  clickedFunction:() {
                    Navigator.of(context).pushNamed(Routes.WASHER_TOP_LOAD);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
