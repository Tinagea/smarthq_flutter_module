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

class PageCooktopApplianceInfo extends StatefulWidget {
  _PageCooktopApplianceInfo createState() => _PageCooktopApplianceInfo();
}

class _PageCooktopApplianceInfo extends State<PageCooktopApplianceInfo> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
              leftBtnFunction: () {
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  BleBlockListener.handleBlePairing(context: context),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(context, ImagePath.COOKTOP_INDUCTION_APPLIANCES_INFO),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.addWifiTextBox(spanStringList: [
                          TextSpan(text: LocaleUtil.getString(context,
                                      LocaleUtil
                                          .COOKTOP_INDUCTION_APPLIANCE_INFO_TEXT),
                                  style: textStyle_size_18_color_white()),
                            ],
                            marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled: true,
                      onTapButton: () {
                        Navigator.of(context)
                            .pushNamed(Routes.COOKTOP_PASSWORD_INFO);
                      })
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}