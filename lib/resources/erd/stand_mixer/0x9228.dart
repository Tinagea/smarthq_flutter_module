import 'package:smarthq_flutter_module/resources/erd/erd.dart';

///### Toaster Oven Cancel Operation
///-  Name: **Toaster Oven Cancel Operation**
///-  Data Length: **4 bytes**
///-  ----------------------
class ERD0x9228 {
  var cancelOperation;

  String address = ERD.TOASTER_OVEN_CANCEL_OPERATION;
  final String rawValue;

  ERD0x9228(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data recieved from 0x9228');
    }

    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    var bytes = rawValue;
    cancelOperation = int.parse(bytes.substring(0, 1), radix: 16) == 1;
  }
}
