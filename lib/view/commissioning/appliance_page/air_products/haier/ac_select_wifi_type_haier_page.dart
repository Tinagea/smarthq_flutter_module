import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class AcSelectWifiTypeHaierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
            leftBtnFunction: () {
              Navigator.of(context).pop();
            }).setNavigationAppBar(context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 10.w,
              children: <Widget>[
                Component.componentUpperDescriptionText(LocaleUtil.getString(context, LocaleUtil.DOES_YOUR_UNIT_HAVE_BUILT_IN_WIFI_TEXT_HAIER_AC)!),
                Center(
                  child: Component.componentCenterDescriptionTextCenterAlign(
                    text: LocaleUtil.getString(context, LocaleUtil.PLEASE_CHECK_USER_MANUAL_TEXT_HAIER_AC)!,
                    marginInsets: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                ),
                Component.componentMainSelectVerticalImageButton(
                  imageName: ImagePath.BUILT_IN_WIFI,
                  text: LocaleUtil.getString(context, LocaleUtil.YES_IT_HAS_BULIT_IN_WIFI_TEXT_HAIER_AC)!,
                  pushName: Routes.HAIER_AC_APPLIANCE_BUILT_IN_WIFI_DESCRIPTION_PAGE,
                  context: context,
                ),
                Component.componentMainSelectVerticalImageButton(
                  imageName: ImagePath.USB_DONGLE_WIFI,
                  text: LocaleUtil.getString(context, LocaleUtil.NO_BUT_I_HAVE_A_USB_WIFI_ADAPTER_TEXT_HAIER_AC)!,
                  pushName: Routes.HAIER_AC_APPLIANCE_USB_WIFI_DESCRIPTION_PAGE_ONE,
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
