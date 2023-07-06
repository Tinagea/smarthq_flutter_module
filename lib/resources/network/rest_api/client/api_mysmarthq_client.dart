// file: api_mysmarthq_client.dart
// date: Jul/19/2022
// brief: A class to save RESTful API(device information) call information.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_mysmarthq_entity/token_associate_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_mysmarthq_entity/token_register_response.dart';


import 'package:smarthq_flutter_module/resources/network/rest_api/profile/rest_api_profile.dart' as restApiProfile;

part 'api_mysmarthq_client.g.dart';

@RestApi(baseUrl: "")
abstract class ApiMySmartHQClient {
  factory ApiMySmartHQClient(Dio dio, {String baseUrl}) = _ApiMySmartHQClient;

  @POST(restApiProfile.CloudApiUri.register)
  Future<TokenRegisterResponse> registerToken(
      @Field("kind") String kind,
      @Field("mobileApp") String appId,
      @Field("token") String token,
      @Field("tokenReceipt") String? tokenReceipt);

  @POST(restApiProfile.CloudApiUri.associate)
  Future<TokenAssociateResponse> associateToken(
      @Field("kind") String kind,
      @Field("tokenReceipt") String? tokenReceipt);
}