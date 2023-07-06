import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasherSelectLoadLocationHaierPage extends StatelessWidget {

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
        body: ListView(
          children: <Widget>[
            Text(LocaleUtil.getString(context, LocaleUtil.LAUNDRY_LOAD_LOCATION)!,
              style: textStyle_size_16_bold_color_white(),
              textAlign: TextAlign.left),
            BaseComponent.heightSpace(20.h),
            Component.componentMainSelectImageButton(
                context: context,
                pushName: Routes.WASHER_FRONT_LOAD_GETTING_STARTED_HAIER,
                imageName: ImagePath.LAUNDRY_WASHER_FRONT_LOAD,
                text: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_FRONT_LOAD)!,
                marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                paddingInsets: EdgeInsets.symmetric(horizontal: 20.w)),
            BaseComponent.heightSpace(16.h),
            Component.componentMainSelectImageButton(
                context: context,
                pushName: Routes.WASHER_TOP_LOAD_GETTING_STARTED_HAIER,
                imageName: ImagePath.LAUNDRY_WASHER_TOP_LOAD,
                text: LocaleUtil.getString(context, LocaleUtil.LAUNDRY_TOP_LOAD)!,
                marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                paddingInsets: EdgeInsets.symmetric(horizontal: 20.w)),
          ],
        ),
      ),
    );
  }
}
