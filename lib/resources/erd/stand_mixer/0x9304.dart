import 'package:smarthq_flutter_module/resources/erd/erd.dart';

///### MIXER_PAUSE_MIXING_CYCLE
///-  Name: **Mixer Pause Mixing Cycle**
///-  Data Length: **1 byte**
///-  ----------------------
class ERD0x9304  {
  var mixerPauseMixingCycle;

  String address = ERD.STAND_MIXER_PAUSE_MIXING_CYCLE;
  final String rawValue;

  ERD0x9304(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data recieved from 0x9304');
    }

    splitBytes();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  splitBytes() {
    var bytes = getRawValue().toString();
    mixerPauseMixingCycle = int.parse(bytes.substring(0, 1), radix: 16) == 1;
  }
}
