import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/connect_plus_navigator.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class PageCooktopSelectOption extends StatefulWidget {
  PageCooktopSelectOption({Key? key}) : super(key: key);

  _PageCooktopSelectOption createState() => _PageCooktopSelectOption();
}

class _PageCooktopSelectOption extends State<PageCooktopSelectOption>
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
    super.didUpdateWidget(oldWidget as PageCooktopSelectOption);
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
              title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: true).pop();
              }).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
              child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 20.h,
                  children: <Widget>[
                    Component.componentApplianceSelectTypeTitle(
                        title: LocaleUtil.getString(context, LocaleUtil.WHICH_ONE_LOOK_LIKE)!),
                    Component.componentMainSelectImageButton(
                        context: context,
                        pushName: Routes.COOKTOP_INDUCTION_DESCRIPTION,
                        imageName: ImagePath.COOKTOP_INDUCTION),
                    Component.componentMainSelectImageButton(
                        context: context,
                        pushName: Routes.COOKTOP_ELECTRIC_DESCRIPTION,
                        imageName: ImagePath.COOKTOP_ELECTRIC),
                    Component.componentMainSelectImageButton(
                        context: context,
                        pushName: Routes.COOKTOP_GAS_DESCRIPTION,
                        imageName: ImagePath.COOKTOP_GAS),
                    Component.componentApplianceVerticalListTile(context: context,
                        title: LocaleUtil.getString(context, LocaleUtil.HAVE_CONNECT_PLUS),
                        height: 48.h,
                        alignment: Alignment.center,
                        clickedFunction: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                              Routes.CONNECT_PLUS_MAIN_NAVIGATOR,
                              arguments: ScreenArgs(ApplianceType.COOKTOP_STANDALONE));
                    }),
                  ]
              )
          )
      ),
    );
  }
}

