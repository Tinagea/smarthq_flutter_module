part of 'rest_api_profile.dart';

// file: cloud_api_uri.dart
// date: Jun/14/2021
// brief: A class for cloud api uri.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

abstract class CloudApiUri {

  // For apiHostUrl
  static const webSocketEndPoint = "/v1/websocket";
  static const appliance = "/v1/appliance";
  static const mDT = "/v1/mdt";
  static const pushToken = "/v1/mdt/push";
  static const publicKey = "/v1/publickey/{keyHash}";
  static const applianceInfo = "/v1/appliance/{applianceId}";
  static const userInfo = "/v1/user";
  static const userLanguage = "/v1/user/language";
  static const userLocation = "/v1/user/location";
  static const connectedTerms = "/v1/user/connectedterms";
  static const weather = "/v1/weather";
  static const model = "/v1/model/";

  // For accountHostUrl
  static const token = "/oauth2/token";
  static const geToken = "/oauth2/getoken";

  // For clientMySmartHQUrl
  static const deviceInfo = "/v2/device";
  
  // For Recipes
  static const recipe = applianceInfo + "/recipecapability";
  static const discoverRecipeSearch = "/v1/recipesearch";
  static const fetchRecipe = "/v1/recipe/{recipeId}";
  static const executionID = "/v1/appliance/{applianceId}/recipe/{recipeId}";
  static const executionControl = "/v1/recipe/execution/{executionId}";

  static const wifiNetwork = "/v1/wifi/network";
  static const command = "/v2/command";
  static const commands = "/v2/commands";

  // For apiMySmartHQUrl
  static const register = "/v2/push/register";
  static const associate = "/v2/push/associate";

}