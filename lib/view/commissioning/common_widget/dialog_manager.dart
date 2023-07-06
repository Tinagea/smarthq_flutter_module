
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'common_alert_dialog.dart';

enum FlutterDialogType {
  checkModuleStatus
}

class DialogManager {

  static final DialogManager _singleton = new DialogManager._internal();

  factory DialogManager() {
    return _singleton;
  }

  DialogManager._internal() {
    geaLog.debug("called DialogManager._internal");
  }

  void showBleBluetoothEnableAlertDialog({
    required BuildContext context, VoidCallback? onYesPressed}) {

    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.HOME_BLE_BLUETOOTH_ENABLE_ERROR_TITLE),
        content: LocaleUtil.getString(context, LocaleUtil.HOME_BLE_BLUETOOTH_ENABLE_ERROR_MESSAGE),
        yesString: LocaleUtil.getString(context, LocaleUtil.OK),
        yesOnPressed: onYesPressed != null
            ? onYesPressed
            : () {
          CommissioningUtil.openBluetoothSetting(context: context);
        });

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }


  void showBleDisconnectedDialog({
    required BuildContext context, VoidCallback? onYesPressed}) {

    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.HOME_BLE_CONNECTION_ERROR_TITLE),
        content: LocaleUtil.getString(context, LocaleUtil.HOME_BLE_CONNECTION_ERROR_MESSAGE),
        yesString: LocaleUtil.getString(context, LocaleUtil.OK),
        yesOnPressed: onYesPressed);

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void showBleFailToConnectDialog({
    required BuildContext context}) {

    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.HOME_BLE_FAIL_TO_CONNECT_ERROR_TITLE),
        content: LocaleUtil.getString(context, LocaleUtil.HOME_BLE_FAIL_TO_CONNECT_ERROR_MESSAGE),
        yesOnPressed: (){},
        yesString: LocaleUtil.getString(context, LocaleUtil.OK));

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  bool isShownFailToStartPairingDialog = false;
  void showFailToStartPairingDialog({required BuildContext context}) {
    if (!isShownFailToStartPairingDialog) {
      isShownFailToStartPairingDialog = true;
      var baseDialog = CommonBaseAlertDialog(
          context: context,
          title: LocaleUtil.getString(context, LocaleUtil.GATEWAY_FAIL_TO_START_PAIRING_ERROR_TITLE),
          content: LocaleUtil.getString(context, LocaleUtil.GATEWAY_FAIL_TO_START_PAIRING_ERROR_MESSAGE),
          yesOnPressed: (){
            isShownFailToStartPairingDialog = false;
          },
          yesString: LocaleUtil.getString(context, LocaleUtil.OK));

      showDialog(
          context: context,
          builder: (BuildContext context) => baseDialog,
          barrierDismissible: false
      );
    }
  }

  bool isShownFailToStartPairingDialogWithRetry = false;
  void showFailToStartPairingDialogWithRetry({required BuildContext context, VoidCallback? onYesPressed,  VoidCallback? onNoPressed}) {
    if (!isShownFailToStartPairingDialogWithRetry) {
      isShownFailToStartPairingDialogWithRetry = true;
      var baseDialog = CommonBaseAlertDialog(
          context: context,
          title: LocaleUtil.getString(
              context, LocaleUtil.GATEWAY_FAIL_TO_START_PAIRING_ERROR_TITLE),
          content: LocaleUtil.getString(
              context, LocaleUtil.GATEWAY_FAIL_TO_START_PAIRING_ERROR_MESSAGE),
          yesOnPressed: () {
            isShownFailToStartPairingDialogWithRetry = false;
            if (onYesPressed != null) onYesPressed();
          },
          noOnPressed: () {
            isShownFailToStartPairingDialogWithRetry = false;
            if (onNoPressed != null) onNoPressed();
          },
          yesString: LocaleUtil.getString(context, LocaleUtil.YES),
          noString: LocaleUtil.getString(context, LocaleUtil.NO)
      );

      showDialog(
          context: context,
          builder: (BuildContext context) => baseDialog,
          barrierDismissible: false
      );
    }
  }

  void showWeakSecurityWarningDialog({
    required BuildContext context, VoidCallback? onYesPressed, VoidCallback? onNoPressed}) {

    var baseDialog = CommonBaseAlertDialog(
      context: context,
      title: LocaleUtil.getString(context, LocaleUtil.SECURITY_WARNING),
      content: LocaleUtil.getString(context, LocaleUtil.WPA_SECURITY_ERROR_MESSAGE),
      yesString: LocaleUtil.getString(context, LocaleUtil.OK),
      noString: LocaleUtil.getString(context, LocaleUtil.CANCEL),
      yesOnPressed: onYesPressed != null
          ? onYesPressed
          : () {},
      noOnPressed: onNoPressed != null
          ? onNoPressed
          : () {}
    );

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void showOpenSecurityWarningDialog({
    required BuildContext context, VoidCallback? onYesPressed}) {

    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.SECURITY_WARNING),
        content: LocaleUtil.getString(context, LocaleUtil.OPEN_NETWORK_ERROR_MESSAGE),
        yesString: LocaleUtil.getString(context, LocaleUtil.OK),
        noString: LocaleUtil.getString(context, LocaleUtil.CANCEL),
        yesOnPressed: onYesPressed != null
            ? onYesPressed
            : () {});

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void showUnknownSecurityWarningDialog({
    required BuildContext context, VoidCallback? onYesPressed}) {

    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.SECURITY_WARNING),
        content: LocaleUtil.getString(context, LocaleUtil.UNKNOWN_SECURITY_ERROR_MESSAGE),
        yesString: LocaleUtil.getString(context, LocaleUtil.OK),
        yesOnPressed: onYesPressed != null
            ? onYesPressed
            : () {});

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void showCouldNotFindHomeNetworkDialog({
    required BuildContext context, VoidCallback? onYesPressed}) {

    var baseDialog = CommonBaseAlertDialog(
      context: context,
      title: LocaleUtil.getString(context, LocaleUtil.HOME_NETWORK_FIND_ERROR_TITLE),
      content: LocaleUtil.getString(context, LocaleUtil.HOME_NETWORK_FIND_ERROR_MESSAGE),
      yesOnPressed: (){},
      yesString: LocaleUtil.getString(context, LocaleUtil.OK),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  var isCheckModuleStatusDialogShowing = false;
  void showCheckModuleStatusDialog({required BuildContext context, required VoidCallback? onNoPressed}) {

    if (!isCheckModuleStatusDialogShowing) {
      isCheckModuleStatusDialogShowing = true;

      var baseDialog = CommonBaseAlertDialog(
          context: context,
          title: LocaleUtil.getString(context, LocaleUtil.HOME_CHECK_MODULE_STATUS_TITLE),
          content: LocaleUtil.getString(context, LocaleUtil.HOME_CHECK_MODULE_STATUS_MESSAGE),
          yesOnPressed: (){ isCheckModuleStatusDialogShowing = false; },
          noOnPressed: (){ isCheckModuleStatusDialogShowing = false; onNoPressed!(); },
          yesString: LocaleUtil.getString(context, LocaleUtil.SOLID),
          noString: LocaleUtil.getString(context, LocaleUtil.FLASHING));

      showDialog(
          context: context,
          builder: (BuildContext context) => baseDialog,
          barrierDismissible: false
      );
    }
  }
  void showRemoveNetworkDialog({required BuildContext context, required VoidCallback? onOkPressed}) {
    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.NETWORK_REMOVED),
        content: LocaleUtil.getString(context, LocaleUtil.NETWORK_REMOVED_EXPLAIN),
        yesString: LocaleUtil.getString(context, LocaleUtil.OK),
        yesOnPressed: onOkPressed);

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void showNoBleNetworksDialog({required BuildContext context, required VoidCallback? onRetryPressed}) {
    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.OOPS),
        content: LocaleUtil.getString(context, LocaleUtil.NO_BLE_NETWORK),
        yesString: LocaleUtil.getString(context, LocaleUtil.RETRY),
        yesOnPressed: onRetryPressed);

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void showNetworkIsNotInRange(BuildContext context) {
    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.OOPS),
        content: "Selected Network is not around this device. Please select another one.", // the string is not confirmed, after get confirmed, move to the localization file.
        yesOnPressed: (){},
        yesString: LocaleUtil.getString(context, LocaleUtil.OK));

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void showRememberThisNetworkDialog(BuildContext context) {
    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.REMEMBER_THIS_NETWORK),
        content: LocaleUtil.getString(context, LocaleUtil.SAVE_YOUR_WIFI_INFORMATION),
        yesOnPressed: (){},
        yesString: LocaleUtil.getString(context, LocaleUtil.OK));

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void showPairingFailedDialog(BuildContext context, {String? content}) {
    var baseDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.HOME_BLE_FAIL_TO_CONNECT_ERROR_TITLE),
        content: content ?? LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_FAILED_DIALOG),
        yesOnPressed: (){},
        yesString: LocaleUtil.getString(context, LocaleUtil.OK));

    showDialog(
        context: context,
        builder: (BuildContext context) => baseDialog,
        barrierDismissible: false
    );
  }

  void close(BuildContext context, FlutterDialogType type) {
    switch (type) {
      case FlutterDialogType.checkModuleStatus:
        if (isCheckModuleStatusDialogShowing) {
          isCheckModuleStatusDialogShowing = false;
          Navigator.of(context, rootNavigator: true).pop();
        }
        break;
    }
  }
}