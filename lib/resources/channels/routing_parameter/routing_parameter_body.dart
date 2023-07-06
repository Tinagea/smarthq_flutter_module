import 'package:smarthq_flutter_module/models/dialog/push_notification/alert/details/push_notification_alert_details_model.dart';

abstract class RoutingParameterBody {
  const RoutingParameterBody();

  Map<String, dynamic> toJson();
}

class RoutingParameterBodyPushNotificationAlertDetails implements RoutingParameterBody {
  String? title;
  List<ContentItem>? contentItems;

  RoutingParameterBodyPushNotificationAlertDetails({this.title, this.contentItems});

  RoutingParameterBodyPushNotificationAlertDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];

    if (json['contentItems'] != null) {
      contentItems = <ContentItem>[];
      json['contentItems'].forEach((item) {
        final test = ContentItem.makeFromJson({...item});
        contentItems?.add(test);
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;

    if (this.contentItems != null) {
      data['contentItems'] = this.contentItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoutingParameterBodyNotificationHistory implements RoutingParameterBody {
  String? deviceId;

  RoutingParameterBodyNotificationHistory({this.deviceId});

  RoutingParameterBodyNotificationHistory.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['deviceId'] = this.deviceId;
    return data;
  }
}

class RoutingParameterBodyShortcut implements RoutingParameterBody {
  String? key;
  RoutingParameterBodyShortcut({this.key});

  RoutingParameterBodyShortcut.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }
}

//// Example
class RoutingParameterBodySample implements RoutingParameterBody {
  String? sample;

  RoutingParameterBodySample({this.sample});

  // HERE!!! Please implement the fromJson() function according to the field value.
  RoutingParameterBodySample.fromJson(Map<String, dynamic> json) {
    sample = json['sample'];
  }

  // HERE!!! Please implement the toJson() function according to the field value.
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sample'] = this.sample;
    return data;
  }
}