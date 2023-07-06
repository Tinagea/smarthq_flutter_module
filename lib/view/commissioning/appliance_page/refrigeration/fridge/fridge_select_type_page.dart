import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/connect_plus_navigator.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class PageFridgeSelectType extends StatefulWidget {
  PageFridgeSelectType({Key? key}) : super(key: key);

  _PageFridgeSelectType createState() => _PageFridgeSelectType();
}

class _PageFridgeSelectType extends State<PageFridgeSelectType>
    with WidgetsBindingObserver {

  var cont = 0;

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
    super.didUpdateWidget(oldWidget as PageFridgeSelectType);
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
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                  .toUpperCase(),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: true).pop();
              }).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: _buildGeneralFridgeTypeList(context),
            ),
          )),
    );
  }

  Wrap _buildGeneralFridgeTypeList(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 20.h,
      children: <Widget>[
        Component.componentApplianceSelectTypeTitle(
            title: LocaleUtil.getString(context, LocaleUtil.LOCATE_FRIDGE_TEMP_CONTROL)!),
        Component.componentApplianceVerticalListTile(context: context,
            title: LocaleUtil.getString(context, LocaleUtil.ON_THE_DISPENSER),
            imagePath: ImagePath.FRIDGE_MAIN_SELECT_IMAGE1,
            isLongIcon: true,
            clickedFunction: () {
              Navigator.pushNamed(context, Routes.DISPENSER_MAIN_NAVIGATOR);
            }),
        Component.componentApplianceVerticalListTile(context: context,
            title: LocaleUtil.getString(context, LocaleUtil.ON_THE_SIDE_OF_DOOR),
            imagePath: ImagePath.FRIDGE_MAIN_SELECT_IMAGE2,
            isLongIcon: true,
            clickedFunction: () {
              Navigator.pushNamed(context, Routes.SIDE_DOOR_MAIN_NAVIGATOR);
            }),
        Component.componentApplianceVerticalListTile(context: context,
            title: LocaleUtil.getString(context, LocaleUtil.ON_TOP),
            imagePath: ImagePath.FRIDGE_MAIN_SELECT_IMAGE3,
            isLongIcon: true,
            clickedFunction: () {
              globals.subRouteName = Routes.ON_TOP_DESCRIPTION1;
              Navigator.pushNamed(context, Routes.ON_TOP_MAIN_NAVIGATOR);
            }),
        Component.componentApplianceVerticalListTile(context: context,
            title: LocaleUtil.getString(context, LocaleUtil.HAVE_CONNECT_PLUS),
            height: 48.h,
            alignment: Alignment.center,
            clickedFunction: () {
              Navigator.pushNamed(
                  context,
                  Routes.CONNECT_PLUS_MAIN_NAVIGATOR,
                  arguments: ScreenArgs(ApplianceType.REFRIGERATOR));
            }),
      ],
    );
  }
}
