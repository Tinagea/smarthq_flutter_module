import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';

abstract class ShortcutEditState extends Equatable {}

class ShortcutEditInitiate extends ShortcutEditState {
  @override
  List<Object?> get props => [];
}

class ShortcutEditSavedShortcut extends ShortcutEditState {
  final ShortcutSetListModel? model;

  ShortcutEditSavedShortcut({
    required this.model
  });

  @override
  List<Object?> get props => [
    this.model
  ];

  @override
  String toString() => "ShortcutEditSavedShortcut {"
      "model: $model\n"
      "}";
}

class ShortcutEditSavedTurnOffShortcut extends ShortcutEditState {
  final ShortcutSetListModel? model;

  ShortcutEditSavedTurnOffShortcut({
    required this.model
  });

  @override
  List<Object?> get props => [
    model
  ];

  @override
  String toString() => "ShortcutEditSavedTurnOffShortcut {"
      "model: $model\n"
      "}";
}

class ShortcutEditApplianceTypeLoaded extends ShortcutEditState {
  final String? applianceType;

  ShortcutEditApplianceTypeLoaded({
    required this.applianceType
  });

  @override
  List<Object?> get props => [
    applianceType
  ];

  @override
  String toString() => "ShortcutEditApplianceTypeLoaded {"
      "applianceType: $applianceType\n"
      "}";
}

class ShortcutEditOvenDataLoaded extends ShortcutEditState {
  final String? tempUnit;
  final List<String>? modeItems;
  final List<String>? tempItems;

  ShortcutEditOvenDataLoaded({
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
  String toString() => "ShortcutEditOvenDataLoaded {"
      "tempUnit: $tempUnit\n"
      "modeItems: $modeItems\n"
      "tempItems: $tempItems\n"
      "}";
}

class ShortcutEditAcDataLoaded extends ShortcutEditState {
  final String? selectedMode;
  final String? tempUnit;
  final List<String>? modeItems;
  final List<String>? tempItems;
  final List<String>? fanItems;

  ShortcutEditAcDataLoaded({
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
  String toString() => "ShortcutEditAcDataLoaded {"
      "selectedMode: $selectedMode\n"
      "tempUnit: $tempUnit\n"
      "modeItems: $modeItems\n"
      "tempItems: $tempItems\n"
      "fanItems: $fanItems\n"
      "}";
}

class ShortcutEditApplianceDetailLoaded extends ShortcutEditState {
  final String? applianceNickname;
  final String? applianceType;
  final String? ovenRackType;

  ShortcutEditApplianceDetailLoaded({
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
  String toString() => "ShortcutEditApplianceDetailLoaded {"
      "applianceNickname: $applianceNickname\n"
      "applianceType: $applianceType\n"
      "ovenRackType: $ovenRackType\n"
      "}";
}

class ShortcutEditTurnOffSucceeded extends ShortcutEditState {
  @override
  List<Object?> get props => [];
}

class ShortcutEditRemoveSucceeded extends ShortcutEditState {
  @override
  List<Object?> get props => [];
}