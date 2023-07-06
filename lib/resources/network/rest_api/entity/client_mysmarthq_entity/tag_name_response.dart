// file: tag_name_response.dart
// date: Jan/13/2022
// brief: tag name response entity
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class TagNameResponse {
  String? kind;
  String? tagValue;
  bool? success;
  String? tagName;

  TagNameResponse({this.kind, this.tagValue, this.success, this.tagName});

  TagNameResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    tagValue = json['tagValue'];
    success = json['success'];
    tagName = json['tagName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['tagValue'] = this.tagValue;
    data['success'] = this.success;
    data['tagName'] = this.tagName;
    return data;
  }
}