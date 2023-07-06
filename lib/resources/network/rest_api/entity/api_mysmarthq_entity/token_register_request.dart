// file: token_register_request.dart
// date: Jul/19/2022
// brief: Command Request Entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

class TokenRegisterRequest {
  String? kind;
  String? mobileApp;
  String? token;
  String? tokenReceipt;

  TokenRegisterRequest(
      {this.kind, this.mobileApp, this.token, this.tokenReceipt});

  TokenRegisterRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    mobileApp = json['mobileApp'];
    token = json['token'];
    tokenReceipt = json['tokenReceipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['mobileApp'] = this.mobileApp;
    data['token'] = this.token;
    data['tokenReceipt'] = this.tokenReceipt;
    return data;
  }
}