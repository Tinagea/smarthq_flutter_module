import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigator_page/connect_plus_navigator.dart';

class SelectAppliancePage extends StatefulWidget {
  SelectAppliancePage({Key? key}) : super(key: key);

  _SelectAppliancePage createState() => _SelectAppliancePage();
}

class _SelectAppliancePage extends State<SelectAppliancePage>
    with WidgetsBindingObserver {
  ApplianceCategoryModel? selectedApplianceModel;

  @override
  Widget build(BuildContext context) {
    ApplianceCategoryModel? model =
        ModalRoute.of(context)?.settings.arguments as ApplianceCategoryModel?;
    this.selectedApplianceModel = model;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!
                .toUpperCase(),
            leftBtnFunction: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ).setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: ListView(
              children: <Widget>[
                BaseComponent.heightSpace(8.h),
                componentApplianceCategoryHeader(
                    applianceName: selectedApplianceModel != null
                        ? selectedApplianceModel!.applianceCategoryName
                        : '',
                    imagePath: selectedApplianceModel != null
                        ? selectedApplianceModel!.commissioningImagePath
                        : '',
                    marginInsets: EdgeInsets.symmetric(horizontal: 12.w)),
                componentApplianceCategoryList(
                  applianceModelList: selectedApplianceModel != null
                      ? selectedApplianceModel!.applianceModelList!
                      : List<ApplianceModel>.empty(),
                  imagePath: ImagePath.CATEGORY_STATUSINFO,
                  buttonImagePath: ImagePath.NAVIGATE_NEXT_ICON,
                  marginInsets: EdgeInsets.symmetric(horizontal: 12.w),
                ),
                componentApplianceCategoryListBottom(
                  marginInsets: EdgeInsets.symmetric(horizontal: 12.w),
                ),
                BaseComponent.heightSpace(20.h),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType == BleCommissioningStateType.MOVE_TO_ROOT_COMMISSIONING_PAGE
                        && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    Navigator.of(context, rootNavigator: true).popUntil((route) => route.settings.name == Routes.ADD_APPLIANCE_PAGE);
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        ));
  }

  static Widget componentApplianceCategoryHeader(
      {required String applianceName,
      required String imagePath,
      EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      height: 60.h,
      margin: marginInsets,
      decoration: BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                BaseComponent.widthSpace(13.w),
                Image.asset(imagePath, height: 29.h, width: 26.w),
                BaseComponent.widthSpace(15.w),
                Text(applianceName,
                    style: textStyle_size_16_bold_color_white()),
              ],
            ),
          ),
          Container(
            color: colorDeepDarkCharcoal(),
            height: 2.h,
            margin: EdgeInsets.symmetric(horizontal: 0),
          )
        ],
      ),
    );
  }

  Widget componentApplianceCategoryList(
      {required List<ApplianceModel> applianceModelList,
      required String imagePath,
      required String buttonImagePath,
      EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: marginInsets,
      decoration: BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: applianceModelList.length,
        separatorBuilder: (context, index) => Container(
          color: colorDeepDarkCharcoal(),
          height: 1.h,
          margin: EdgeInsets.fromLTRB(19.w, 0, 21.w, 0),
        ),
        itemBuilder: (context, index) {
          return Container(
            height: 59.h,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  navigateToRoute(context, applianceModelList[index]);
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 64.h,
                      width: 64.h,
                      child: applianceModelList[index].isInformation
                          ? InkWell(
                              onTap: () {
                                showInformationPopup(
                                    context, applianceModelList[index]);
                              },
                              child: Center(
                                child: Image.asset(imagePath,
                                    height: 18.h, width: 18.h),
                              ),
                            )
                          : SizedBox(),
                    ),
                    Expanded(
                      child: Text(
                        applianceModelList[index].applianceName ?? '',
                        style: textStyle_size_14_color_white(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BaseComponent.widthSpace(8.w),
                    Image.asset(ImagePath.NAVIGATE_NEXT_ICON,
                        width: 8.w, height: 30.h),
                    BaseComponent.widthSpace(14.w),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget componentApplianceCategoryListBottom(
      {EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      height: 5.h,
      margin: marginInsets,
      decoration: BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r), bottomRight: Radius.circular(10.r)),
      ),
    );
  }

  void navigateToRoute(BuildContext context, ApplianceModel model) {
    if (model.applianceType == ApplianceType.REFRIGERATOR) {
      Navigator.of(context).pushNamed(Routes.FRIDGE_SELECT_NAVIGATOR);
    }
    else if (model.applianceType == ApplianceType.ESPRESSO_COFFEE_MAKER) {
      Navigator.of(context).pushNamed(Routes.ESPRESSO_SELECT_NAVIGATOR);
    }
    else if (model.applianceType == ApplianceType.HOOD) {
      Navigator.of(context).pushNamed(Routes.HOOD_MAIN_NAVIGATOR);
    }
    else if (model.applianceType == ApplianceType.TOASTER_OVEN) {
      Navigator.of(context).pushNamed(Routes.TOASTER_OVEN_SELECT_NAVIGATOR);
    }
    else if (model.applianceType == ApplianceType.DISHWASHER) {
      Navigator.of(context).pushNamed(Routes.DISHWASHER_MAIN_NAVIGATOR);
    }
    else if (model.applianceType == ApplianceType.GAS_COOKTOP &&
        model.applianceName ==
            LocaleUtil.getString(context, LocaleUtil.HAVE_CONNECT_PLUS)) {
      Navigator.pushNamed(
          context,
          Routes.CONNECT_PLUS_MAIN_NAVIGATOR,
          arguments: ScreenArgs(ApplianceType.GAS_COOKTOP)
      );
    }
    else {
      var applianceSubType = ApplianceErd.getSubType(
          model.applianceType, context, model.applianceName);

      BlocProvider.of<BleCommissioningCubit>(context)
          .actionBleMoveToWelcomePage(
          model.applianceType, applianceSubType);
    }
  }

  void showInformationPopup(BuildContext context, ApplianceModel model) {

   CommonBaseAlertWithImageDialog baseDialog;
    String? content = '';
    String imagePath = '';
    String? yesString = LocaleUtil.getString(context, LocaleUtil.OK);
    VoidCallback yesFunction = () {
      Navigator.of(context, rootNavigator: true).pop();
    };

    if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.DUCTLESS_AIR_CONDITIONER).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_DUCTLESS_AIR_CONDITIONER);
      imagePath = ImagePath.CATEGORY_INFORMATION_DUCTLESS_AIRCONDITIONER;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_KNOB).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_WALL_KNOB_OVEN);
      imagePath = ImagePath.CATEGORY_INFORMATION_WALL_KNOB_OVEN;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_TOUCH_PAD).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_WALL_TOUCH_PAD_OVEN);
      imagePath = ImagePath.CATEGORY_INFORMATION_WALL_TOUCH_PAD_OVEN;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.RANGE_OR_WALL_OVEN).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_RANGE_OR_WALL_LCD_DISPLAY_OVEN);
      imagePath = ImagePath.CATEGORY_INFORMATION_RANGE_OR_WALL_LCD_DISPLAY_OVEN;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.WINE_CENTER).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_REFRIGERATION_WINE_CENTER);
      imagePath = ImagePath.CATEGORY_INFORMATION_REFRIGERATION_WINE_CENTER;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.BEVERAGE_CENTER).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_REFRIGERATION_BEVERAGE_CENTER);
      imagePath = ImagePath.CATEGORY_INFORMATION_REFRIGERATION_BEVERAGE_CENTER;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.WASHER_LCD_DISPLAY).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_LAUNDRY_WASHER_LCD);
      imagePath = ImagePath.CATEGORY_INFORMATION_LAUNDRY_WASHER_LCD;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.DRYER_LCD_DISPLAY).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_DRYER_LCD);
      imagePath = ImagePath.CATEGORY_INFORMATION_LAUNDRY_DRYER_LCD;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.WASHER_LCD_OR_DRYER_LCD).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_LAUNDRY_WASHER_OR_DRYER_LCD);
      imagePath = ImagePath.CATEGORY_INFORMATION_LAUNDRY_WASHER_OR_DRYER_LCD;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.WASHER_LCD)) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_LAUNDRY_WASHER_LCD_FNP);
      imagePath = ImagePath.CATEGORY_INFORMATION_LAUNDRY_WASHER_OR_DRYER_LCD;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.DRYER_LED_DISPLAY).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_LAUNDRY_DRYER_LED);
      imagePath = ImagePath.CATEGORY_INFORMATION_LAUNDRY_DRYER_LED;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.WASHER_LED_DISPLAY).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_LAUNDRY_WASHER_LED);
      imagePath = ImagePath.CATEGORY_INFORMATION_LAUNDRY_WASHER_LED;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_TOP_CONTROL_PANEL).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_DISH_DRAWER_TOP_CONTROL_PANEL);
      imagePath = ImagePath.CATEGORY_INFORMATION_DISH_DRAWER_TOP_CONTROL_PANEL;
    }
    else if (model.applianceName == LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_FRONT_CONTROL_PANEL).toString()) {
      content = LocaleUtil.getString(context, LocaleUtil.INFORMATION_DISH_DRAWER_FRONT_CONTROL_PANEL);
      imagePath = ImagePath.CATEGORY_INFORMATION_DISH_DRAWER_FRONT_CONTROL_PANEL;
    }

    baseDialog = CommonBaseAlertWithImageDialog(context: context, content: content, imagePath: imagePath, yesOnPressed: yesFunction, yes: yesString);
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }
}
