import 'package:flutter/material.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnTopCommissioningModel2Step2 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
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
                        BleBlockListener.handleBlePairing(context: context),
                        Component.componentMainImage(
                            context,
                            ImagePath.ONTOP_CONNECTED_APPLIANCE_INFORMATION),
                        BaseComponent.heightSpace(16.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.LOCATE_LABEL_EXPLAIN_1),
                                style: textStyle_size_18_color_white()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.LOCATE_CONNECTED_APPLIANCE_2),
                                style: textStyle_size_18_color_yellow()
                            ),
                            TextSpan(
                                text: LocaleUtil.getString(context, LocaleUtil.LOCATE_CONNECTED_APPLIANCE_3),
                                style: textStyle_size_18_color_white()
                            )
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                        ),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      onTapButton: () {
                        Navigator.of(context)
                            .pushNamed(Routes.ON_TOP_COMMISSIONING_ENTER_PASSWORD);
                      }
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}