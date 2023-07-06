import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class PageRangeTouchButtonsSelectType extends StatefulWidget {
  PageRangeTouchButtonsSelectType({Key? key}) : super(key: key);

  _PageRangeTouchButtonsSelectType createState() => _PageRangeTouchButtonsSelectType();
}

class _PageRangeTouchButtonsSelectType extends State<PageRangeTouchButtonsSelectType>
    with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {}
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

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget as PageRangeTouchButtonsSelectType);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!
                  .toUpperCase())
              .setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: <Widget>[
                Component.componentApplianceSelectTypeTitle(
                    title: LocaleUtil.getString(context, LocaleUtil.WHICH_BUTTON_DOES_YOUR_RANGE_HAS)!),
                Component.componentMainSelectVerticalTypeImageButton(
                    context: context,
                    pushName: Routes.RANGE_REMOTE_ENABLE_DESCRIPTION,
                    imageName: ImagePath.RANGE_REMOTE_ENABLE,
                    text: LocaleUtil.getString(context, LocaleUtil.RANGE_REMOTE_ENABLE_BUTTON)!,
                    imageEdgeInsets: EdgeInsets.only(top: 40.h)),
                Component.componentMainSelectVerticalTypeImageButton(
                    context: context,
                    pushName: Routes.RANGE_WIFI_CONNECT_DESCRIPTION,
                    imageName: ImagePath.RANGE_WIFI_CONNECT,
                    text: LocaleUtil.getString(context, LocaleUtil.RANGE_WIFI_CONNECT_BUTTON)!,
                    imageEdgeInsets: EdgeInsets.only(top: 40.h)),
                Component.componentMainSelectVerticalTypeImageButton(
                    context: context,
                    pushName: Routes.RANGE_SETTINGS_DESCRIPTION,
                    imageName: ImagePath.RANGE_SETTING,
                    text: LocaleUtil.getString(context, LocaleUtil.RANGE_SETTING_BUTTON)!,
                    imageEdgeInsets: EdgeInsets.only(top: 40.h)),
              ],
            ),
          )),
    );
  }
}