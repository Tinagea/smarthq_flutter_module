


class ApplianceAvailableModifications {
  bool direction;
  bool speed;
  bool timer;
  bool torque;

  ApplianceAvailableModifications({
    required this.direction,
    required this.speed,
    required this.timer,
    required this.torque,
  });

 
  factory ApplianceAvailableModifications.fromJson(Map<String, dynamic> json) {
    return ApplianceAvailableModifications(
      direction: json['direction'],
      speed: json['speed'],
      timer: json['timer'],
      torque: json['torque'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'direction': direction,
      'speed': speed,
      'timer': timer,
      'torque': torque,
    };
  }
  //set value based on index
  void setAvailableModifications(int index, bool value) {
    switch (index) {
      case 0:
        direction = value;
        break;
      case 1:
        speed = value;
        break;
      case 2:
        timer = value;
        break;
      case 3:
        torque = value;
        break;
    }
  }


  @override
  String toString() {
    return 'ApplianceAvailableModifications(direction: $direction, speed: $speed, timer: $timer, torque: $torque)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplianceAvailableModifications &&
        other.direction == direction &&
        other.speed == speed &&
        other.timer == timer &&
        other.torque == torque;
  }

  @override
  int get hashCode {
    return direction.hashCode ^
        speed.hashCode ^
        timer.hashCode ^
        torque.hashCode;
  }

}