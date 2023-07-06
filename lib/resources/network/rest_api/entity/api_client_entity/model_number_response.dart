// file: model_number_response.dart
// date: Aug/31/2022
// brief: model number response entity
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class ModelNumberResponse {
  String? kind;
  String? model;
  bool? valid;
  bool? banned;
  String? commissionMethod;
  List<String?>? capabilities;

  ModelNumberResponse({this.kind, this.model, this.valid, this.banned, this.commissionMethod, this.capabilities});

  ModelNumberResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    model = json['model'];
    valid = json['valid'];
    banned = json['banned'];
    commissionMethod = json['commissionMethod'];
    capabilities = (json['capabilities'] as List<dynamic>).cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['model'] = this.model;
    data['valid'] = this.valid;
    data['banned'] = this.banned;
    data['commissionMethod'] = this.commissionMethod;
    data['capabilities'] = this.capabilities;
    return data;
  }
}