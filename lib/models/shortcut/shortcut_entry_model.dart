import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/appliance_list_response.dart';

abstract class ShortcutEntryState extends Equatable {}

class ShortcutEntryInitiate extends ShortcutEntryState {
  @override
  List<Object?> get props => [];
}

class ShortcutEntryLoading extends ShortcutEntryState {
  @override
  List<Object?> get props => [];
}

class ShortcutEntryAppliancesLoaded extends ShortcutEntryState {
  final List<ApplianceListItem>? applianceList;

  ShortcutEntryAppliancesLoaded({
    required this.applianceList
  });

  @override
  List<Object?> get props => [
    applianceList
  ];

  @override
  String toString() => "ShortcutEntryAppliancesLoaded {"
      "applianceList: $applianceList\n"
      "}";
}

class ShortcutEntryOvenTypeLoaded extends ShortcutEntryState {
  final String? jid;
  final String? ovenType;

  ShortcutEntryOvenTypeLoaded({
    required this.jid,
    required this.ovenType
  });

  @override
  List<Object?> get props => [
    jid,
    ovenType
  ];

  @override
  String toString() => "ShortcutEntryOvenTypeLoaded {"
      "jid: $jid\n"
      "ovenType: $ovenType\n"
      "}";
}

class ShortcutEntryOvenSingleOvenSelected extends ShortcutEntryState {
  final String? ovenRackType;

  ShortcutEntryOvenSingleOvenSelected({
    required this.ovenRackType
  });

  @override
  List<Object?> get props => [
    ovenRackType
  ];

  @override
  String toString() => "ShortcutEntryOvenSingleOvenSelected {"
      "ovenRackType: $ovenRackType\n"
      "}";
}

class ShortcutEntryOvenDoubleOvenSelected extends ShortcutEntryState {
  @override
  List<Object?> get props => [];
}