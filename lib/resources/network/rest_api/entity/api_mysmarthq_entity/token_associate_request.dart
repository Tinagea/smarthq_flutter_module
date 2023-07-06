// file: token_associate_request.dart
// date: Jul/19/2022
// brief: Command Request Entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

class TokenAssociateRequest {
  String? kind;
  String? tokenReceipt;

  TokenAssociateRequest({this.kind, this.tokenReceipt});

  TokenAssociateRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    tokenReceipt = json['tokenReceipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['tokenReceipt'] = this.tokenReceipt;
    return data;
  }
}