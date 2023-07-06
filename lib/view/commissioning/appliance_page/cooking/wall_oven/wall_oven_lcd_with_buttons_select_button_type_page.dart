import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';


class WallOvenSelectionPageType2 extends StatefulWidget {
  WallOvenSelectionPageType2({Key? key}) : super(key: key);

  _WallOvenSelectionPageType2 createState() => _WallOvenSelectionPageType2();
}

class _WallOvenSelectionPageType2 extends State<WallOvenSelectionPageType2>
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
    super.didUpdateWidget(oldWidget as WallOvenSelectionPageType2);
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
              ).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: <Widget>[
                Component.componentApplianceSelectTypeTitle(
                    title: LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_01)!),
                Component.componentMainSelectVerticalTypeImageButton(
                    context: context,
                    pushName: Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_ONE,
                    imageName: ImagePath.WALL_OVEN_TYPE_PRIMARY_2_PAGE_CHOOSER_IMAGE_ONE,
                    text: LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_02)!,
                    imageEdgeInsets: EdgeInsets.only(top: 40.h)),
                Component.componentMainSelectVerticalTypeImageButton(
                    context: context,
                    pushName: Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_TWO,
                    imageName: ImagePath.WALL_OVEN_TYPE_PRIMARY_2_PAGE_CHOOSER_IMAGE_TWO,
                    text: LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_03)!,
                    imageEdgeInsets: EdgeInsets.only(top: 40.h)),
                Component.componentMainSelectVerticalTypeImageButton(
                    context: context,
                    pushName: Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_THREE,
                    imageName: ImagePath.WALL_OVEN_TYPE_PRIMARY_2_PAGE_CHOOSER_IMAGE_THREE,
                    text: LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_TYPE_2_PRIMARY_DESC_04)!,
                    imageEdgeInsets: EdgeInsets.only(top: 40.h)),
              ],
            ),
          )),
    );
  }
}