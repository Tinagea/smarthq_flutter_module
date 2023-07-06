// file: web_socket_pub_sub_subscribe_request.dart
// date: Jun/20/2022
// brief: WebSocket pub sub subscribe request entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class WebSocketSubscribeRequest {
  String? kind;
  String? action;
  List<String>? resources;

  WebSocketSubscribeRequest({this.kind, this.action, this.resources});

  WebSocketSubscribeRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    action = json['action'];
    resources = json['resources'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['action'] = this.action;
    data['resources'] = this.resources;
    return data;
  }
}