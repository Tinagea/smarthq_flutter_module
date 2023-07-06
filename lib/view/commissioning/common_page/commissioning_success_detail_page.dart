import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommissioningSuccessDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
                  title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                      .toUpperCase())
              .setNavigationAppBar(context: context),
          body: Component.componentCommissioningBody(
            context,
            <Widget>[
              BaseComponent.heightSpace(50.h),
              Component.componentTitleText(
                  title: LocaleUtil.getString(
                      context, LocaleUtil.COMMISSIONING_SUCCESS_DETAIL_TEXT_1)!,
                  marginInsets: EdgeInsets.symmetric(horizontal: 20.w)),
              BaseComponent.heightSpace(30.h),
              Component.componentDescriptionTextWithBox(
                  context: context,
                  contents: LocaleUtil.getString(
                      context, LocaleUtil.COMMISSIONING_SUCCESS_DETAIL_TEXT_2)!,
                  marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
              BaseComponent.heightSpace(20.h),
              Component.componentDescriptionTextWithBox(
                  context: context,
                  contents: LocaleUtil.getString(
                      context, LocaleUtil.COMMISSIONING_SUCCESS_DETAIL_TEXT_3)!),
              BaseComponent.heightSpace(20.h),
              Component.componentDescriptionTextWithBox(
                  context: context,
                  contents: LocaleUtil.getString(
                      context, LocaleUtil.COMMISSIONING_SUCCESS_DETAIL_TEXT_3)!),
            ],
            Component.componentBottomButton(
                title: LocaleUtil.getString(context, LocaleUtil.GET_STARTED)!,
                onTapButton: () {
                  // Navigator.of(context).pushNamed(
                  //     'commissioning/success_detail_page');
                }),
          ),
        ));
  }
}
