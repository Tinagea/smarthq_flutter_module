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

class ManualEspressoModuleStep2 extends StatefulWidget {

  @override
  State createState() => _ManualEspressoModuleStep2();

}


class _ManualEspressoModuleStep2 extends State<ManualEspressoModuleStep2> with WidgetsBindingObserver {

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
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        BleBlockListener.handleBlePairing(context: context),
                        Component.componentMainImage(context, ImagePath.ESPRESSO_MANUAL_INFO),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.ESPRESSO_DESCRIPTION_2),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.ESPRESSO_DESCRIPTION_2_1),
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.ESPRESSO_DESCRIPTION_2_2),
                                style: textStyle_size_18_color_white()),


                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled: true,
                      onTapButton: () {
                        geaLog.debug("ManualEspressoModuleStep2 on tap");
                        Navigator.of(context).pushNamed(Routes.ESPRESSO_MANUAL_THREE);
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
