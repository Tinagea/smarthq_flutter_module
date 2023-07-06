import 'package:smarthq_flutter_module/utils/log_util.dart';
///## ERD PARSE BEFORE SEND
///  Name: **ERD STAND MIXER CONVERTER**

enum StandMixerAction {
  setIsMixerPaused,
  setDirection,
  setSpeed,
  setTimerSetValue,
  setRelativeViscosity,
  cancelMixing,
  disableScale,
  enableScale,
}

class MixerDirection {
  static const toggle = "TOGGLE";
  static const reverse = "REVERSE";
  static const forward = "FORWARD";
  static const notApplicable = "NOT_APPLICABLE";
}

class CycleState {
  static const idle = "MIXER_IDLE";
  static const mixing = "MIXER_MIXING";
  static const paused = "MIXER_PAUSED";
}

class StandMixerErdParser {
  static const String tag = "StandMixerErdParser:";
  String? erdStrip;

  StandMixerErdParser({
    this.erdStrip,
  });

  List<bool> requestedMaskValue = [false, false, false, false];

  String doAction(StandMixerAction action, String value) {
    switch (action) {
      case StandMixerAction.setDirection:
        return _changeDirection(value);
      case StandMixerAction.setSpeed:
        return _changeSpeed(value);
      case StandMixerAction.setTimerSetValue:
        return _changeTimerSetValue(value);
      case StandMixerAction.setRelativeViscosity:
        return _changeRelativeViscosity(value);
      case StandMixerAction.setIsMixerPaused:
        return _changePauseState(value);
      case StandMixerAction.cancelMixing:
        return _cancelMixing(value);
      case StandMixerAction.disableScale:
        return _enableScaleMode(false);
      case StandMixerAction.enableScale:
        return _enableScaleMode(true);
      default:
        return "0";
    }
  }

  // 0x9300
  // 1 byte total
  // 0
  // byte 0 = Mixer Mode State [Enum] bit=0, bit=1, bit=2 || READ ONLY

  // 0x9301
  // 10 bytes total
  // 0000000000
  // byte 0 = Direction || READ ONLY
  // byte 2 = Speed || READ ONLY
  // byte 2-3 = Timer Set Value || READ ONLY
  // byte 4-5 = Relative Viscosity || READ ONLY
  // byte 6-9 = Reserved

  // 0x9302
  // 12 bytes total
  // 000000000000
  // byte 0 = Requested Settings Mask [Enum] bit=0, bit=1, bit=2, bit=3, bit=4-7 | Booleans
  // byte 1 = Padding | N/A
  // byte 2 = Direction | Enum
  // byte 3 = Speed | Tnt8
  // byte 4-5 = Timer Set Value | Tnt16
  // byte 6-7 = Relative Viscosity | Tnt16
  // byte 8-11 = Reserved
  // String _9302Strip = "000000000000000000000000";

  String? _getBytes() {
    return erdStrip;
  }

  void clear() {
    erdStrip = null;
    requestedMaskValue = [false,false,false,false];
  }

  String requestedMaskValuedToHex(){
    geaLog.debug("$tag requestedMaskValue: $requestedMaskValue");
    String binary = "";
    for (var i = 0; i < requestedMaskValue.length; i++) {
      if (requestedMaskValue[i]) {
        binary += "1";
      } else {
        binary += "0";
      }
    }
    var hex = int.parse(binary.split('').reversed.join(), radix: 2).toRadixString(16);
    if(hex.length == 1){
      hex = "0" + hex;
    }
    geaLog.debug("$tag hex: $hex");
    return hex;
  }

  String controlSettings(String? currentValue,
      String? speed, String? time, String? direction) {
    String? cached = currentValue ?? "000000000000000000000000";
    geaLog.debug("$tag controlSettings: $currentValue $direction, $speed, $time");
    String requestedBinary = "0000";
    geaLog.debug("$tag controlSettings: cached 1 $cached");
    if (speed != null) {
      final hexSpeed = _getSpeed(speed);
      geaLog.debug("$tag controlSettings: hexTimer $hexSpeed");
      cached = cached.replaceRange(6, (6 + hexSpeed.length), hexSpeed);
      geaLog.debug("$tag controlSettings: cached 2 $cached");
      //place a one in the speed bit (third)
      requestedBinary = requestedBinary.replaceRange(2, 3, "1");
    }

    if (time != null) {
      final hexTimer = _getTimer(time);
      geaLog.debug("$tag controlSettings: hexTimer $hexTimer");
      cached = cached.replaceRange(8, (8 + hexTimer.length), hexTimer);
      geaLog.debug("$tag controlSettings: cached 3 $cached");
      //place a one in the timer bit (second)
      requestedBinary = requestedBinary.replaceRange(1, 2, "1");
    }

    if (direction != null) {
      final hexDirection = _getDirection(direction);
      cached = cached.replaceRange(4, (4 + hexDirection.length), hexDirection);
      geaLog.debug("$tag controlSettings: cached 4 $cached");
      //place a one in the direction bit (fourth)
      requestedBinary = requestedBinary.replaceRange(3, 4, "1");
    }

    geaLog.debug("$tag controlSettings: end - $cached");

    String requestedHex = int.parse(requestedBinary, radix: 2).toRadixString(16);
    requestedHex = requestedHex.padLeft(2, '0');
    geaLog.debug("$tag sendStartMixData requestedHex - $requestedHex");

    cached = cached.replaceRange(0, 2, requestedHex);

    return cached;
  }

  //00 00 02 05 00 0e 00 00 00 00 00 00 0
  // byte 2 = Direction | Enum
  String _getDirection(String direction) {
    geaLog.debug("$tag _getDirection: ${int.parse(direction).toRadixString(16)}");
    return int.parse(direction).toRadixString(16).padLeft(2, '0');
  }

  String _changeDirection(String direction) {
    //insert new direction into byte 2
    String bytes = _getBytes() ?? "000000000000000000000000";
    //replace byte 2 with new direction
    geaLog.debug("$tag Direction: ${int.parse(direction).toRadixString(16)}");
    String directionHex = int.parse(direction).toRadixString(16);
    if(directionHex.length == 1){
      directionHex = "0" + directionHex;
    }
    bytes = bytes.replaceRange(4, 5, directionHex);
    requestedMaskValue[0] = true;
    bytes = requestedMaskValuedToHex() + bytes.substring(2);
    erdStrip = bytes;
    geaLog.debug("$tag 103: bytes length: ${bytes.length}");
    return bytes.substring(0,24); //= bytes.substring(0, 5) + BigInt.parse(direction, radix: 16).toRadixString(16) + bytes.substring(5);
  }

  String _getSpeed(String speed) {
    geaLog.debug("$tag _getSpeed: ${int.parse(speed).toRadixString(16)}");
    return int.parse(speed).toRadixString(16).padLeft(2, '0');
  }

  String _changeSpeed(String speed) {
    String bytes = _getBytes() ?? "000000000000000000000000";
    // var speedValue = BigInt.parse(speed, radix: 16);
    geaLog.debug("$tag Speed: ${int.parse(speed).toRadixString(16)}");
    String speedHex = int.parse(speed).toRadixString(16);
    if(speedHex.length == 1){
      speedHex = "0" + speedHex;
    }
    bytes = bytes.replaceRange(6, 7, speedHex);
    requestedMaskValue[1] = true;
    bytes = requestedMaskValuedToHex() + bytes.substring(2);
    geaLog.debug("$tag 113: bytes length: ${bytes.length}");
    erdStrip = bytes;
    return bytes.substring(0,24); // = bytes.substring(0, 7) + BigInt.parse(speed).toRadixString(16) + bytes.substring(7);
  }

  String _getTimer(String timer) {
    geaLog.debug("$tag _getTimer: ${int.parse(timer).toRadixString(16)}");
    return int.parse(timer).toRadixString(16).padLeft(4, '0');
  }
  String _changeTimerSetValue(String timerSetValue) {
    String bytes = _getBytes() ?? "000000000000000000000000";
    String value = int.parse(timerSetValue).toRadixString(16);
    geaLog.debug("$tag TIMER SET VALUE: " + value);
    if (value.length == 1) {
      value = "000" + value;
    } else if (value.length == 2) {
      value = "00" + value;
    } else if (value.length == 3) {
      value = "0" + value;
    }
    bytes = bytes.substring(0, 8) + value + bytes.substring(12);
    requestedMaskValue[2] = true;
    bytes = requestedMaskValuedToHex() + bytes.substring(2);
    geaLog.debug("$tag 131: bytes length: ${bytes.length}");
    erdStrip = bytes;
    return bytes.substring(0,24); // =
  }

  String _changeRelativeViscosity(String relativeViscosity) {
    String bytes = _getBytes() ?? "000000000000000000000000";
    requestedMaskValue[3] = true;
    bytes = requestedMaskValuedToHex() + bytes.substring(2);
    geaLog.debug("$tag 140: bytes length: ${bytes.length}");
    erdStrip = bytes;
    return bytes =
        bytes.substring(0, 7) + int.parse(relativeViscosity, radix: 16).toRadixString(16) + bytes.substring(8);
  }

  // 0x9303
  // 18 bytes total
  // 00000000000000000
  // byte 0 = Min Speed | Int8
  // byte 1 = Max Speed | Int8
  // byte 2-3 = Min Timer Set Value | Int16
  // byte 4-5 = Max Timer Set Value | Int16
  // byte 6-7 = Min Relative Viscosity | Int16
  // byte 8-9 = Max Relative Viscosity | Int16
  // byte 10-17 = Reserved

  // 0x9304
  String _changePauseState(String pauseState) {
    return pauseState;
  }

  String setIsMixerPaused(bool paused) {
    return "";
  }

  //0x9305
  // 1 byte total
  // 0
  // byte 0 = Mixer Mixing Cycle State  | Enum [IDLE,MIXING,PAUSED]

  //0x9228
  // 1 byte total
  // 0
  String _cancelMixing(String cancel){
    return cancel;
  }


  // 0x930F SCALE_DISPLAY_ENABLE
  String _enableScaleMode(bool value) {
    if (value) {
      return "01";
    } else {
      return "00";
    }
  }
}