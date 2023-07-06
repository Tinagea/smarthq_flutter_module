// file: account_client.dart
// date: Feb/21/2022
// brief: A class to save RESTful API call information.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:smarthq_flutter_module/resources/network/rest_api/entity/account_client_entity/ge_token_response.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/profile/rest_api_profile.dart' as restApiProfile;

part 'account_client.g.dart';

@RestApi(baseUrl: "")
abstract class AccountClient {
  factory AccountClient(Dio dio, {String baseUrl}) = _AccountClient;

  @POST(restApiProfile.CloudApiUri.geToken)
  @FormUrlEncoded()
  Future<GeTokenResponse> requestGeToken({
    @Field("integration") required String integration,
    @Field("client_id") required String clientId,
    @Field("client_secret") required String clientSecret,
    @Field("mdt") required String mdt,
    @Header("User-Agent") required String userAgent});
}