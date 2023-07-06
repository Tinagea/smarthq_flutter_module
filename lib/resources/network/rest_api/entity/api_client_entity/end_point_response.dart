
class EndPointResponse {
  String? endpoint;
  String? kind;
  String? userId;

  EndPointResponse({this.endpoint, this.kind, this.userId});

  EndPointResponse.fromJson(Map<String, dynamic> json) {
    endpoint = json['endpoint'];
    kind = json['kind'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['endpoint'] = this.endpoint;
    data['kind'] = this.kind;
    data['userId'] = this.userId;
    return data;
  }
}