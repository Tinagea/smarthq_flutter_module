import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class CommissioningWrongNetworkPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.SOMETHING_WENT_WRONG)!.toUpperCase())
              .setNavigationAppBar(context: context, actionRequired: false, leadingRequired: false),
          body: Component.componentCommissioningBody(
            context,
            <Widget>[
              Component.componentMainImage(context, ImagePath.WIFI_ROUTER),
              BaseComponent.heightSpace(95.h),
              Component.componentInformationText(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.COULD_NOT_CONNECT_TO_HOME_WIFE)!,
                  marginInsets: EdgeInsets.symmetric(horizontal: 30.w)),
            ],
            Component.componentBottomButton(
                title: LocaleUtil.getString(context, LocaleUtil.RE_ENTER_PASSWORD)!,
                onTapButton: () {
                  final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
                  if (storage.savedStartByBleCommissioning == true) {
                    final cubit = BlocProvider.of<BleCommissioningCubit>(context);
                    cubit.actionBleSetRetryPasswordFlag();
                    Navigator.of(context).popUntil((route) => route.settings.name == Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE);
                  }
                  else {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                }),
          ),
        )
    );
  }
}
