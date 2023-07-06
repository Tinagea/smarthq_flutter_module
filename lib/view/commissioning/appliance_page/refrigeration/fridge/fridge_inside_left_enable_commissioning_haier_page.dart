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

class FridgeInsideLeftEnableCommissioningHaierPage extends StatelessWidget {
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
                        ImagePath.LEFT_ON_WALL_ENABLE_COMMISSIONING,
                      ),
                      BaseComponent.heightSpace(16.h),
                      Component.componentTitleText(
                        title: LocaleUtil.getString(
                            context, LocaleUtil.WIFI_CONNECT)!
                            .toUpperCase(),
                        marginInsets:
                        EdgeInsets.symmetric(horizontal: 28.w),
                      ),
                      BaseComponent.heightSpace(58.h),
                      CustomRichText.addWifiTextBox(
                        spanStringList: [
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_1_STEP2,
                            ),
                          ),
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_2_STEP2,
                            ),
                            style: textStyle_size_18_color_yellow(),
                          ),
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil
                                  .LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_3_STEP2,
                            ),
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
                              LocaleUtil
                                  .LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_4_STEP2,
                            ),
                          )
                        ],
                        marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                      BaseComponent.heightSpace(16.h),
                    ],
                  ),
                ),
                Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                  onTapButton: () {
                    _navigateToNextPage(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.LEFT_ON_WALL_DESCRIPTION4_MODEL1);
  }
}
