// file: token_associate_response.dart
// date: Jul/19/2022
// brief: Command Request Entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

class TokenAssociateResponse {
  String? kind;
  String? status;

  TokenAssociateResponse({this.kind, this.status});

  TokenAssociateResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['status'] = this.status;
    return data;
  }
}