// file: web_socket_pub_sub_account_request.dart
// date: Jun/20/2022
// brief: WebSocket pub sub account request entity.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.


class WebSocketPubSubAccountRequest {
  String? kind;
  String? action;
  bool? pubsub;
  bool? services;
  bool? presence;
  bool? alerts;

  WebSocketPubSubAccountRequest(
      {this.kind,
        this.action,
        this.pubsub,
        this.services,
        this.presence,
        this.alerts});

  WebSocketPubSubAccountRequest.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    action = json['action'];
    pubsub = json['pubsub'];
    services = json['services'];
    presence = json['presence'];
    alerts = json['alerts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['action'] = this.action;
    data['pubsub'] = this.pubsub;
    data['services'] = this.services;
    data['presence'] = this.presence;
    data['alerts'] = this.alerts;
    return data;
  }
}