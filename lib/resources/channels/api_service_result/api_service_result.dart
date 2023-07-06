
import 'package:smarthq_flutter_module/resources/channels/api_service_result/api_service_result_notification_version_item.dart';

class APIServiceResult {
  String? kind;
  bool? success;
  String? reason;
  APIServiceResultBody? body;

  APIServiceResult({this.kind, this.success, this.reason, this.body});

  APIServiceResult.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    success = json['success'];
    reason = json['reason'];
    body = json['body'] != null ? APIServiceResultBody.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['success'] = this.success;
    data['reason'] = this.reason;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class APIServiceResultBody {
  String? status;
  String? apiVersion;
  List<APIServiceResultNotificationVersionItem>? notificationVersionList;

  APIServiceResultBody({this.status, this.apiVersion, this.notificationVersionList});

  APIServiceResultBody.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = json['status'];
    }
    if (json['apiVersion'] != null) {
      apiVersion = json['apiVersion'];
    }
    if (json['notificationVersionList'] != null) {
      notificationVersionList = [];
      json['notificationVersionList'].forEach((v) {
        notificationVersionList?.add(new APIServiceResultNotificationVersionItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.apiVersion != null) {
      data['apiVersion'] = this.apiVersion;
    }
    if (this.notificationVersionList != null) {
      data['notificationVersionList'] = this.notificationVersionList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}