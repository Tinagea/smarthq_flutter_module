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

class DispenserCommissioningModel2Step2 extends StatelessWidget {
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
                    context, ImagePath.SIDE_DOOR_2),
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
                        text: LocaleUtil.getString(
                            context, LocaleUtil.ON_RIGHT_SIDE_WALL),
                        style: textStyle_size_18_color_white())
                  ],
                ),
              ],
              Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                  onTapButton: () {
                    Navigator.of(context)
                        .pushNamed(Routes.DISPENSER_COMMISSIONING_ENTER_PASSWORD2);
                  }
              )
          ),
        )
    );
  }
}
