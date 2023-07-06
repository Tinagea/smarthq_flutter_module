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

class SelectWifiConnectionType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          leftBtnFunction: () {
              Navigator.of(context, rootNavigator: true).pop();
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
                        padding: EdgeInsets.symmetric(vertical: 64.h),
                        child:Component.componentMainSmallImage(context,
                          ImagePath.LAUNDRY_CENTER_TEMP_WIFI_IMAGE)
                      ),
                      BaseComponent.heightSpace(16.h),
                      Component.componentTitleText(
                          title: LocaleUtil.getString(
                              context, LocaleUtil.LETS_GET_STARTED)!
                              .toUpperCase(),
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                      BaseComponent.heightSpace(16.h),
                      Component.componentDescriptionText(
                        text: LocaleUtil.getString(context,
                            LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_1)!,
                        marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                      ),
                      BaseComponent.heightSpace(48.h),
                      CustomRichText.addWifiTextBox(
                          spanStringList: [
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_WIFI_TYPE_DESCRIPTION_1),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_WIFI_TYPE_DESCRIPTION_2),
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_WIFI_TYPE_DESCRIPTION_3),
                                style: textStyle_size_18_color_white()),
                            WidgetSpan(
                              child: Icon(
                                Icons.wifi,
                                size: 24.w,
                                color: colorSelectiveYellow(),
                              ),
                            ),
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_WIFI_TYPE_DESCRIPTION_4),
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
                      Navigator.of(context).pushNamed(Routes.LAUNDRY_CENTER_SETUP_BUILT_IN_WIFI);
                    },
                    LocaleUtil.getString(context,
                        LocaleUtil.NO)!.toUpperCase(),
                    () {
                      Navigator.of(context).pushNamed(Routes.LAUNDRY_CENTER_SELECT_EXTERNAL_WIFI_OPTION);
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
