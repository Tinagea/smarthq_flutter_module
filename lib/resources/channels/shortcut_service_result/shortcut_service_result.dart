import 'package:smarthq_flutter_module/resources/channels/shortcut_service_result/shortcut_service_result_body.dart';

enum ShortcutServiceKind {
  none('none'),
  ovenType('ovenType'),
  ovenModes('ovenModes'),
  ovenTemps('ovenTemps'),
  acModes('acModes'),
  acTemps('acTemps'),
  acFans('acFans');

  const ShortcutServiceKind(this.name);
  final String name;

  factory ShortcutServiceKind.getKindFrom({required String name}) {
    return ShortcutServiceKind.values.firstWhere((value) => value.name == name,
        orElse: () => ShortcutServiceKind.none);
  }
}

class ShortcutServiceDataResult {
  ShortcutServiceKind? kind;
  ShortcutServiceBody? body;

  ShortcutServiceDataResult({this.kind, this.body});

  ShortcutServiceDataResult.fromJson(Map<String, dynamic> json) {
    final kindName = json['kind'];
    if (kindName != null) {
      kind = ShortcutServiceKind.getKindFrom(name: kindName);
    } else {
      kind = ShortcutServiceKind.none;
    }

    switch (kind!) {
      case ShortcutServiceKind.none:
        body = null;
        break;
      case ShortcutServiceKind.ovenType:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = ShortcutServiceBodyOvenType.fromJson(_body);
        }
        break;
      case ShortcutServiceKind.ovenModes:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = ShortcutServiceBodyOvenModes.fromJson(_body);
        }
        break;
      case ShortcutServiceKind.ovenTemps:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = ShortcutServiceBodyOvenTemps.fromJson(_body);
        }
        break;
      case ShortcutServiceKind.acModes:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = ShortcutServiceBodyAcModes.fromJson(_body);
        }
        break;
      case ShortcutServiceKind.acTemps:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = ShortcutServiceBodyAcTemps.fromJson(_body);
        }
        break;
      case ShortcutServiceKind.acFans:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = ShortcutServiceBodyAcModes.fromJson(_body);
        }
        break;
    }
  }
}

class ShortcutServiceResult {
  String? kind;
  bool? success;
  String? reason;
  String? body;

  ShortcutServiceResult({
    this.kind,
    this.success,
    this.reason,
    this.body,
  });

  ShortcutServiceResult.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    success = json['success'];
    reason = json['reason'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['success'] = this.success;
    data['reason'] = this.reason;
    data['body'] = this.body;
    return data;
  }
}