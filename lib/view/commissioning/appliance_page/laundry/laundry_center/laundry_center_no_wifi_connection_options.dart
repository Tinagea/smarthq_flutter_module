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

class LaundryCenterNoWifiConnectionOptions extends StatelessWidget {
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
                          ImagePath.LAUNDRY_CENTER_NO_WIFI_CONNECTION_OPTIONS)
                      ),
                      BaseComponent.heightSpace(16.h),
                      CustomRichText.customSpanListTextBox(
                          textSpanList: [
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_CENTER_NO_WIFI_CONNECTION_OPTIONS_DESCRIPTION),
                                style: textStyle_size_18_color_white()),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
                      Component.componentDescriptionTextWithLinkLabel(
                        contents: LocaleUtil.getString(
                          context, LocaleUtil.LAUNDRY_CENTER_CHECK_WEBSITE_DESCRIPTION)!,
                        contentsForLink: LocaleUtil.getString(
                          context, LocaleUtil.LAUNDRY_CENTER_GEA_URL_DESCRIPTION)!,
                        link: LocaleUtil.getString(
                          context, LocaleUtil.LAUNDRY_CENTER_GEA_URL)!,
                        marginInsets: EdgeInsets.symmetric(horizontal: 29.w)),
                      BaseComponent.heightSpace(16.h),
                    ],
                  ),
                ),

                Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.OK)!,
                  onTapButton: () {
                    Navigator.of(context, rootNavigator: true).popUntil((route) => route.settings.name == Routes.ADD_APPLIANCE_PAGE);
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
