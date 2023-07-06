import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/connect_plus_navigator.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageLaundrySelectType extends StatefulWidget {
  @override
  State createState() => _PageLaundrySelectType();
}

class _PageLaundrySelectType extends State<PageLaundrySelectType> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: CommonAppBar(
                title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
                leftBtnFunction: () {
                  Navigator.of(context, rootNavigator: true).pop();
                }).setNavigationAppBar(context: context),
            body: SingleChildScrollView(
                child: Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 20.h,
                    children: <Widget>[
                      Component.componentApplianceVerticalListTile(
                          context: context,
                          title: LocaleUtil.getString(context, LocaleUtil.WASHER)!,
                          imagePath: ImagePath.LAUNDRY_MAIN_WASHER_IMAGE,
                          isLongIcon: true,
                          clickedFunction:() {
                            globals.subRouteName = Routes.WASHER_LOAD_LOCATION;
                            Navigator.pushNamed(context, Routes.WASHER_MAIN_NAVIGATOR);
                          }),
                      Component.componentApplianceVerticalListTile(
                          context: context,
                          title: LocaleUtil.getString(context, LocaleUtil.DRYER)!,
                          imagePath: ImagePath.LAUNDRY_MAIN_DRYER_IMAGE,
                          isLongIcon: true,
                          clickedFunction:() {
                            globals.subRouteName = Routes.DRYER_LOAD_LOCATION;
                            Navigator.pushNamed(context, Routes.DRYER_MAIN_NAVIGATOR);
                          }),
                      Component.componentApplianceVerticalListTile(
                          context: context,
                          title: LocaleUtil.getString(context, LocaleUtil.COMBO)!,
                          imagePath: ImagePath.LAUNDRY_MAIN_COMBI_IMAGE,
                          isLongIcon: true,
                          clickedFunction:() {
                            globals.subRouteName = Routes.COMBI_DESCRIPTION1;
                            Navigator.pushNamed(context, Routes.COMBI_MAIN_NAVIGATOR);
                          }),
                      Component.componentApplianceVerticalListTile(
                          context: context,
                          title: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_CENTER)!,
                          imagePath: ImagePath.LAUNDRY_CENTER_IMAGE,
                          isLongIcon: true,
                          clickedFunction:() {
                            globals.subRouteName = Routes.LAUNDRY_CENTER_SELECT_WIFI_TYPE;
                            Navigator.pushNamed(context, Routes.LAUNDRY_CENTER_MAIN_NAVIGATOR);
                          }),
                      Component.componentApplianceVerticalListTile(context: context,
                          title: LocaleUtil.getString(context, LocaleUtil.HAVE_CONNECT_PLUS),
                          height: 48.h,
                          alignment: Alignment.center,
                          clickedFunction: () {
                            Navigator.pushNamed(context, Routes.CONNECT_PLUS_MAIN_NAVIGATOR,
                                arguments: ScreenArgs(ApplianceType.LAUNDRY_WASHER)
                            );
                          }),
                    ]
                )
            )
        )
    );
  }
}
