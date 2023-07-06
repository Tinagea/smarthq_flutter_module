// file: api_client.dart
// date: Feb/21/2022
// brief: A class to save RESTful API call information.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/appliance_list_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/model_number_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_network_request.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_network_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_network_update_request.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/wifi_networks_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/end_point_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/profile/rest_api_profile.dart' as restApiProfile;

import 'package:smarthq_flutter_module/models/control/stand_mixer_control_model.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(restApiProfile.CloudApiUri.wifiNetwork)
  Future<WifiNetworksResponse> getWifiNetworks();

  @POST(restApiProfile.CloudApiUri.wifiNetwork)
  Future<WifiNetworkResponse> postWifiNetwork(
      @Body() WifiNetworkRequest wifiNetworkRequest);

  @PUT(restApiProfile.CloudApiUri.wifiNetwork+'/{networkId}')
  Future<dynamic> putWifiNetwork(
      @Path("networkId") String networkId,
      @Body() WifiNetworkUpdateRequest wifiNetworkUpdateRequest);

  @DELETE(restApiProfile.CloudApiUri.wifiNetwork+'/{networkId}')
  Future<dynamic> deleteWifiNetwork(
      @Path("networkId") String networkId);

  @GET(restApiProfile.CloudApiUri.webSocketEndPoint)
  Future<EndPointResponse> getEndPoint({
    @Header("User-Agent") required String userAgent});

  @GET(restApiProfile.CloudApiUri.model+'/{modelNumber}')
  Future<ModelNumberResponse> getModelValidation(
      @Path("modelNumber") String modelNumber);

  @POST(restApiProfile.CloudApiUri.appliance+'/{applianceId}/control/mixer-oscillate')
  Future<dynamic> requestMixerOscillate(
      @Path("applianceId") String applianceId,
      @Body() StandMixerOscillateRequest standMixerOscillateRequest);

  @GET(restApiProfile.CloudApiUri.appliance)
  Future<ApplianceListResponse> getApplianceList();
}