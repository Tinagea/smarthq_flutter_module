import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';

///### [MIXER_MODE_STATE]
///- Name: **Mixer Mode State**
///- Data Length: **1 byte**
///> Mixer mode state corresponding to the physical position of the mixer throw switch.

class ERD0x9300  {
  MixerMode mode = MixerMode.MIXER_OFF;

  String address = ERD.STAND_MIXER_MODE_STATE;
  final String rawValue;

  ERD0x9300(this.rawValue) {
    if (this.rawValue.length < 1) {
      throw new ArgumentError('There is no data received from 0x9300');
    }

    _mixerMode();
  }

  getRawValue() {
    return int.parse(this.rawValue, radix: 16);
  }

  _mixerMode() {
    if (this.rawValue.isEmpty) {
      mode = MixerMode.MIXER_OFF;
    }
    else {
      var value = getRawValue();

      switch (value.toString()) {
        case "0":
          mode = MixerMode.MIXER_OFF;
          break;
        case "1":
          mode = MixerMode.MIXER_REMOTE_MODE;
          break;
        case "2":
          mode = MixerMode.MIXER_MANUAL_MODE;
          break;

        default:
      }
    }
  }
}

enum MixerMode {
  MIXER_OFF,
  MIXER_REMOTE_MODE,
  MIXER_MANUAL_MODE
}

extension ParseToString on MixerMode {
  String toFormatted() {
    switch (this) {
      case MixerMode.MIXER_OFF:
        return LocaleUtil.OFF;
      case MixerMode.MIXER_REMOTE_MODE:
        return LocaleUtil.REMOTE_ENABLED;
      case MixerMode.MIXER_MANUAL_MODE:
        return LocaleUtil.MANUAL_MODE;
      default:
        return "- - -";
    }
  }
}
