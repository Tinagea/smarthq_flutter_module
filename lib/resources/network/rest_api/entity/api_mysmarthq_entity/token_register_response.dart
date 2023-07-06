// file: token_register_response.dart
// date: Jul/19/2022
// brief: Command Request Entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class TokenRegisterResponse {
  String? kind;
  String? tokenReceipt;

  TokenRegisterResponse({this.kind, this.tokenReceipt});

  TokenRegisterResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    tokenReceipt = json['tokenReceipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['tokenReceipt'] = this.tokenReceipt;
    return data;
  }
}