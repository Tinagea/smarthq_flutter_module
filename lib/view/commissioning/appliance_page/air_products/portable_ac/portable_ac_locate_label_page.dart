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

class PortableACApplianceInfoPage extends StatefulWidget {
  PortableACApplianceInfoPage({Key? key}) : super(key: key);

  _PortableACApplianceInfoPage createState() => _PortableACApplianceInfoPage();
}

class _PortableACApplianceInfoPage extends State<PortableACApplianceInfoPage> {
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
                  context, ImagePath.PORTABLE_AC_APPLIANCE_INFO),
              BaseComponent.heightSpace(16.h),
              CustomRichText.customSpanListTextBox(
                textSpanList: <TextSpan>[
                  TextSpan(
                      text: LocaleUtil.getString(context, LocaleUtil.PORTABLE_AC_APPLIANCE_INFO),
                      style: textStyle_size_18_color_white()),
                ],
              ),
            ],
            Component.componentBottomButton(
                title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                onTapButton: () {
                  Navigator.of(context)
                      .pushNamed(Routes.PORTABLE_AC_APPLIANCE_PASSWORD);
                }
            ),
          ),
        )
    );
  }
}
