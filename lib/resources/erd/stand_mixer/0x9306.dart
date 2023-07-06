import 'package:smarthq_flutter_module/utils/log_util.dart';

//Byte 0
//Bits 
//0 = Out of balance
//1 = Sudden stop
//2 = Check Calibration



class ERD0x9306 {
  String address = "0x9306";
  final String rawValue;
  Map<NOTIFICATION, bool> notifications = {
    NOTIFICATION.OUT_OF_BALANCE: false,
    NOTIFICATION.SUDDEN_STOP: false,
    NOTIFICATION.CHECK_CALIBRATION: false,
    NOTIFICATION.MIXING_CYCLE_COMPLETE: false,
  };
  ERD0x9306(this.rawValue) {
    if (this.rawValue.length < 1) {
      geaLog.debug("NO VALUE SET FOR 0x9306");
      return;
    }
    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    String binary = int.parse(rawValue.substring(0,2), radix: 16).toRadixString(2);
    //convert to binary with the correct amount of leading zeros
    geaLog.debug("RAW VALUE: $rawValue");
    //split the binary string into an array of strings
    geaLog.debug("BINARY: $binary");
    List<String> binaryList = binary.split("");
    //reverse the array so the bits are in the correct order
    binaryList = binaryList.reversed.toList();
    geaLog.debug("BINARY LIST: $binaryList");
    //loop through the binary list and set the correct value for the notification
    for (int i = 0; i < binaryList.length; i++) {
      if (binaryList[i] == "1") {
        notifications[NOTIFICATION.values[i]] = true;
      } else {
        notifications[NOTIFICATION.values[i]] = false;
      }
    }
    geaLog.debug("NOTIFICATIONS: $notifications");
  }

}

enum NOTIFICATION {
  OUT_OF_BALANCE,
  SUDDEN_STOP,
  CHECK_CALIBRATION,
  MIXING_CYCLE_COMPLETE,
  SCALE_TARGET_WEIGHT_REACHED,
}
