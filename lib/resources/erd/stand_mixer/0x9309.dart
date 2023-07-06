import 'package:smarthq_flutter_module/models/appliance_modifications_model.dart';
import 'package:smarthq_flutter_module/resources/erd/erd_interface.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

//Byte 0
//Bits 
//0 = Out of balance
//1 = Sudden stop
//2 = Check Calibration



class ERD0x9309 implements ERD {
  String address = "0x9309";
  final String rawValue;
  ApplianceAvailableModifications modifications = ApplianceAvailableModifications(direction: false, speed: false, timer: false, torque: false);

  ERD0x9309(this.rawValue) {
    if (this.rawValue.length < 1) {
      geaLog.debug("NO VALUE SET FOR 0x9309");
      return;
    }

    splitBytes();
  }

  @override
  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    String binary = int.parse(rawValue.substring(0,2), radix: 16).toRadixString(2);
    //convert to binary with the correct amount of leading zeros
    geaLog.debug("RAW VALUE: $rawValue");
    //split the binary string into an array of strings
    //make sure the binary string is 4 characters long
    geaLog.debug("BINARY: $binary");
    List<String> binaryList = binary.split("");
    //reverse the array so the bits are in the correct order
    binaryList = binaryList.reversed.toList();
    geaLog.debug("9309: BINARY LIST: $binaryList");
    //loop through the binary list and set the correct value for the notification
    for (int i = 0; i < binaryList.length; i++) {
      if (binaryList[i] == "1") {
        // MODIFICATIONS[MODIFICATION.values[i]] = true;
        modifications.setAvailableModifications(i, true);
      }
      else {
        // MODIFICATIONS[MODIFICATION.values[i]] = false;
        modifications.setAvailableModifications(i, false);
      }
    }
    geaLog.debug("MODIFICATIONS: ${modifications.toString()}");
  }

}

