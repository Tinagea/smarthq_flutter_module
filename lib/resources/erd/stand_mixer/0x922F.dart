import 'package:smarthq_flutter_module/resources/erd/erd.dart';

///### TOASTER_OVEN_COOK_TIME_REMAINING
///-  Name: **Toaster Oven Cook Time Remaining**
///-  Data Length: **4 bytes**
///-  ----------------------
class ERD0x922F {
  var remainingCookTimeSeconds;

  String address = ERD.TOASTER_OVEN_COOK_TIME_REMAINING;
  final String rawValue;

  ERD0x922F(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data recieved from 0x922f');
    }
    
    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    var bytes = rawValue;
    remainingCookTimeSeconds = int.parse(bytes, radix: 16);
  }
}
