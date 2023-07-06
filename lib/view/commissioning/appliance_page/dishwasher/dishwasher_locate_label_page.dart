import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/connect_plus_navigator.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class DishwasherDescription2 extends StatefulWidget {
  DishwasherDescription2({Key? key}) : super(key: key);

  _DishwasherDescription2 createState() => _DishwasherDescription2();
}

class _DishwasherDescription2 extends State<DishwasherDescription2> {
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
              Component.componentMainImage(context, ImagePath.DISHWASHER_1),
              BaseComponent.heightSpace(16.h),
              CustomRichText.customSpanListTextBox(
                textSpanList: <TextSpan>[TextSpan(text: LocaleUtil.getString(context, LocaleUtil.DISHWASHER_APPLIANCE_INFO_TEXT_1),
                      style: textStyle_size_18_color_white()),
                  TextSpan(
                      text: LocaleUtil.getString(context,
                          LocaleUtil.DISHWASHER_APPLIANCE_INFO_TEXT_2),
                      style: textStyle_size_18_color_yellow()),
                  TextSpan(
                      text: LocaleUtil.getString(context,
                          LocaleUtil.DISHWASHER_APPLIANCE_INFO_TEXT_3),
                      style: textStyle_size_18_color_white())
                ],
              ),
              BaseComponent.heightSpace(16.h),
              Component.componentDescriptionTextWithLinkActionLabel(
                contents: LocaleUtil.getString(context,
                    LocaleUtil.CAN_NOT_FIND_LABEL_YOU_MIGHT_NEED_CONNECT_PLUS)!,
                contentsForLink: LocaleUtil.getString(context,
                    LocaleUtil.CONNECT_PLUS)!,
                onTapButton:() {
                  Navigator.of(context, rootNavigator: true).pushNamed(Routes.CONNECT_PLUS_MAIN_NAVIGATOR,arguments: ScreenArgs(ApplianceType.DISHWASHER));
                },
                marginInsets: EdgeInsets.symmetric(horizontal: 29),
              ),
            ],
            Component.componentBottomButton(
                title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                onTapButton: () {
                  Navigator.of(context)
                      .pushNamed(Routes.DISHWASHER_DESCRIPTION3_MODEL3);
                }
            ),
          ),
        )
    );
  }
}
