
import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/shortcut_service_channel_profile.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';

class ChannelMethodMockUp {
  static final ChannelMethodMockUp _instance = ChannelMethodMockUp._internal();
  factory ChannelMethodMockUp() => _instance;
  ChannelMethodMockUp._internal();

  Future<dynamic> getMockUp(ChannelType channelType, String methodName, dynamic parameter) {
    geaLog.debug("Finding... the method in ChannelMethodMockUp");
    Future<dynamic>? mockUp;

    switch (channelType) {
      case ChannelType.native:
        if (methodName == NativeChannelProfile.F2N_DIRECT_IS_RUNNING_ON_NATIVE) {
          mockUp = Future.value(false);
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_LANGUAGE_PREFERENCE) {
          mockUp = Future.value({'languagePreference':'en-US'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_MDT) {
          mockUp = Future.value({'mdt':'ue1d6oZkgZPvBZ3EZUBsUP64Z7WJxbCVWUKk'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_GE_TOKEN) {
          mockUp = Future.value({'geToken':'ue1cf470cg1b0yufw04wus1946q6tqoq'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_SELECTED_APPLIANCE_ID) {
          mockUp = Future.value({'selectedApplianceId':'D828C915A163'});
        }
        // else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_FEATURE_LIST) {
        //   mockUp = Future.value({'features':['websocket', 'restApi']});
        // }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_REQUEST_SELECTED_BRAND_TYPE) {
          mockUp = Future.value({'brandType':'cafe'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_REQUEST_USER_COUNTRY_CODE) {
          mockUp = Future.value({'countryCode':'US'});
        }
        break;

      case ChannelType.bleCommissioning:
        if (methodName == BleCommissioningChannelProfile.ACTION_DIRECT_BLE_GET_INFO_TO_PAIR_SENSOR) {
          mockUp = Future.value({'deviceId':'27f766b1b1f228be0ccb0cd9fc264494f88ae6bc7b8506d9d0005b9f0a4d9f5b',
                                'gatewayId':'280f51f3280be26f297af81465e135fa2702e54da5192a7398e0d336a3891aab'});
        }
        else if (methodName == BleCommissioningChannelProfile.ACTION_DIRECT_BLE_DEVICE_STATE) {
          mockUp = Future.value({'state':'on'});
        }
        break;

      case ChannelType.commissioning:
        break;

      case ChannelType.dialog:
        if (methodName == NativeChannelProfile.F2N_DIRECT_IS_RUNNING_ON_NATIVE) {
          mockUp = Future.value(false);
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_MDT) {
          mockUp = Future.value({'mdt':'ue1ddXKdSxkb1vII9zazmwEua7RXP55OHErQ'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_GE_TOKEN) {
          mockUp = Future.value({'geToken':'ue1cf7k2744tuwy0tvp3gkovgygcwqd0'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_GET_LANGUAGE_PREFERENCE) {
          mockUp = Future.value({'languagePreference':'en-US'});
        }
        else if (methodName == NativeChannelProfile.F2N_DIRECT_REQUEST_USER_COUNTRY_CODE) {
          mockUp = Future.value({'countryCode':'US'});
        }

        break;

      case ChannelType.applianceService:
        break;

      case ChannelType.shortcutService:
        if (methodName == ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_OVEN_TYPE) {
          mockUp = Future.value(
              {'ovenType': {'body': {'ovenType': 'singleOven'}, 'kind': 'ovenType'}});
        }
        else if (methodName == ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_OVEN_MODES) {
          mockUp = Future.value(
              {'ovenModes': {'body': {'ovenModes': ['Bake', 'Conv. Bake Multi.', 'Conv. Roast', 'Frozen Snacks', 'Frozen Snacks Multi', 'Frozen Pizza', 'Frozen Pizza Multi', 'Baked Goods']}, 'kind': 'ovenModes'}});
        }
        else if (methodName == ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_OVEN_TEMPS) {
          mockUp = Future.value(
              {'ovenTemps': {'body': {'tempUnit': 'fahrenheit', 'ovenTemps': ['170', '175', '180', '185', '190', '195', '200', '205', '210', '215', '220', '225', '230', '235', '240', '245', '250', '255', '260', '265', '270', '275', '280', '285', '290', '295', '300', '305', '310', '315', '320', '325', '330', '335', '340', '345', '350', '355', '360', '365', '370', '375', '380', '385', '390', '395', '400', '405', '410', '415', '420', '425', '430', '435', '440', '445', '450', '455', '460', '465', '470', '475', '480', '485', '490', '495', '500', '505', '510', '515', '520', '525', '530', '535', '540', '545', '550']}, 'kind': 'ovenTemps'}});
        }
        else if (methodName == ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_AC_MODES) {
          mockUp = Future.value(
              {'acModes': {'body': {'acModes': ['Dry', 'Energy Saver', 'Turbo Cool']}, 'kind': 'acModes'}});
        }
        else if (methodName == ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_AC_TEMPS) {
          mockUp = Future.value(
              {'acTemps': {'body': {'acTemps': ['17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30'], 'tempUnit': 'fahrenheit'}, 'kind': 'acTemps'}});
        }
        else if (methodName == ShortcutServiceChannelProfile.F2N_DIRECT_REQUEST_AVAILABLE_AC_FANS) {
          mockUp = Future.value(
              {'acFans': {'body': {'acFans': ['Auto', 'High', 'Medium', 'Low']}, 'kind': 'acFans'}});
        }
        break;

      default:
        break;
    }

    if (mockUp == null) {
      mockUp = Future.value(null);
    }

    return mockUp;
  }
}