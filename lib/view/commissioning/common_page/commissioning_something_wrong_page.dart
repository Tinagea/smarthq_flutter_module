import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommissioningSomethingWrongPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: CommonAppBar(
                title: LocaleUtil.getString(
                    context, LocaleUtil.SOMETHING_WENT_WRONG)!
                    .toUpperCase())
                .setNavigationAppBar(context: context, leadingRequired: false, actionRequired: false),
            body: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: ListView(
                          children: <Widget>[
                            Container(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 450.h),
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Component.componentCenterTextBox(
                                          LocaleUtil.getString(
                                              context,
                                              LocaleUtil.WHAT_DO_YOU_SEE_APPLIANCE_CONTROL)!),
                                      BaseComponent.heightSpace(30.h),
                                      SvgPicture.asset(
                                        ImagePath.WIFI_STATUS,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 60.w),
                          child: Component.componentTwoBottomButtonWithWifi(
                              LocaleUtil.getString(context, LocaleUtil.FLASHING)!
                                  .toUpperCase(), () {
                            Navigator.of(context).pushNamed(
                                Routes.COMMON_MAIN_WRONG_RETRY_PAGE);
                          }, LocaleUtil.getString(context, LocaleUtil.SOLID)!
                              .toUpperCase(), () {
                            Navigator.of(context).pushNamed(
                                Routes.COMMON_MAIN_WRONG_RELAUNCH_PAGE);
                          })
                      ),
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}
