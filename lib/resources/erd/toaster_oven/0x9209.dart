/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:smarthq_flutter_module/resources/erd/erd.dart';

///### Toaster Oven Current State
///-  Name: **Toaster Oven Current State**
///-  Data Length: **1 bytes**
///-  ----------------------
class ERD0x9209 {
  ToasterOvenCurrentState toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_SLEEP;

  String address = ERD.TOASTER_OVEN_CURRENT_STATE;
  final String rawValue;

  ERD0x9209(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data received from 0x9209');
    }
    
    _toasterOvenState();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  _toasterOvenState() {
    if (this.rawValue.isEmpty) {
      toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_SLEEP;
    }
    else {
      var value = getRawValue();

      switch (value.toString()) {
        case "0":
          toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_SLEEP;
          break;
        case "1":
          toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_STANDBY;
          break;
        case "2":
          toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_INITIALIZATION;
          break;
        case "3":
          toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_COOKING;
          break;
        case "4":
          toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_PREHEATING;
          break;
        case "5":
          toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_IDLE;
          break;
        case "6":
          toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_TEMPERATURE_ACHIEVED;
          break;
        case "7":
          toasterOvenState = ToasterOvenCurrentState.TOASTER_OVEN_COOKING_COMPLETE;
          break;
        default:
      }
    }
  }
}

enum ToasterOvenCurrentState {
  TOASTER_OVEN_SLEEP,
  TOASTER_OVEN_STANDBY,
  TOASTER_OVEN_INITIALIZATION,
  TOASTER_OVEN_COOKING,
  TOASTER_OVEN_PREHEATING,
  TOASTER_OVEN_IDLE,
  TOASTER_OVEN_TEMPERATURE_ACHIEVED,
  TOASTER_OVEN_COOKING_COMPLETE
}
