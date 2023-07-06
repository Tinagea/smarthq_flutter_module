import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class CommissioningSomethingWrongRetryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
                  title: LocaleUtil.getString(
                      context, LocaleUtil.SOMETHING_WENT_WRONG))
              .setNavigationAppBar(context: context, actionRequired: false),
          body: Component.componentCommissioningBody(
            context,
            <Widget>[
              BaseComponent.heightSpace(30.h),
              Component.componentMainImage(
                  context, ImagePath.APPLIANCE_INFORMATION_PASSWORD),
              BaseComponent.heightSpace(50.h),
              Component.componentInformationText(
                text: LocaleUtil.getString(
                    context, LocaleUtil.SOMETHING_WENT_WRONG_RETRY_TEXT_1)!,
                marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
              ),
            ],
            Component.componentCommissioningBottomButton(
              context,
              LocaleUtil.getString(context, LocaleUtil.RETRY)!,
              () {
                Navigator.of(context, rootNavigator: true).popUntil((route) => route.settings.name == Routes.ADD_APPLIANCE_PAGE);
              },
            ),
          ),
        ));
  }
}
