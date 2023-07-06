import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class PageToasterOvenSelectType extends StatefulWidget {
  PageToasterOvenSelectType({Key? key}) : super(key: key);

  _PageToasterOvenSelectType createState() => _PageToasterOvenSelectType();
}

class _PageToasterOvenSelectType extends State<PageToasterOvenSelectType>
    with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent))
      return;

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
    super.didUpdateWidget(oldWidget as PageToasterOvenSelectType);
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
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.CAFE_TOASTER_OVEN)!,
                    imagePath: ImagePath.TOASTER_OVEN_ICON,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.TOASTER_OVEN_CAFE_NAVIGATOR,
                      );
                    }),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.PROFILE_TOASTER_OVEN)!,
                    imagePath: ImagePath.PROFILE_TOASTER_OVEN_ICON,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.TOASTER_OVEN_PROFILE_NAVIGATOR,
                      );
                    }),
              ],
            ),
          ),
      )
    );
  }
}
