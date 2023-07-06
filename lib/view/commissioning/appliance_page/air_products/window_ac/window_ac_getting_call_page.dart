import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WindowACCall extends StatefulWidget {
  @override
  _WindowACCallState createState() => _WindowACCallState();
}

class _WindowACCallState extends State<WindowACCall> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          ).setNavigationAppBar(context: context),
      body: Component.componentCommissioningBody(
        context,
        <Widget>[
          Component.componentMainPngImage(
              context, ImagePath.WINDOWS_AC_WIFI_CONNECT),
          BaseComponent.heightSpace(16),
          CustomRichText.addWifiTextBox(
            spanStringList: [
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WINDOW_AC_SETUP_DESC_16),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WINDOW_AC_SETUP_DESC_17),
                  style: textStyle_size_18_color_yellow_underlined()),
            ],
            marginInsets: EdgeInsets.symmetric(horizontal: 16),

          ),
          BaseComponent.heightSpace(16)
        ],
        Component.componentCommissioningBottomButton(context, LocaleUtil.getString(context, LocaleUtil.BACK)!, () {
          BlocProvider.of<CommissioningCubit>(context).initState();
          BlocProvider.of<CommissioningCubit>(context).actionRequestGeModuleReachability(false);

          BlocProvider.of<BleCommissioningCubit>(context).initState();
          BlocProvider.of<BleCommissioningCubit>(context).actionBleStopScanning();

          Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);

          SystemNavigator.pop(animated: true);
          BlocProvider.of<CommissioningCubit>(context).actionRequestRelaunch();

        }),
      ),
    );
}}
