// file: web_socket_ping_request.dart
// date: Jun/20/2022
// brief: WebSocket device list response entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class WebSocketPingRequest {
  String? kind;
  String? action;
  String? id;

  WebSocketPingRequest({this.kind, this.action, this.id});

  WebSocketPingRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    action = json['action'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['action'] = this.action;
    data['id'] = this.id;
    return data;
  }
}