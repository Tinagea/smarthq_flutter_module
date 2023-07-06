import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class AcWifiAdapterEnableCommissioningHaierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)).setNavigationAppBar(context: context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Component.componentMainImage(context, ImagePath.HAIER_AC),
                  BaseComponent.heightSpace(16.h),
                  CustomRichText.customSpanListTextBox(
                    textSpanList: <TextSpan>[
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_1),
                        style: textStyle_size_18_color_white(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_2),
                        style: textStyle_size_18_color_yellow(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_3),
                        style: textStyle_size_18_color_white(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_4),
                        style: textStyle_size_18_color_yellow(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_5),
                        style: textStyle_size_18_color_white(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_6),
                        style: textStyle_size_18_color_yellow(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_7),
                        style: textStyle_size_18_color_white(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_8),
                        style: textStyle_size_18_color_yellow(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_9),
                        style: textStyle_size_18_color_white(),
                      ),
                    ],
                  ),
                  BaseComponent.heightSpace(16),
                ],
              ),
            ),
            Component.componentBottomButton(
              title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
              isEnabled: true,
              onTapButton: () {
                Navigator.of(context).pushNamed(Routes.HAIER_AC_APPLIANCE_INFO_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }
}
