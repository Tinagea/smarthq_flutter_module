// file: commissioning_util.dart
// date: Dec/07/2021
// brief: A class to use for commissioning process
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:android_intent/flag.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';

enum APSecurityType {
  noneSecurity, // just used it to initialize.
  openSecurity,
  weakSecurity,
  safetySecurity,
  unknownSecurity,
}

class CommissioningUtil {
  static void openBluetoothSetting({required BuildContext context}) async {
    if (Platform.isIOS) {
      BlocProvider.of<BleCommissioningCubit>(context).actionBleGoToSetting();
    } else {
      AndroidIntent intent = AndroidIntent(
          action: 'android.settings.BLUETOOTH_SETTINGS',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK]);
      await intent.launch();
    }
  }


  static bool isNotSecurityType(String? securityType, bool isBleCommissioning) {
    bool isNotSecurityType = false;
    if (securityType != null) {
      APSecurityType eSecurityType = getAPSecurityType(securityType, isBleCommissioning);
      if (isBleCommissioning) {
        if (eSecurityType == APSecurityType.openSecurity
            || eSecurityType == APSecurityType.weakSecurity
            || eSecurityType == APSecurityType.unknownSecurity) {
          isNotSecurityType = true;
        }
      } else {
        if (eSecurityType == APSecurityType.openSecurity
            || eSecurityType == APSecurityType.weakSecurity) {
          isNotSecurityType = true;
        }
      }
    }
    return isNotSecurityType;
  }

  static APSecurityType getAPSecurityType(String securityType, bool isBleCommissioning) {

    APSecurityType eSecurityType = APSecurityType.noneSecurity;

    if (isBleCommissioning) {
      if (securityType.toUpperCase() == BleCommissioningSecurityType.WEP.toUpperCase() ||
          securityType.toUpperCase() == BleCommissioningSecurityType.WEP_SHARED.toUpperCase())
        eSecurityType = APSecurityType.weakSecurity;
      else if (securityType.toUpperCase() == BleCommissioningSecurityType.OPEN.toUpperCase() ||
          securityType.toUpperCase() == BleCommissioningSecurityType.DISABLE.toUpperCase())
        eSecurityType = APSecurityType.openSecurity;
      else if (securityType.toUpperCase() == BleCommissioningSecurityType.UNKNOWN.toUpperCase()) // unknown
        eSecurityType = APSecurityType.unknownSecurity;
      else if (securityType.toUpperCase() == BleCommissioningSecurityType.WPA.toUpperCase() ||
          securityType.toUpperCase() == BleCommissioningSecurityType.WPA2.toUpperCase() ||
          securityType.toUpperCase() == BleCommissioningSecurityType.WPA_WPA2_MIXED.toUpperCase() ||
          securityType.toUpperCase() == BleCommissioningSecurityType.WPA3.toUpperCase() ||
          securityType.toUpperCase() == BleCommissioningSecurityType.WPA2_WPA3_MIXED.toUpperCase()) eSecurityType = APSecurityType.safetySecurity;
    } else {
      if (securityType.toUpperCase() == CommissioningSecurityType.WEP.toUpperCase())
        eSecurityType = APSecurityType.weakSecurity;
      else if (securityType.toUpperCase() == CommissioningSecurityType.DISABLE.toUpperCase()
          || securityType.toUpperCase() == CommissioningSecurityType.NONE.toUpperCase())
        eSecurityType = APSecurityType.openSecurity;
      else if (securityType.toUpperCase() == CommissioningSecurityType.WPA_AES_PSK.toUpperCase()
          || securityType.toUpperCase() == CommissioningSecurityType.WPA_TKIP_PSK.toUpperCase()
          || securityType.toUpperCase() == CommissioningSecurityType.WPA2_AES_PSK.toUpperCase()
          || securityType.toUpperCase() == CommissioningSecurityType.WPA2_TKIP_PSK.toUpperCase()
          || securityType.toUpperCase() == CommissioningSecurityType.WPA2_MIXED_PSK.toUpperCase()
          || securityType.toUpperCase() == CommissioningSecurityType.WPA_WPA2_MIXED.toUpperCase())
        eSecurityType = APSecurityType.safetySecurity;
    }

    return eSecurityType;
  }

  static Future<bool> _isAutoJoinSupportedInAndroid() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final androidInfo = await deviceInfoPlugin.androidInfo;
      if (androidInfo.version.sdkInt <= 29) {
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  static Future<bool> isSupportAutoJoin() async {
    Future<bool> isSupportAutoJoin = Future.value(true);
    if (Platform.isIOS) {
      String osVersion = Platform.operatingSystemVersion;
      osVersion = osVersion.substring(0, osVersion.indexOf('('));
      osVersion = osVersion.replaceAll("Version ", "");
      osVersion = osVersion.substring(0, osVersion.length - 1);
      osVersion = osVersion.substring(0, 4);
      if (double.parse(osVersion) >= 13.0 && double.parse(osVersion) <= 13.4) {
        isSupportAutoJoin = Future.value(false);
      } else {
        isSupportAutoJoin = Future.value(true);
      }
    } else if (Platform.isAndroid) {
      isSupportAutoJoin = _isAutoJoinSupportedInAndroid();
    }
    return isSupportAutoJoin;
  }

  static void navigateBackAndStopBlescan({required BuildContext context}) {
    BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
    if (Navigator.canPop(context))
      Navigator.pop(context);
    else
      Navigator.of(context, rootNavigator: true).pop();
  }
}