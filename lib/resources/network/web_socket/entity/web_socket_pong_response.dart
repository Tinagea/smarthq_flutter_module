// file: web_socket_pong_response.dart
// date: Jun/20/2022
// brief: WebSocket pong response entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class WebSocketPongResponse {
  String? kind;
  String? id;

  WebSocketPongResponse({this.kind, this.id});

  WebSocketPongResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['id'] = this.id;
    return data;
  }
}