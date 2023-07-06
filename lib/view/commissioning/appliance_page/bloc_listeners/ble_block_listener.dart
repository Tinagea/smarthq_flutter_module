/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 * Common block listener needed for continuous BLE scanning
 */

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';

class BleBlockListener {
  static BlocListener handleBlePairing({required BuildContext context}) {
    return BlocListener<BleCommissioningCubit, BleCommissioningState>(
      listenWhen: (previous, current) {
        return ((current.stateType == BleCommissioningStateType.START_PAIRING_ACTION2_RESULT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent)));
      },
      listener: (context, state) {
        if (state.stateType == BleCommissioningStateType.START_PAIRING_ACTION2_RESULT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent)) {
          geaLog.debug("BLE=> ble common listener");

          if (state.isSuccess == true) {
            CommonBleAlertDialog.fromCommonBaseAlertDialog(context: context).showCommonBleAlertDialog();
          }
        }
      },
      child: Container(),
    );
  }
}
