import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class PageBeverageCenterApplianceInfo extends StatefulWidget {
  PageBeverageCenterApplianceInfo({Key? key}) : super(key: key);

  _PageBeverageCenterApplianceInfo createState() => _PageBeverageCenterApplianceInfo();
}

class _PageBeverageCenterApplianceInfo extends State<PageBeverageCenterApplianceInfo> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
              leftBtnFunction: () {
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
          body: Component.componentCommissioningBody(
            context,
            <Widget>[
              BleBlockListener.handleBlePairing(context: context),
              Component.componentMainImage(
                  context, ImagePath.BEV_CENTER_APPLIANCE_INFO),
              BaseComponent.heightSpace(16.h),
              CustomRichText.customSpanListTextBox(
                textSpanList: <TextSpan>[
                  TextSpan(
                      text: LocaleUtil.getString(context,
                          LocaleUtil.BEVERAGE_CENTER_APPLIANCE_INFO_TEXT_1),
                      style: textStyle_size_18_color_white()),
                  TextSpan(
                      text: LocaleUtil.getString(context,
                          LocaleUtil.BEVERAGE_CENTER_APPLIANCE_INFO_TEXT_2),
                      style: textStyle_size_18_color_yellow()),
                  TextSpan(
                      text: LocaleUtil.getString(context,
                          LocaleUtil.BEVERAGE_CENTER_APPLIANCE_INFO_TEXT_3),
                      style: textStyle_size_18_color_white())
                ],
              ),
            ],
            Component.componentBottomButton(
                title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                onTapButton: () {
                  Navigator.of(context)
                      .pushNamed(Routes.BEVERAGE_CENTER_COMMISSIONING_ENTER_PASSWORD);
                }
            ),
          ),
        )
    );
  }
}
