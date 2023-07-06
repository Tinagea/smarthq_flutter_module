abstract class DialogParameterBody {
  const DialogParameterBody();

  Map<String, dynamic> toJson();
}

class DialogParameterBodyPushNotification
    implements DialogParameterBody {
  String? rawPayload;
  // v1
  String? msg;
  String? url;
  // v2
  String? title;
  String? ruleId;
  String? deviceId;
  String? alertType;
  String? deviceType;

  DialogParameterBodyPushNotification({
    this.rawPayload,
    this.msg,
    this.url,
    this.title,
    this.ruleId,
    this.deviceId,
    this.alertType,
    this.deviceType,
  });

  DialogParameterBodyPushNotification.fromJson(
      Map<String, dynamic> json) {
    rawPayload = json['rawPayload'];
    msg = json['msg'];
    url = json['url'];
    title = json['title'];
    ruleId = json['ruleId'];
    deviceId = json['deviceId'];
    alertType = json['alertType'];
    deviceType = json['deviceType'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rawPayload'] = this.rawPayload;
    data['msg'] = this.msg;
    data['url'] = this.url;
    data['title'] = this.title;
    data['ruleId'] = this.ruleId;
    data['deviceId'] = this.deviceId;
    data['alertType'] = this.alertType;
    data['deviceType'] = this.deviceType;
    return data;
  }
}