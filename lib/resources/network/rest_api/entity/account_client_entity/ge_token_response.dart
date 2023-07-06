// file: ge_token_response.dart
// date: Nov/25/2021
// brief: Ge token response entity
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class GeTokenResponse {
  String? accessToken;
  String? tokenType;
  String? idToken;

  GeTokenResponse({this.accessToken, this.tokenType, this.idToken});

  GeTokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    idToken = json['id_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['id_token'] = this.idToken;
    return data;
  }
}