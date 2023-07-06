import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/resources/channels/api_service_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/api_service_result/api_service_result.dart';
import 'package:smarthq_flutter_module/resources/channels/api_service_result/api_service_result_notification_version_item.dart';
import 'package:smarthq_flutter_module/resources/channels/channel_manager/channel_manager.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class APIServiceChannelHandler extends ChannelHandler {
  APIServiceChannelHandler(StreamController streamController): super(streamController);

  @override
  Future<dynamic> handleMethod(MethodCall call) async {
    geaLog.debug('APIService Listener Method call [${call.method}](${call.arguments})');

    final apiServiceRepository = GetIt.I.get<ApiServiceRepository>();

    switch (call.method) {
      case APIServiceChannelProfile.N2F_DIRECT_GET_DEVICE_OTA_STATUS:
        final deviceId = call.arguments['deviceId'];
        if (deviceId != null && deviceId is String) {
          final status = await apiServiceRepository.fetchOTAStatus(deviceId);
          if (status != null) {
            return APIServiceResult(
                kind: "",
                success: true,
                body: APIServiceResultBody(
                    status: status
                )).toJson();
          }
        }
        return APIServiceResult(
          kind: "",
          success: false,
          reason: 'deviceId is null or deviceId is not String'
        ).toJson();

      case APIServiceChannelProfile.N2F_DIRECT_START_DEVICE_OTA:
        final deviceId = call.arguments['deviceId'];
        if (deviceId != null && deviceId is String) {
          final success = await apiServiceRepository.postStartOTA(deviceId);
          return APIServiceResult(
              kind: "",
              success: success
          ).toJson();
        }
        return APIServiceResult(
            kind: "",
            success: false,
            reason: 'deviceId is null or deviceId is not String'
        ).toJson();

      case APIServiceChannelProfile.N2F_DIRECT_GET_NOTIFICATION_SETTING_API_VERSION:
        final applianceTypeDec = call.arguments['applianceTypeDec'];
        if (applianceTypeDec != null && applianceTypeDec is String) {
          final apiVersion = await apiServiceRepository
              .getNotificationSettingAPIVersion(applianceTypeDec);
          return APIServiceResult(
              kind: "",
              success: true,
              body: APIServiceResultBody(
                  apiVersion: apiVersion
              )).toJson();
        }
        return APIServiceResult(
            kind: "",
            success: false,
            reason: 'applianceTypeDec is null or applianceTypeDec is not String'
        ).toJson();

      case APIServiceChannelProfile.N2F_DIRECT_GET_NOTIFICATION_API_VERSION_LIST:
        final result = await apiServiceRepository.getNotificationAPIVersionList();
        List<APIServiceResultNotificationVersionItem>? versionList;
        if (result != null) {
          versionList = result.map((item) => APIServiceResultNotificationVersionItem(
            apiVersion: 'v${item.apiVersion.toString()}',
            applianceTypeDec: item.applianceTypeDec.toString()
          )).toList();
        }
        return APIServiceResult(
            kind: "",
            success: true,
            body: APIServiceResultBody(
              notificationVersionList: versionList
            )).toJson();

      default:
        throw MissingPluginException();
    }
  }

}