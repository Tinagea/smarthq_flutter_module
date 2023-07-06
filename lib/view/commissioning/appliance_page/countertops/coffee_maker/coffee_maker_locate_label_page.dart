import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class CoffeeMakerDescription extends StatefulWidget {
  CoffeeMakerDescription({Key? key}) : super(key: key);

  _CoffeeMakerDescription createState() => _CoffeeMakerDescription();
}

class _CoffeeMakerDescription extends State<CoffeeMakerDescription> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                  .toUpperCase(),
              leftBtnFunction: () {
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
          body: Component.componentCommissioningBody(
            context,
            <Widget>[
              Component.componentMainPngImage(
                  context, ImagePath.COFFEEMAKER_2),
              BaseComponent.heightSpace(16),
              CustomRichText.customSpanListTextBox(
                textSpanList: <TextSpan>[
                  TextSpan(
                      text: LocaleUtil.getString(context, LocaleUtil.LOCATE_LABEL_EXPLAIN_1),
                      style: textStyle_size_18_color_white()),
                  TextSpan(
                      text: LocaleUtil.getString(context, LocaleUtil.LOCATE_LABEL_EXPLAIN_2),
                      style: textStyle_size_18_color_yellow()),
                  TextSpan(
                      text: LocaleUtil.getString(context, LocaleUtil.COFFEE_MAKER_APPLIANCE_INFO_TEXT),
                      style: textStyle_size_18_color_white())
                ],
              ),
            ],
            Component.componentBottomButton(
                title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                onTapButton: () {
                  Navigator.of(context)
                      .pushNamed(Routes.COFFEEMAKER_DESCRIPTION3_MODEL3);
                }
            ),
          ),
        )
    );
  }
}
