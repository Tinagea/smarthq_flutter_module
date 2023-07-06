// file: web_socket_publish_erd_response.dart
// date: Jan/05/2023
// brief: WebSocket publish erd response entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

class WebSocketPublishErdResponse {
  Item? item;
  String? resource;
  String? kind;
  String? userId;

  WebSocketPublishErdResponse(
      {this.item, this.resource, this.kind, this.userId});

  WebSocketPublishErdResponse.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    resource = json['resource'];
    kind = json['kind'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['resource'] = this.resource;
    data['kind'] = this.kind;
    data['userId'] = this.userId;
    return data;
  }
}

class Item {
  String? applianceId;
  String? erd;
  String? time;
  String? value;

  Item({this.applianceId, this.erd, this.time, this.value});

  Item.fromJson(Map<String, dynamic> json) {
    applianceId = json['applianceId'];
    erd = json['erd'];
    time = json['time'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applianceId'] = this.applianceId;
    data['erd'] = this.erd;
    data['time'] = this.time;
    data['value'] = this.value;
    return data;
  }
}