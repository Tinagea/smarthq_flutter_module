import 'package:smarthq_flutter_module/resources/erd/erd.dart';

///###  MIXER_CONTROL_SETTINGS_LIMITS
/// - Name: **Mixer Control Settings Limits**
/// - Data Length: **10 bytes**
/// ----------------------
class ERD0x9303 {
  var minSpeed;
  var maxSpeed;
  var minTimerSetValue;
  var maxTimerSetValue;
  var minRelativeViscosity;
  var maxRelativeViscosity;

  String address = ERD.STAND_MIXER_CONTROL_SETTINGS_LIMITS;
  final String rawValue;

  ERD0x9303(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data recieved from 0x9303');
    }

    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    var bytes = this.rawValue;
    print(bytes);

    if (bytes.isEmpty ||
        bytes.length == 0) return;

    minSpeed = int.parse(bytes.substring(0, 2), radix: 16);
    maxSpeed = int.parse(bytes.substring(2, 4), radix: 16);
    minTimerSetValue = int.parse(bytes.substring(4, 8), radix: 16);
    maxTimerSetValue = int.parse(bytes.substring(8, 12), radix: 16);
    minRelativeViscosity = int.parse(bytes.substring(12, 16), radix: 16);
    maxRelativeViscosity = int.parse(bytes.substring(16, 20), radix: 16);
  }
}
