// file: brand_contents_client.dart
// date: Sep/03/2022
// brief: A class to use to get the brand contents
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'brand_contents_client.g.dart';

@RestApi(baseUrl: "")
abstract class BrandContentsClient {
  factory BrandContentsClient(Dio dio, {String baseUrl}) = _BrandContentsClient;

  @GET('/{jsonPath}'+'/{jsonName}')
  Future<dynamic> getBrandContentsJson(
      @Path("jsonPath") String jsonPath,
      @Path("jsonName") String jsonName);

  @GET('/apps/smarthq'+'/{countryCode}'+'/{languageCode}'+'/{deviceType}'+'/{alertType}')
  Future<dynamic> getAlertContentsJson(
      @Path("countryCode") String countryCode,
      @Path("languageCode") String languageCode,
      @Path("deviceType") String deviceType,
      @Path("alertType") String alertType);

}