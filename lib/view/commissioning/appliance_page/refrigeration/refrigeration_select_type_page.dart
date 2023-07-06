import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class RefrigeratorApplianceTypePage extends StatefulWidget {
  RefrigeratorApplianceTypePage({Key? key}) : super(key: key);

  _RefrigeratorApplianceTypePage createState() =>
      _RefrigeratorApplianceTypePage();
}

class _RefrigeratorApplianceTypePage
    extends State<RefrigeratorApplianceTypePage> with WidgetsBindingObserver{
  ApplianceCategoryModel? selectedApplianceModel;
  List<ApplianceModel>? applianceModelList;

  @override
  Widget build(BuildContext context) {
    ApplianceCategoryModel? model =
    ModalRoute.of(context)?.settings.arguments as ApplianceCategoryModel?;
    this.selectedApplianceModel = model;

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
              BlocListener<BleCommissioningCubit, BleCommissioningState>(
                listenWhen: (previous, current) {
                  return (current.stateType == BleCommissioningStateType.MOVE_TO_ROOT_COMMISSIONING_PAGE
                      && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                },
                listener: (context, state) {
                  Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
                },
                child: Container(),
              ),
              BaseComponent.heightSpace(22.h),
              GridView.count(
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 15.h,
                crossAxisCount: 2,
                children: <Widget>[
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(context, LocaleUtil.FRIDGE)!,
                      imagePath: ImagePath.FRIDGE_SELECTION_IMAGE,
                      clickedFunction: (){
                        Navigator.pushNamed(
                            this.context, Routes.FRIDGE_SELECT_NAVIGATOR
                        );
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(context, LocaleUtil.BEVERAGE_CENTER)!,
                      imagePath: ImagePath.BEV_CENTER_SELECTION_IMAGE,
                      clickedFunction: (){
                        globals.subRouteName = Routes.BEVERAGE_CENTER_DESCRIPTION;
                        Navigator.of(context,rootNavigator: true).pushNamed(Routes.BEVERAGE_CENTER_MAIN_NAVIGATOR);
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(context, LocaleUtil.WINE_CENTER)!,
                      imagePath: ImagePath.WINE_CENTER_SELECTION_IMAGE,
                      clickedFunction: (){
                        globals.subRouteName = Routes.WINE_CENTER_DESCRIPTION;
                        Navigator.of(context,rootNavigator: true).pushNamed(Routes.WINE_CENTER_MAIN_NAVIGATOR);
                      }),
                  Component.componentApplianceGridListTile( context: context,
                      title: LocaleUtil.getString(context, LocaleUtil.UNDER_COUNTER_ICE_MAKER)!,
                      imagePath: ImagePath.UNDERCOUNTER_ICE_MAKER_SELECTION_IMAGE,
                      clickedFunction: (){
                        globals.subRouteName = Routes.UNDER_COUNTER_ICE_MAKER_DESCRIPTION;
                        Navigator.of(context,rootNavigator: true).pushNamed(Routes.UNDER_COUNTER_ICE_MAKER_MAIN_NAVIGATOR);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}