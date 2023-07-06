
class APIServiceResultNotificationVersionItem {
  String? applianceTypeDec;
  String? apiVersion;

  APIServiceResultNotificationVersionItem({this.applianceTypeDec, this.apiVersion});

  APIServiceResultNotificationVersionItem.fromJson(Map<String, dynamic> json) {
    applianceTypeDec = json['applianceTypeDec'];
    apiVersion = json['apiVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applianceTypeDec'] = this.applianceTypeDec;
    data['apiVersion'] = this.apiVersion;
    return data;
  }
}