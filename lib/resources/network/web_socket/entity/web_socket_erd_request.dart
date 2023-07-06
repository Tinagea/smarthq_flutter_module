class WebSocketErdRequest {
  String? action;
  Body? body;
  String? host;
  String? id;
  String? kind;
  String? method;
  String? path;

  WebSocketErdRequest({this.action, this.body, this.host, this.id, this.kind, this.method, this.path});

  WebSocketErdRequest.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
    host = json['host'];
    id = json['id'];
    kind = json['kind'];
    method = json['method'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['action'] = this.action;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    data['host'] = this.host;
    data['id'] = this.id;
    data['kind'] = this.kind;
    data['method'] = this.method;
    data['path'] = this.path;
    return data;
  }
}

class Body {
  int? ackTimeout;
  String? applianceId;
  int? delay;
  String? erd;
  String? kind;
  String? userId;
  String? value;

  Body({this.ackTimeout, this.applianceId, this.delay, this.erd, this.kind, this.userId, this.value});

  Body.fromJson(Map<String, dynamic> json) {
    ackTimeout = json['ackTimeout'];
    applianceId = json['applianceId'];
    delay = json['delay'];
    erd = json['erd'];
    kind = json['kind'];
    userId = json['userId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ackTimeout'] = this.ackTimeout;
    data['applianceId'] = this.applianceId;
    data['delay'] = this.delay;
    data['erd'] = this.erd;
    data['kind'] = this.kind;
    data['userId'] = this.userId;
    data['value'] = this.value;
    return data;
  }
}