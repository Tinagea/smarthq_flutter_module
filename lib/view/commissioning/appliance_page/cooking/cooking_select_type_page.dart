import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class CookingApplianceTypePage extends StatefulWidget {
  CookingApplianceTypePage({Key? key}) : super(key: key);

  _CookingApplianceTypePage createState() =>
      _CookingApplianceTypePage();
}

class _CookingApplianceTypePage
    extends State<CookingApplianceTypePage> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: LocaleUtil.getString(
            context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),)
          .setNavigationAppBar(context: context, leadingRequired: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              BaseComponent.heightSpace(22.h),
              GridView.count(
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 15.h,
                crossAxisCount: 2,
                children: <Widget>[
                  Component.componentApplianceGridListTile( context: context,
                  title: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN)!,
                      imagePath: ImagePath.WALL_OVEN,
                      clickedFunction: (){
                        routesByNavigator(Routes.WALL_OVEN_MAIN_NAVIGATOR);
                  }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(
                          context, LocaleUtil.RANGE)!,
                      imagePath: ImagePath.RANGE,
                      clickedFunction: (){
                        routesByNavigator(Routes.RANGE_MAIN_NAVIGATOR);
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(
                          context, LocaleUtil.COOKTOP)!,
                      imagePath: ImagePath.COOKTOP,
                      clickedFunction: (){
                        routesByNavigator(Routes.COOKTOP_MAIN_NAVIGATOR);
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(
                          context, LocaleUtil.MICROWAVE)!,
                      imagePath: ImagePath.MICROWAVE,
                      clickedFunction: (){
                        routesByNavigator(Routes.MICROWAVE_MAIN_NAVIGATOR);
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(
                          context, LocaleUtil.ADVANTIUM)!,
                      imagePath: ImagePath.ADVANTIUM,
                      clickedFunction: (){
                        routesByNavigator(Routes.ADVANTIUM_MAIN_NAVIGATOR);
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(
                          context, LocaleUtil.HEARTH_OVEN)!,
                      imagePath: ImagePath.HEARTH_OVEN,
                      clickedFunction: (){
                        routesByNavigator(Routes.HEARTH_OVEN_MAIN_NAVIGATOR);
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(
                          context, LocaleUtil.VENTILATION)!,
                      imagePath: ImagePath.VENTILATION,
                      clickedFunction: (){
                        routesByNavigator(Routes.HOOD_MAIN_NAVIGATOR);
                      }),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void routesByNavigator(String? route) {
    if (route != null) {
      if (route == Routes.RANGE_MAIN_NAVIGATOR) {
        globals.subRouteName = Routes.RANGE_SELECT;
        Navigator.of(context,rootNavigator: true).pushNamed(Routes.RANGE_MAIN_NAVIGATOR);
      } else if (route == Routes.WALL_OVEN_MAIN_NAVIGATOR) {
        globals.subRouteName = Routes.WALL_OVEN_SELECTOR_PRIMARY;
        Navigator.of(context,rootNavigator: true).pushNamed(Routes.WALL_OVEN_MAIN_NAVIGATOR);
      } else if (route == Routes.ADVANTIUM_MAIN_NAVIGATOR) {
        globals.subRouteName = Routes.ADVANTIUM_PASSWORD_INFO;
        Navigator.of(context,rootNavigator: true).pushNamed(Routes.ADVANTIUM_MAIN_NAVIGATOR);
      } else {
        Navigator.pushNamed(
            this.context,
            route
        );
      }
    }
  }
}
