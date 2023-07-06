import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class WallOvenSelectionPagePrimary extends StatefulWidget {
  WallOvenSelectionPagePrimary({Key? key}) : super(key: key);

  _WallOvenSelectionPagePrimary createState() => _WallOvenSelectionPagePrimary();
}

class _WallOvenSelectionPagePrimary extends State<WallOvenSelectionPagePrimary>
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
    super.didUpdateWidget(oldWidget as WallOvenSelectionPagePrimary);
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
                    title: LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_SELECTION_TEXT_PRIMARY)!),
                Component.componentMainSelectImageButton(
                    context: context,
                    pushName: Routes.WALL_OVEN_PRIMARY_TYPE_1_PAGE_PASSWORD_1,
                    imageName: ImagePath.WALL_OVEN_TYPE_PRIMARY_1),
                Component.componentMainSelectImageButton(
                    context: context,
                    pushName: Routes.WALL_OVEN_SELECTOR_TYPE_2,
                    imageName: ImagePath.WALL_OVEN_TYPE_PRIMARY_2),
                Component.componentMainSelectImageButton(
                    context: context,
                    pushName: Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_1,
                    imageName: ImagePath.WALL_OVEN_TYPE_PRIMARY_3),
              ],
            ),
          )),
    );
  }
}