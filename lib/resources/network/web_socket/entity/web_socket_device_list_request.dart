// file: web_socket_device_list_request.dart
// date: Jun/20/2022
// brief: WebSocket device list request entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class WebSocketDeviceListRequest {
  String? kind;
  String? action;
  String? host;
  String? method;
  String? path;
  String? id;

  WebSocketDeviceListRequest(
      {this.kind, this.action, this.host, this.method, this.path, this.id});

  WebSocketDeviceListRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    action = json['action'];
    host = json['host'];
    method = json['method'];
    path = json['path'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['action'] = this.action;
    data['host'] = this.host;
    data['method'] = this.method;
    data['path'] = this.path;
    data['id'] = this.id;
    return data;
  }
}