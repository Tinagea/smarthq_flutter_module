import 'package:smarthq_flutter_module/resources/erd/erd.dart';

///### [MIXER_CONTROL_CURRENT]
///-  [Name] Mixer Control Current Settings
///-  [Data Length] 10 bytes
///- Current mixer control settings include: the mixer direction, speed, mixing cycle timer set value, and relative viscosity.
///-  ----------------------
class ERD0x9301{
  var direction;
  var speed;
  var timerSetValue;
  var relativeViscosity;
  
  String address = ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS;
  final String rawValue;

  ERD0x9301(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data recieved from 0x9301');
    }

    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    var bytes = rawValue;
    
    if (bytes.isEmpty) return;

    direction = int.parse(bytes.substring(0, 2), radix: 16);
    speed = int.parse(bytes.substring(2, 4), radix: 16);
    timerSetValue = int.parse(bytes.substring(4, 8), radix: 16);
    relativeViscosity = int.parse(bytes.substring(8, 12), radix: 16);

    getDirection();
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

enum Direction {
  TOGGLE, //0x03
  REVERSE, //0x02
  FORWARD, //0x01
  NOT_APPLICABLE //N/A
}

extension ParseToString on Direction {
  String toValueString() {
    switch (this) {
      case Direction.TOGGLE:
        return "3";
      case Direction.REVERSE:
        return "2";
      case Direction.FORWARD:
        return "1";
      case Direction.NOT_APPLICABLE:
        return "N/A";
      default:
        return "0";
    }
  }
}
