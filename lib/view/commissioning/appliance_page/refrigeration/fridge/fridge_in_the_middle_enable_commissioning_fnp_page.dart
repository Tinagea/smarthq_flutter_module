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

class FridgeInTheMiddleEnableCommissioningFnpPage extends StatefulWidget {
  FridgeInTheMiddleEnableCommissioningFnpPage({Key? key}) : super(key: key);

  @override
  _FridgeInTheMiddleEnableCommissioningFnpPageState createState() =>
      _FridgeInTheMiddleEnableCommissioningFnpPageState();
}

class _FridgeInTheMiddleEnableCommissioningFnpPageState
    extends State<FridgeInTheMiddleEnableCommissioningFnpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
          .setNavigationAppBar(context: context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Component.componentMainImageDynamicSize(
                      context: context,
                      imagePath: ImagePath.IN_THE_MIDDLE_INSTRUCTION_2,
                      padding: EdgeInsets.symmetric(horizontal: 64.w)),
                  BaseComponent.heightSpace(16.h),
                  CustomRichText.addWifiTextBox(
                    spanStringList: [
                      TextSpan(
                        text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .IN_THE_MIDDLE_TURN_ON_WIFI_PAIRING_INSTRUCTION_PART_1),
                        style: textStyle_size_18_color_white(),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.wifi,
                          size: 24,
                          color: const Color(0xfff2a900),
                        ),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(
                            context,
                            LocaleUtil
                                .IN_THE_MIDDLE_TURN_ON_WIFI_PAIRING_INSTRUCTION_PART_2),
                        style: textStyle_size_18_color_white(),
                      )
                    ],
                    marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                ],
              ),
            ),
          ),
          Component.componentBottomButton(
            title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
            onTapButton: () {
              Navigator.of(context).pushNamed(Routes.IN_THE_MIDDLE_STEP3);
            },
          ),
        ],
      ),
    );
  }
}
