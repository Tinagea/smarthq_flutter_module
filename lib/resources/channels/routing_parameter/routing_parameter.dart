import 'routing_parameter_body.dart';

enum RoutingParameterKind {
  none('none'),
  notificationHistory('notificationHistory'),
  pushNotificationAlertDetails('pushNotificationAlertDetails'),
  shortcut('shortcut'),
  sample('sample');
  // HERE!!!  Please add new kind as needed.

  const RoutingParameterKind(this.name);
  final String name;

  factory RoutingParameterKind.getKindFrom({required String name}) {
    return RoutingParameterKind.values.firstWhere((value) => value.name == name,
        orElse: () => RoutingParameterKind.none);
  }
}

class RoutingParameter {
  RoutingParameterKind? kind;
  RoutingParameterBody? body;
  RoutingParameter({this.kind, this.body});

  RoutingParameter.fromJson(Map<String, dynamic> json) {
    final kindName = json['kind'];
    if (kindName != null) {
      kind = RoutingParameterKind.getKindFrom(name: kindName);
    } else {
      kind = RoutingParameterKind.none;
    }

    switch (kind!) {
      case RoutingParameterKind.none:
        body = null;
        break;
      case RoutingParameterKind.notificationHistory:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = RoutingParameterBodyNotificationHistory.fromJson(_body);
        }
        break;
      case RoutingParameterKind.pushNotificationAlertDetails:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = RoutingParameterBodyPushNotificationAlertDetails.fromJson(_body);
        }
        break;
      case RoutingParameterKind.shortcut:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = RoutingParameterBodyShortcut.fromJson(_body);
        }
        break;

      case RoutingParameterKind.sample:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = RoutingParameterBodySample.fromJson(_body);
        }
        break;        
      // HERE!!! Must add the code that calls RoutingParameterBodyXXXX.fromJson(_body)

      case RoutingParameterKind.none:
      default:
        body = null;
        break;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind!.name;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}
