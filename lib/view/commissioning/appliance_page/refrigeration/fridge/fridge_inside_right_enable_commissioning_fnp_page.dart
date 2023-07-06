import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class FridgeInsideRightEnableCommissioningFnpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
        ).setNavigationAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Component.componentMainImage(
                        context,
                        ImagePath.RIGHT_ON_WALL_CONNECTED_APPLIANCE_INFORMATION,
                      ),
                      BaseComponent.heightSpace(30.h),
                      Component.componentTitleText(
                        title:
                        LocaleUtil.getString(context, LocaleUtil.CONNECT)!
                            .toUpperCase(),
                        marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                      ),
                      BaseComponent.heightSpace(10.h),
                      CustomRichText.addWifiTextBox(
                        spanStringList: [
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_1,
                            ),
                            style: textStyle_size_18_color_white(),
                          ),
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_2,
                            ),
                            style: textStyle_size_18_color_yellow(),
                          ),
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_3,
                            ),
                            style: textStyle_size_18_color_white(),
                          ),
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_4,
                            ),
                            style: textStyle_size_18_color_yellow(),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.wifi,
                              size: 24,
                              color: const Color(0xfff2a900),
                            ),
                          ),
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_5,
                            ),
                            style: textStyle_size_18_color_white(),
                          ),
                        ],
                        marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                    ],
                  ),
                ),
                Component.componentBottomButton(
                  title: LocaleUtil.getString(
                    context,
                    LocaleUtil.NEXT,
                  )!,
                  onTapButton: () {
                    _navigateToNextPage(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.of(context)
        .pushNamed(Routes.RIGHT_ON_WALL_COMMISSIONING_SHOW_TYPE);
  }
}
