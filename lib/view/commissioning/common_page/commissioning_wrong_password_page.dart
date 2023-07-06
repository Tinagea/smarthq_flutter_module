import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

import 'package:smarthq_flutter_module/globals.dart' as globals;


class CommissioningWrongPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CommonAppBar(
            title: LocaleUtil.getString(
                context, LocaleUtil.WRONG_PASSWORD))
            .setNavigationAppBar(context: context),
        body: Component.componentCommissioningBody(
          context,
          <Widget>[
            Component.componentMainImage(context, ImagePath.APPLIANCE_INFORMATION_PASSWORD),
            BaseComponent.heightSpace(16.h),
            Component.componentDescriptionTextWithBox(context: context, contents: LocaleUtil.getString(
                context, LocaleUtil.ACM_WRONG_PASSWORD_INFORMATION_TEXT)!, marginInsets: EdgeInsets.symmetric(horizontal: 28.w)
            ),
          ],
          Component.componentCommissioningBottomButton(
            context,
            LocaleUtil.getString(context, LocaleUtil.RETRY)!,
                () {
                  if (globals.routeNameToBack == Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_3) {
                    BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
                  }
              Navigator.of(context, rootNavigator:true).pop();
            },
          ),
        ),
      ),
    );
  }
}
