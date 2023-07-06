import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';

abstract class ShortcutCreateState extends Equatable {}

class ShortcutCreateInitiate extends ShortcutCreateState {
  @override
  List<Object?> get props => [];
}

class ShortcutCreateTurnOffSucceeded extends ShortcutCreateState {
  final ShortcutSetItemModel? model;

  ShortcutCreateTurnOffSucceeded({
    required this.model
  });

  @override
  List<Object?> get props => [
    model
  ];

  @override
  String toString() => "ShortcutCreateTurnOffSucceeded {"
      "model: $model\n"
      "}";
}

class ShortcutCreateApplianceTypeLoaded extends ShortcutCreateState {
  final String? applianceType;

  ShortcutCreateApplianceTypeLoaded({
    required this.applianceType
  });

  @override
  List<Object?> get props => [
    applianceType
  ];

  @override
  String toString() => "ShortcutCreateApplianceTypeLoaded {"
      "applianceType: $applianceType\n"
      "}";
}

class ShortcutCreateOvenDataLoaded extends ShortcutCreateState {
  final String? tempUnit;
  final List<String>? modeItems;
  final List<String>? tempItems;

  ShortcutCreateOvenDataLoaded({
    required this.tempUnit,
    required this.modeItems,
    required this.tempItems
  });

  @override
  List<Object?> get props => [
    tempUnit,
    modeItems,
    tempItems
  ];

  @override
  String toString() => "ShortcutCreateOvenDataLoaded {"
      "tempUnit: $tempUnit\n"
      "modeItems: $modeItems\n"
      "tempItems: $tempItems\n"
      "}";
}

class ShortcutCreateAcDataLoaded extends ShortcutCreateState {
  final String? selectedMode;
  final String? tempUnit;
  final List<String>? modeItems;
  final List<String>? tempItems;
  final List<String>? fanItems;

  ShortcutCreateAcDataLoaded({
    required this.selectedMode,
    required this.tempUnit,
    required this.modeItems,
    required this.tempItems,
    required this.fanItems
  });

  @override
  List<Object?> get props => [
    selectedMode,
    tempUnit,
    modeItems,
    tempItems,
    fanItems
  ];

  @override
  String toString() => "ShortcutCreateAcDataLoaded {"
      "selectedMode: $selectedMode\n"
      "tempUnit: $tempUnit\n"
      "modeItems: $modeItems\n"
      "tempItems: $tempItems\n"
      "fanItems: $fanItems\n"
      "}";
}

class ShortcutCreateApplianceDetailLoaded extends ShortcutCreateState {
  final String? applianceNickname;
  final String? applianceType;
  final String? ovenRackType;

  ShortcutCreateApplianceDetailLoaded({
    required this.applianceNickname,
    required this.applianceType,
    required this.ovenRackType
  });

  @override
  List<Object?> get props => [
    applianceNickname,
    applianceType,
    ovenRackType
  ];

  @override
  String toString() => "ShortcutCreateApplianceDetailLoaded {"
      "applianceNickname: $applianceNickname\n"
      "applianceType: $applianceType\n"
      "ovenRackType: $ovenRackType\n"
      "}";
}