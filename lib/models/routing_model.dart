import 'package:equatable/equatable.dart';

enum RoutingType {
  initial('/'),
  commissioning('commissioning'),
  commissioningFromDashboard('commissioningFromDashboard'),
  pairSensor('pairSensor'),
  standMixer('standMixer'),
  wifiLockerNetworkList('wifiLockerNetworkList'),
  notificationSettingPage('notificationSettingPage'),
  notificationHistoryPage('notificationHistoryPage'),
  notificationAlertDetailsPage('notificationAlertDetailsPage'),
  guidedRecipe('guidedRecipe'),
  shortcut('shortcut'),
  editShortcut('editShortcut'),
  getStartedShortcut('getStartedShortcut');

  const RoutingType(this.name);
  final String name;

  factory RoutingType.getTypeFrom({required String name}) {
    return RoutingType.values.firstWhere((value) => value.name == name,
        orElse: () => RoutingType.commissioning);
  }
}

class RoutingState extends Equatable {

  const RoutingState({
    this.seedValue,
    this.routingType
  });

  final int? seedValue;
  final RoutingType? routingType;

  @override
  List<Object?> get props => [
    seedValue,
    routingType
  ];

  @override
  String toString() => "RoutingState {"
      "seedValue: $seedValue\n"
      "routingType: $routingType\n"
      "}";

  RoutingState copyWith({
    int? seedValue,
    RoutingType? routingType
  }) {
    return RoutingState(
        seedValue: seedValue ?? this.seedValue,
        routingType: routingType ?? this.routingType
    );
  }
}