import 'package:smarthq_flutter_module/resources/erd/erd.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9301.dart';

///### [requestedSettingMask]
/// - Name: **Mixer Control Requested Settings**
/// - Data Length: **12 bytes**
/// ----------------------
class ERD0x9302  {
  var padding;
  var direction;
  var speed;
  var timeSetValue;
  var relativeViscosity;
  var requestedSettingMask;

  String address = ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS;
  final String rawValue;

  ERD0x9302(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data recieved from 0x9302');
    }

    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    var bytes = getRawValue().toString();

    if (bytes.isEmpty) return;

    requestedSettingMask = int.parse(bytes.toString().substring(0, 1), radix: 16);
    direction = int.parse(bytes.substring(2, 3), radix: 16);
    speed = int.parse(bytes.substring(3, 4), radix: 16);
    timeSetValue = int.parse(bytes.substring(4, 6), radix: 16);
    relativeViscosity = int.parse(bytes.substring(6, 8), radix: 16);
  }

  @override
  String toString() {
    return "ERD0x9302{requestedSettingMask: $requestedSettingMask, direction: $direction, speed: $speed, timeSetValue: $timeSetValue, relativeViscosity: $relativeViscosity}";
  }

  getDirection() {
    switch (direction) {
      case 0x03:
        return Direction.TOGGLE;
      case 0x02:
        return Direction.REVERSE;
      case 0x01:
        return Direction.FORWARD;
      case 0x00:
        return Direction.NOT_APPLICABLE;
      default:
    }
  }
}
