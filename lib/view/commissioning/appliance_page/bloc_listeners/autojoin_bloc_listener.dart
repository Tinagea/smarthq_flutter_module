/// file: autojoin_bloc_listener.dart
/// date: July/04/2022
/// brief: A class to use for auto join bloc listener
/// Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class AutoJoinBlocListener {

  /// This method is used to handle response after attempting auto join to wifi
  static BlocListener handleAutoJoinResponse(LoadingDialog loadingDialog, {bool restartContinuousScan = false}) {
    return BlocListener<CommissioningCubit, CommissioningState>(
      listenWhen: (previous, current) {
        return current.stateType == CommissioningStateType.AUTO_JOIN;
      },
      listener: (context, state) {
        if (state.stateType == CommissioningStateType.AUTO_JOIN) {
          if (state.autoJoinStatusType != null) {
            loadingDialog.close(context);
            BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
            if (state.autoJoinStatusType == AutoJoinStatusType.success) {
              geaLog.debug("auto join success");
              globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
              Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
            } else if (state.autoJoinStatusType == AutoJoinStatusType.fail || state.autoJoinStatusType == AutoJoinStatusType.unSupport) {
              geaLog.debug("auto join failed or unsupported");
              if (RepositoryProvider
                  .of<BleCommissioningStorage>(context)
                  .savedStartByBleCommissioning == true) {
                CommonBleAlertDialog.fromCommonBaseAlertDialog(context: context).showCommonBleAlertDialog();
                return;
              }
              var autoConnectFailDialog = CommonBaseAlertDialog(
                  context: context,
                  title: LocaleUtil.getString(context, LocaleUtil.OOPS),
                  content: LocaleUtil.getString(context, LocaleUtil.AUTO_JOIN_FAILED_TRY_MANUALLY),
                  yesOnPressed: () {
                    globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                    Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR).then((_) =>
                        BlocProvider.of<BleCommissioningCubit>(context).restartContinuousScanForAppliance(restartContinuousScan: restartContinuousScan));
                  },
                  yesString: LocaleUtil.getString(context, LocaleUtil.OK));
              showDialog(context: context, builder: (context) => autoConnectFailDialog);
            }
          }
        }
      },
      child: Container(),
    );
  }

}
