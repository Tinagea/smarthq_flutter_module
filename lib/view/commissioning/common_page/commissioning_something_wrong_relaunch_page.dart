import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommissioningSomethingWrongRelaunchPage extends StatelessWidget {
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
                  context,
                  ImagePath.NO_NETWORK),
              BaseComponent.heightSpace(50.h),
              Component.componentInformationText(
                text: LocaleUtil.getString(
                    context, LocaleUtil.SOMETHING_WENT_WRONG_RELAUNCH_TEXT_1)!,
                marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
              ),
            ],
            Component.componentCommissioningBottomButton(
              context,
              LocaleUtil.getString(context, LocaleUtil.RELAUNCH_APP)!,
              () {
                Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);

                SystemNavigator.pop(animated: true);
                BlocProvider.of<CommissioningCubit>(context).actionMoveToNativeBackPage();

                BlocProvider.of<CommissioningCubit>(context).actionRequestRelaunch();
              },
            ),
          ),
        ));
  }
}
