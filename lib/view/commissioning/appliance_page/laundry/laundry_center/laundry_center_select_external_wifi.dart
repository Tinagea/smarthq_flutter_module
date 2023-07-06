import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class LaundryCenterSelectExternalWifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          leftBtnFunction: () {
              Navigator.of(context).pop();
          },
        ).setNavigationAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child:Component.componentMainImage(context,
                          ImagePath.LAUNDRY_CENTER_PORTS_IMAGE)
                      ),
                      BaseComponent.heightSpace(16.h),
                      CustomRichText.customSpanListTextBox(
                          textSpanList: [
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_PORTS_DESCRIPTION),
                                style: textStyle_size_18_color_white()),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
                      BaseComponent.heightSpace(16.h),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 60.w),
                  child: Component.componentTwoBottomButton(
                    LocaleUtil.getString(context,
                        LocaleUtil.YES)!.toUpperCase(),
                    () {
                      Navigator.of(context).pushNamed(Routes.LAUNDRY_CENTER_CONNECT_PLUS_SETUP);
                    },
                    LocaleUtil.getString(context,
                        LocaleUtil.NO)!.toUpperCase(),
                    () {
                      Navigator.of(context).pushNamed(Routes.LAUNDRY_CENTER_NO_WIFI_CONNECTION_OPTIONS);
                    })
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
