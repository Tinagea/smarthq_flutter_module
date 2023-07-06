import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class FridgeInTheMiddleLocateLabelFnpPage extends StatelessWidget {
  const FridgeInTheMiddleLocateLabelFnpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
          .setNavigationAppBar(context: context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Component.componentMainImageDynamicSize(
                      context: context,
                      imagePath: ImagePath
                          .IN_THE_MIDDLE_CONNECTED_APPLIANCE_INFORMATION,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 28.h)),
                  BaseComponent.heightSpace(24.h),
                  Component.greyCardBackground(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Component.greyCardText(
                          text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .IN_THE_MIDDLE_LOCATE_THE_CONNECTED_APPLIANCE_LABEL)!,
                        ),
                        BaseComponent.heightSpace(16.h),
                        Component.greyCardImageAndText(
                          imagePath: ImagePath.LABEL_LOCATION_B_MODEL_FRIDGE,
                          text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .IN_THE_MIDDLE_LOWER_COMPARTMENT_LABEL_DESCRIPTION)!,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                        ),
                        BaseComponent.heightSpace(16.h),
                        Component.greyCardImageAndText(
                          imagePath: ImagePath.LABEL_LOCATION_WINE_CABINET_FRIDGE,
                          text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .IN_THE_MIDDLE_WINE_CABINET_LABEL_DESCRIPTION)!,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                        ),
                        BaseComponent.heightSpace(16.h),
                        Component.greyCardText(
                          text: LocaleUtil.getString(
                              context, LocaleUtil.IN_THE_MIDDLE_LABEL_NOTE)!,
                        ),
                      ],
                    ),
                  ),
                  BaseComponent.heightSpace(16.h),
                ],
              ),
            ),
          ),
          Component.componentBottomButton(
              title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
              onTapButton: () {
                Navigator.of(context).pushNamed(Routes.IN_THE_MIDDLE_STEP4);
              })
        ],
      ),
    );
  }
}
