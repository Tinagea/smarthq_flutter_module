import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class PageDuctlessACSelectType extends StatefulWidget {
  PageDuctlessACSelectType({Key? key}) : super(key: key);

  _PageDuctlessACSelectType createState() => _PageDuctlessACSelectType();
}

class _PageDuctlessACSelectType extends State<PageDuctlessACSelectType>
    with WidgetsBindingObserver {
  var cont = 0;

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
    super.didUpdateWidget(oldWidget as PageDuctlessACSelectType);
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
                  .toUpperCase(),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: true).pop();
              }).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: <Widget>[
                Component.componentApplianceSelectTypeTitle(
                    title: LocaleUtil.getString(
                        context, LocaleUtil.DOES_YOUR_UNIT_HAS_BUILT_IN_WIF)!),
                Component.componentCenterDescriptionText(
                    text: LocaleUtil.getString(
                        context, LocaleUtil.PLEASE_CHECK_USER_MANUAL)!),
                Component.componentMainSelectVerticalImageButton(
                    context: context,
                    imageName: ImagePath.BUILT_IN_WIFI,
                    text: LocaleUtil.getString(
                        context, LocaleUtil.YES_IT_HAS_BUILT_IN_WIFI)!,
                    pushName: Routes.DUCTLESS_AC_BUILT_IN_WIFI_DESC_PAGE_1
                ),
                Component.componentMainSelectVerticalImageButton(
                    context: context,
                    imageName: ImagePath.USB_DONGLE_WIFI,
                    text: LocaleUtil.getString(
                        context, LocaleUtil.HAVE_USB_WIFI_ADAPTER)!,
                    pushName: Routes.DUCTLESS_AC_USB_WIFI_DESCRIPTION_PAGE),
                Component.componentDescriptionTextWithLinkLabel(
                  contents: LocaleUtil.getString(
                      context, LocaleUtil.LEARN_MORE_ABOUT)!,
                  contentsForLink: LocaleUtil.getString(
                      context, LocaleUtil.USB_WIFI_ADAPTER)!,
                  link: LocaleUtil.getString(
                      context, LocaleUtil.CONNECT_PLUS_HOW_TO_URL)!,
                  marginInsets: EdgeInsets.symmetric(horizontal: 46.w),
                ),
              ],
            ),
          )),
    );
  }
}
