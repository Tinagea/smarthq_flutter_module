
class Config {
  int? fahrenheitMinimum;
  int? fahrenheitMaximum;
  String? model;
  int? temperatureBufferFahrenheitMinimum;
  List<String>? supportedFanSpeeds;
  List<String>? supportedModes;
  String? integerUnits;
  int? maximum;
  int? minimum;
  bool? ordered;
  int? heatFahrenheitMaximum;
  int? coolFahrenheitMaximum;
  int? heatFahrenheitMinimum;
  int? coolFahrenheitMinimum;

  Config({
    this.fahrenheitMinimum,
    this.fahrenheitMaximum,
    this.model,
    this.temperatureBufferFahrenheitMinimum,
    this.supportedFanSpeeds,
    this.supportedModes,
    this.integerUnits,
    this.maximum,
    this.minimum,
    this.ordered,
    this.heatFahrenheitMaximum,
    this.coolFahrenheitMaximum,
    this.heatFahrenheitMinimum,
    this.coolFahrenheitMinimum});

  Config.fromJson(Map<String, dynamic> json) {
    fahrenheitMinimum = json['fahrenheitMinimum'];
    fahrenheitMaximum = json['fahrenheitMaximum'];
    model = json['model'];
    temperatureBufferFahrenheitMinimum = json['temperatureBufferFahrenheitMinimum'];
    supportedFanSpeeds = json['supportedFanSpeeds'] != null ? json['supportedFanSpeeds'].cast<String>() : null;
    supportedModes = json['supportedModes'] != null ? json['supportedModes'].cast<String>() : null;
    integerUnits = json['integerUnits'];
    maximum = json['maximum'];
    minimum = json['minimum'];
    ordered = json['ordered'];
    heatFahrenheitMaximum = json['heatFahrenheitMaximum'];
    coolFahrenheitMaximum = json['coolFahrenheitMaximum'];
    heatFahrenheitMinimum = json['heatFahrenheitMinimum'];
    coolFahrenheitMinimum = json['coolFahrenheitMinimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fahrenheitMinimum'] = this.fahrenheitMinimum;
    data['fahrenheitMaximum'] = this.fahrenheitMaximum;
    data['model'] = this.model;
    data['temperatureBufferFahrenheitMinimum'] = this.temperatureBufferFahrenheitMinimum;
    data['supportedFanSpeeds'] = this.supportedFanSpeeds;
    data['supportedModes'] = this.supportedModes;
    data['integerUnits'] = this.integerUnits;
    data['maximum'] = this.maximum;
    data['minimum'] = this.minimum;
    data['ordered'] = this.ordered;
    data['heatFahrenheitMaximum'] = this.heatFahrenheitMaximum;
    data['coolFahrenheitMaximum'] = this.coolFahrenheitMaximum;
    data['heatFahrenheitMinimum'] = this.heatFahrenheitMinimum;
    data['coolFahrenheitMinimum'] = this.coolFahrenheitMinimum;
    return data;
  }
}
