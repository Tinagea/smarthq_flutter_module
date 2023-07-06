import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WallOvenPrimaryTypeThreePage2 extends StatefulWidget {
  @override
  _WallOvenPrimaryTypeThreePage2 createState() => _WallOvenPrimaryTypeThreePage2();
}

class _WallOvenPrimaryTypeThreePage2 extends State<WallOvenPrimaryTypeThreePage2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
                  title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                      .toUpperCase())
              .setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(
                            context, ImagePath.WALL_OVEN_TYPE_PRIMARY_3_PAGE_2),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.addWifiTextBox(
                          spanStringList:[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .WALL_OVEN_TYPE_3_PRIMARY_DESC_7),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .WALL_OVEN_TYPE_3_PRIMARY_DESC_8),
                                style: textStyle_size_18_color_yellow()),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .WALL_OVEN_TYPE_3_PRIMARY_DESC_9),
                                style: textStyle_size_18_color_white()),
                            WidgetSpan(
                                child: Icon(
                                  Icons.wifi,
                                  size: 24,
                                  color: colorSelectiveYellow(),
                                )),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_10),
                                style: textStyle_size_18_color_white()),
                            WidgetSpan(
                              child: SvgPicture.asset(ImagePath.GENERIC_RECTANGLE),
                              alignment: PlaceholderAlignment.middle,),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_11),
                                style: textStyle_size_18_color_white()),
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_12),
                                style: textStyle_size_18_color_white()),

                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w)
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled: true,
                      onTapButton: () {
                        Navigator.of(context)
                            .pushNamed(Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_3);
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
