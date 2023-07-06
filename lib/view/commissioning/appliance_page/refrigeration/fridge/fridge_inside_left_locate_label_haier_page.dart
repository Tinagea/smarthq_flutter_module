import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class FridgeInsideLeftLocateLabelHaierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(
            context,
            LocaleUtil.ADD_APPLIANCE,
          ),
        ).setNavigationAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Component.componentMainImage(
                          context,
                          ImagePath.LEFT_ON_WALL_LABEL,
                        ),
                      ),
                      BaseComponent.heightSpace(16.h),
                      Component.greyCardBackground(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Component.greyCardText(
                              text: LocaleUtil.getString(
                                  context,
                                  LocaleUtil
                                      .LOCATE_THE_CONNECTED_APPLIANCE_LABEL)!,
                            ),
                            BaseComponent.heightSpace(16.h),
                            _greyCardImageAndText(
                              imagePath: ImagePath.FRIDGE_HAIER_QUAD_DOOR,
                              title: LocaleUtil.getString(
                                  context, LocaleUtil.QUAD_DOOR_MODELS)!,
                              text: LocaleUtil.getString(
                                  context,
                                  LocaleUtil
                                      .ON_THE_RIGHT_SIDE_OF_THE_MIDDLE_CROSS_RAIL)!,
                            ),
                            BaseComponent.heightSpace(16.h),
                            Text(
                              LocaleUtil.getString(context,
                                  LocaleUtil.QUAD_DOOR_LABEL_NOTE)!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BaseComponent.heightSpace(16.h),
                    ],
                  ),
                ),
                Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                  onTapButton: () {
                    Navigator.of(context).pushNamed(
                      Routes.LEFT_ON_WALL_COMMISSIONING_ENTER_PASSWORD,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _greyCardImageAndText(
      {EdgeInsets? padding,
      required String imagePath,
      required String title,
      required String text}) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(children: [
        SizedBox(
          width: 50.0,
          child: SvgPicture.asset(
            imagePath,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: textStyle_size_18_bold_color_white(),
                ),
                TextSpan(
                  text: "\n",
                ),
                TextSpan(
                  text: text,
                  style: textStyle_size_18_color_white(),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
