import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x922F.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9300.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9301.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9303.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9305.dart';
import 'package:smarthq_flutter_module/resources/erd/toaster_oven/0x9209.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

abstract class BaseErdService {
  String getRemainingCookTimeSeconds(String value);
  ERD0x9301 getMixerControlCurrentSettings(String value);
  ERD0x9303 getMixerControlSettingsLimits(String value);
  MixerState getMixerCycleState(String value);
  ToasterOvenCurrentState getToasterOvenState(String value);
}

class ErdService implements BaseErdService {
  static const String tag = "ErdService:";

  String getRemainingCookTimeSeconds(String value) {
    geaLog.debug("$tag getRemainingCookTimeSeconds: $value");
    ERD0x922F _erd0x922f = ERD0x922F(value);
    return _erd0x922f.remainingCookTimeSeconds.toString();
  }

  MixerMode getMixerMode(String value) {
    geaLog.debug("$tag getMixerMode: $value");
    ERD0x9300 _erd0x9300 = ERD0x9300(value);
    return _erd0x9300.mode;
  }

  ERD0x9301 getMixerControlCurrentSettings(String value) {
    geaLog.debug("$tag getMixerControlCurrentSettings: $value");
    ERD0x9301 _erd0x9301 = ERD0x9301(value);
    return _erd0x9301;
  }

  ERD0x9303 getMixerControlSettingsLimits(String value) {
    geaLog.debug("$tag getMixerControlSettingsLimits: $value");
    ERD0x9303 _erd0x9303 = ERD0x9303(value);
    return _erd0x9303;
  }

  MixerState getMixerCycleState(String value) {
    geaLog.debug("$tag getMixerCycleState: $value");
    ERD0x9305 _erd0x9305 = ERD0x9305(value);
    return _erd0x9305.getMixerState();
  }
  
  ToasterOvenCurrentState getToasterOvenState(String value) {
    geaLog.debug("$tag getToasterOvenState: $value");
    ERD0x9209 __erd0x9209 = ERD0x9209(value);
    return __erd0x9209.toasterOvenState;
  }
  
}