import 'package:smarthq_flutter_module/resources/erd/erd.dart';

///### MIXING_CYCLE_STATE
///- Name: **Mixer State**
///- Data Length: **1 byte**
/// ----------------------
///- `0` Idle
///- `1` Mixing
///- `2` Paused
///
class ERD0x9305 {
  String address = ERD.STAND_MIXER_STATE;
  final String rawValue;

  ERD0x9305(this.rawValue);

  getRawValue() {
    if (this.rawValue.length < 1) {
      return -1;
    }

    return int.parse(rawValue, radix: 16);
  }

  getMixerState() {
    switch (this.getRawValue()) {
      case 0:
        return MixerState.MIXER_IDLE;
      case 1:
        return MixerState.MIXER_MIXING;
      case 2:
        return MixerState.MIXER_PAUSED;
      default:
        return MixerState.MIXER_IDLE;
    }
  }
}

enum MixerState {
  MIXER_IDLE,
  MIXER_MIXING,
  MIXER_PAUSED
}

extension ParseToString on MixerState {
  String toValueString() {
    switch (this) {
      case MixerState.MIXER_IDLE:
        return "0";
      case MixerState.MIXER_MIXING:
        return "1";
      case MixerState.MIXER_PAUSED:
        return "2";
      default:
        return "0";
    }
  }
}
