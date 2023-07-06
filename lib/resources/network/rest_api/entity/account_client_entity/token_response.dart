// file: token_response.dart
// date: Nov/25/2021
// brief: TokenResponse Entity
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class TokenResponse {
  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;

  TokenResponse(
      {this.tokenType,
        this.expiresIn,
        this.accessToken,
        this.refreshToken});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}