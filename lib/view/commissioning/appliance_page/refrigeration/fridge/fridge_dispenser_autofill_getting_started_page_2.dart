import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DispenserCommissioningModel3Step2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
              leftBtnFunction: () {
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
          body: Component.componentCommissioningBody(
              context,
              <Widget>[
                BleBlockListener.handleBlePairing(context: context),
                Component.componentMainImage(context, ImagePath.SIDE_DOOR_2),
                BaseComponent.heightSpace(16.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    gradient: gradientDarkGreyCharcoalGrey(),
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                  child: Column(
                    children: [
                      Text(LocaleUtil.getString(
                          context, LocaleUtil.LOCATE_THE_CONNECTED_APPLIANCE_LABEL)!,
                          style: textStyle_size_18_color_white()),
                      BaseComponent.heightSpace(15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SvgPicture.asset(
                            ImagePath.TWO_DOOR_FRIDGE,
                            width: 46.w,
                            height: 73.h,
                          ),
                          BaseComponent.widthSpace(33.w),
                          Text(LocaleUtil.getString(context, LocaleUtil.BOTTOM_FREEZER_EXPLAIN)!,
                              style: textStyle_size_18_color_white()),
                        ],
                      ),
                      BaseComponent.heightSpace(15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SvgPicture.asset(
                            ImagePath.TOP_FRIDGE,
                            width: 46.w,
                            height: 73.h,
                          ),
                          BaseComponent.widthSpace(33.w),
                          Text(LocaleUtil.getString(context, LocaleUtil.SIDE_BY_SIDE_EXPLAIN)!,
                              style: textStyle_size_18_color_white()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                  onTapButton: () {
                    Navigator.of(context).pushNamed(
                        Routes.DISPENSER_COMMISSIONING_ENTER_PASSWORD2);
                  })),
        ));
  }
}
