
import 'dialog_parameter_body.dart';

enum DialogParameterKind {
  none('none'),
  pushNotification('pushNotification');
  // HERE!!!  Please add new kind as needed.

  const DialogParameterKind(this.name);
  final String name;

  factory DialogParameterKind.getKindFrom({required String name}) {
    return DialogParameterKind.values.firstWhere((value) => value.name == name,
        orElse: () => DialogParameterKind.none);
  }
}

class DialogParameter {
  DialogParameterKind? kind;
  DialogParameterBody? body;
  DialogParameter({this.kind, this.body});

  DialogParameter.fromJson(Map<String, dynamic> json) {
    final kindName = json['kind'];
    if (kindName != null) {
      kind = DialogParameterKind.getKindFrom(name: kindName);
    } else {
      kind = DialogParameterKind.none;
    }

    switch (kind!) {
      case DialogParameterKind.none:
        body = null;
        break;
      case DialogParameterKind.pushNotification:
        if (json['body'] != null) {
          Map<String, dynamic> _body = {...json['body']};
          body = DialogParameterBodyPushNotification.fromJson(_body);
        }
        break;
        // HERE!!! Must add the code that calls DialogParameterBodyXXXX.fromJson(_body)
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
