import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class ToasterOvenCommissioningStep2 extends StatefulWidget {

  @override
  State createState() => _ToasterOvenCommissioningStep2();

}

class _ToasterOvenCommissioningStep2 extends State<ToasterOvenCommissioningStep2> with WidgetsBindingObserver {

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
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                            child: Component.componentMainImage(context,
                                ImagePath.TOASTER_OVEN_IMAGE2)),
                        BleBlockListener.handleBlePairing(context: context),
                        BaseComponent.heightSpace(16.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.LOCATE_LABEL_EXPLAIN_1),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.LOCATE_LABEL_EXPLAIN_2),
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil
                                    .TOASTER_OVEN_LOCATE_LABEL_EXPLAIN_3),
                                style: textStyle_size_18_color_white())
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title:
                      LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled: true,
                      onTapButton: () {
                        geaLog.debug('ToasterOvenCommissioningStep2 on tap');
                        Navigator.of(context)
                            .pushNamed(
                            Routes.TOASTER_OVEN_COMMISSIONING_ENTER_PASSWORD);
                      }),
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

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}