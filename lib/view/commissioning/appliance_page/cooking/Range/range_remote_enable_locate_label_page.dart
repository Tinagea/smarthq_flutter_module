import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class RangeTypeTwoRemoteEnabledApplianceInfo extends StatefulWidget {
  RangeTypeTwoRemoteEnabledApplianceInfo({Key? key}) : super(key: key);

  _RangeTypeTwoRemoteEnabledApplianceInfo createState() => _RangeTypeTwoRemoteEnabledApplianceInfo();
}

class _RangeTypeTwoRemoteEnabledApplianceInfo extends State<RangeTypeTwoRemoteEnabledApplianceInfo> {
  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
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
              Component.componentMainImage(context, ImagePath.RANGE_HAIER_KNOB_APPLIANCE_INFO),
              BaseComponent.heightSpace(16.h),
              CustomRichText.customSpanListTextBox(
                textSpanList: <TextSpan>[
                  TextSpan(text: LocaleUtil.getString(context, LocaleUtil.RANGE_HAIER_KNOB_APPLIANCE_INFO), style: textStyle_size_18_color_white()),
                ],
              ),
            ],
            Component.componentBottomButton(
                title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                onTapButton: () {
                  RepositoryProvider.of<WifiCommissioningStorage>(context).setUsiType = true;
                  globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                }),
          ),
        ));
  }
}
