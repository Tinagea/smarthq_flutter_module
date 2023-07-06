import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';

abstract class ShortcutServiceBody {
  const ShortcutServiceBody();

  Map<String, dynamic> toJson();
}

class ShortcutServiceBodyOvenType implements ShortcutServiceBody{
  String? ovenType;
  ShortcutServiceBodyOvenType({this.ovenType});

  ShortcutServiceBodyOvenType.fromJson(Map<String, dynamic> json) {
    ovenType = json['ovenType'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ovenType'] = this.ovenType;
    return data;
  }
}

class ShortcutServiceBodyOvenModes implements ShortcutServiceBody{
  List<String>? ovenModes;
  ShortcutServiceBodyOvenModes({this.ovenModes});

  ShortcutServiceBodyOvenModes.fromJson(Map<String, dynamic> json) {
    ovenModes = (json['ovenModes'] as List).map((item) => item as String).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ovenModes'] = this.ovenModes;
    return data;
  }
}

class ShortcutServiceBodyOvenTemps implements ShortcutServiceBody{
  String? tempUnit;
  List<String>? ovenTemps;
  ShortcutServiceBodyOvenTemps({
    this.tempUnit,
    this.ovenTemps});

  ShortcutServiceBodyOvenTemps.fromJson(Map<String, dynamic> json) {
    tempUnit = json['tempUnit'];
    ovenTemps = (json['ovenTemps'] as List).map((item) => item as String).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tempUnit'] = this.tempUnit;
    data['ovenTemps'] = this.ovenTemps;
    return data;
  }
}

class ShortcutServiceBodyAcModes implements ShortcutServiceBody{
  List<String>? acModes;
  ShortcutServiceBodyAcModes({this.acModes});

  ShortcutServiceBodyAcModes.fromJson(Map<String, dynamic> json) {
    acModes = (json['acModes'] as List).map((item) => item as String).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['acModes'] = this.acModes;
    return data;
  }
}

class ShortcutServiceBodyAcTemps implements ShortcutServiceBody{
  String? tempUnit;
  List<String>? acTemps;
  ShortcutServiceBodyAcTemps({
    this.tempUnit,
    this.acTemps});

  ShortcutServiceBodyAcTemps.fromJson(Map<String, dynamic> json) {
    tempUnit = json['tempUnit'];
    acTemps = (json['acTemps'] as List).map((item) => item as String).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tempUnit'] = this.tempUnit;
    data['acTemps'] = this.acTemps;
    return data;
  }
}

class ShortcutServiceBodyAcFans implements ShortcutServiceBody{
  List<String>? acFans;
  ShortcutServiceBodyAcFans({this.acFans});

  ShortcutServiceBodyAcFans.fromJson(Map<String, dynamic> json) {
    acFans = (json['acFans'] as List).map((item) => item as String).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['acFans'] = this.acFans;
    return data;
  }
}

class ShortcutServiceBodyAllShortcuts implements ShortcutServiceBody {
  List<ShortcutListModel>? list;

  ShortcutServiceBodyAllShortcuts({this.list});

  ShortcutServiceBodyAllShortcuts.fromJson(Map<String, dynamic> json) {
    list = (json as List).map((item) => item as ShortcutListModel).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['allShortcuts'] = this.list;
    return data;
  }
}
