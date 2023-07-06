
class State {
  bool? on;
  bool? disabled;
  int? secondsRemaining;
  String? upgradeStatus;
  String? versionCurrent;
  String? mode;
  double? coolCelsiusConverted;
  double? heatCelsiusConverted;
  double? celsiusConverted;
  String? fanSpeed;
  int? coolFahrenheit;
  int? heatFahrenheit;
  int? fahrenheit;
  int? value;

  State({
    this.on,
    this.disabled,
    this.fahrenheit,
    this.secondsRemaining,
    this.upgradeStatus,
    this.versionCurrent,
    this.mode,
    this.coolCelsiusConverted,
    this.celsiusConverted,
    this.fanSpeed,
    this.coolFahrenheit,
    this.heatFahrenheit,
    this.heatCelsiusConverted,
    this.value});

  State.fromJson(Map<String, dynamic> json) {
    on = json['on'];
    disabled = json['disabled'];
    secondsRemaining = json['secondsRemaining'];
    upgradeStatus = json['upgradeStatus'];
    versionCurrent = json['versionCurrent'];
    mode = json['mode'];
    coolCelsiusConverted = json['coolCelsiusConverted'] != null ?changeDouble(json['coolCelsiusConverted']) :null;
    heatCelsiusConverted = json['heatCelsiusConverted'] != null ?changeDouble(json['heatCelsiusConverted']) :null;
    celsiusConverted = json['celsiusConverted'] != null ?changeDouble(json['celsiusConverted']) :null;
    fanSpeed = json['fanSpeed'];
    coolFahrenheit = json['coolFahrenheit'];
    heatFahrenheit = json['heatFahrenheit'];
    fahrenheit = json['fahrenheit'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['on'] = this.on;
    data['disabled'] = this.disabled;
    data['secondsRemaining'] = this.secondsRemaining;
    data['upgradeStatus'] = this.upgradeStatus;
    data['versionCurrent'] = this.versionCurrent;
    data['mode'] = this.mode;
    if(this.coolCelsiusConverted != null){
      data['coolCelsiusConverted'] = this.coolCelsiusConverted;
    }
    if(this.heatCelsiusConverted != null){
      data['heatCelsiusConverted'] = this.heatCelsiusConverted;
    }
    if(this.celsiusConverted != null){
      data['coolCelsiusConverted'] = this.celsiusConverted;
    }
    data['fanSpeed'] = this.fanSpeed;
    data['coolFahrenheit'] = this.coolFahrenheit;
    data['heatFahrenheit'] = this.heatFahrenheit;
    data['fahrenheit'] = this.fahrenheit;
    data['value'] = this.value;
    return data;
  }

  static double changeDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else {
      return value;
    }
  }
}