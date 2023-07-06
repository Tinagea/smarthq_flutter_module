// file: client_mysmarthq_client.dart
// date: Nov/14/2021
// brief: A class to save RESTful API(device information) call information.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/account_commands_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/command_request.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_information_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_setting_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_setting_rule_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/tag_name_response.dart';
import 'package:smarthq_flutter_module/resources/network/web_socket/entity/smart_hq_data_model/common/web_socket_pub_sub_services_response.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/profile/rest_api_profile.dart' as restApiProfile;

part 'client_mysmarthq_client.g.dart';

@RestApi(baseUrl: "")
abstract class ClientMySmartHQClient {
  factory ClientMySmartHQClient(Dio dio,
      {String baseUrl}) = _ClientMySmartHQClient;

  @GET(restApiProfile.CloudApiUri.deviceInfo)
  Future<DeviceListResponse> getDeviceList();

  @GET(restApiProfile.CloudApiUri.deviceInfo)
  Future<DeviceListResponse> findDeviceByDeviceType(
      @Query("deviceType") String deviceType);

  @GET(restApiProfile.CloudApiUri.deviceInfo)
  Future<DeviceListResponse> findDeviceByUpdId(
      @Query("updId") String updId);

  @GET(restApiProfile.CloudApiUri.deviceInfo+'/{deviceId}')
  Future<DeviceInformationResponse> getDeviceInformation(
      @Path("deviceId") String deviceId);

  @GET(restApiProfile.CloudApiUri.deviceInfo+'/{deviceId}/setting')
  Future<DeviceSettingResponse> getNotificationSettingInformation(
      @Path("deviceId") String deviceId);

  @GET(restApiProfile.CloudApiUri.commands)
  Future<AccountCommandsResponse> getNotificationHistoryInformation(
      @Query("rule.deviceId") String deviceId,
      @Query("serviceType") String serviceType,
      @Query("serviceDeviceType") String serviceDeviceType);

  @POST(restApiProfile.CloudApiUri.deviceInfo+'/{deviceId}/setting/{ruleId}')
  Future<DeviceSettingRuleResponse> postNotificationSettingRule(
      @Path("deviceId") String deviceId,
      @Path("ruleId") String ruleId,
      @Body() DeviceSettingRuleResponse deviceSettingRuleResponse);

  @POST(restApiProfile.CloudApiUri.command)
  Future<dynamic> postCommand(
      @Body() CommandRequest commandRequest);

  @POST(restApiProfile.CloudApiUri.deviceInfo+"/{deviceId}/tag/nickname")
  Future<TagNameResponse> postNickName(
      @Path("deviceId") String deviceId,
      @Field("kind") String kind,
      @Field("tagName") String tagName,
      @Field("tagValue") String tagValue);

  @GET(restApiProfile.CloudApiUri.deviceInfo+'/{deviceId}/service/{serviceId}')
  Future<Services> requestServiceInformation(
      @Path("deviceId") String deviceId,
      @Path("serviceId") String serviceId);
}