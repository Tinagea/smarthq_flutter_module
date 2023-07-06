import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class LaundrySelectTypeHaierPage extends StatelessWidget {

  LaundrySelectTypeHaierPage({Key? key}) : super(key: key);

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
          },
        ).setNavigationAppBar(context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 20.h,
                  children: <Widget>[
                    Component.componentApplianceVerticalListTile(
                        context: context,
                        title: LocaleUtil.getString(context, LocaleUtil.WASHER)!,
                        imagePath: ImagePath.LAUNDRY_SELECTION_WASHER_FNP,
                        isLongIcon: true,
                        clickedFunction:() {
                          globals.subRouteName = Routes.WASHER_HAIER_SELECT_LOAD_LOCATION;
                          Navigator.of(context).pushNamed(Routes.WASHER_MAIN_NAVIGATOR);
                        }),
                    Component.componentApplianceVerticalListTile(
                        context: context,
                        title: LocaleUtil.getString(context, LocaleUtil.DRYER)!,
                        imagePath: ImagePath.LAUNDRY_SELECTION_DRYER_FNP,
                        isLongIcon: true,
                        clickedFunction:() {
                          globals.subRouteName = Routes.DRYER_MODEL_1_GETTING_STARTED_HAIER;
                          Navigator.of(context).pushNamed(Routes.DRYER_MAIN_NAVIGATOR);
                        }),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
