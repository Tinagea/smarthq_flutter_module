import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/services/erd_model.dart';

enum StandMixerErdState {
  initiated,
  loading,
  loaded,
  cleared,
  exception
}

enum StandMixerState {
  cacheResponse,
  stateResponse,
  modelNumberResponse,
  contentResponse,
  timerUpdatedResponse,
  currentSettingsResponse,
  settingsLimitsResponse,
  reset,
}
class StandMixerControlState extends Equatable {
  final int? seedValue;
  final StandMixerState? state;
  final String? jid;
  final DevicePresence? presence;
  final StandMixerErdState? erdState;
  final String? erdResponse;
  final Map<String, String>? cache;
  final StandMixerContentModel? contentModel;

  StandMixerControlState({
    this.seedValue,
    this.state,
    this.jid,
    this.presence,
    this.erdState,
    this.erdResponse,
    this.cache,
    this.contentModel,
  });

  @override
  List<Object?> get props => [
    seedValue,
    state,
    jid,
    presence,
    erdState,
    erdResponse,
    cache,
    contentModel,
  ];

  @override
  String toString() => "StandMixerControlState {"
      "seedValue: $seedValue\n"
      "state: $state\n"
      "jid: $jid\n"
      "presence: $presence\n"
      "erdState: $erdState\n"
      "erdResponse: $erdResponse\n"
      "cache: $cache\n"
      "contentModel: $contentModel\n"
      "}";

  StandMixerControlState copyWith({
    int? seedValue,
    StandMixerState? state,
    String? jid,
    DevicePresence? presence,
    StandMixerErdState? erdState,
    String? erdResponse,
    Map<String, String>? cache,
    StandMixerContentModel? contentModel,
  }) {
    return StandMixerControlState(
        seedValue: seedValue ?? this.seedValue,
        state: state ?? this.state,
        jid: jid ?? this.jid,
        presence: presence ?? this.presence,
        erdState: erdState ?? this.erdState,
        erdResponse: erdResponse ?? this.erdResponse,
        cache: cache ?? this.cache,
        contentModel: contentModel ?? this.contentModel,
    );
  }
}

class StandMixerOscillateRequest{
  final String? kind;
  final String? userId;
  final String? applianceId;
  final int? ackTimeout;
  final String? command;
  final List<dynamic>? data;
  final int? commandLoop;

  StandMixerOscillateRequest({
    this.kind,
    this.userId,
    this.applianceId,
    this.ackTimeout,
    this.command,
    this.data,
    this.commandLoop,
  });

  StandMixerOscillateRequest.fromJson(Map<String, dynamic> json)
      : kind = json['kind'],
        userId = json['userId'],
        applianceId = json['applianceId'],
        ackTimeout = json['ackTimeout'],
        command = json['command'],
        data = json['data'],
        commandLoop = json['commandLoop'];
  
  Map<String, dynamic> toJson() => {
    'kind': kind,
    'userId': userId,
    'applianceId': applianceId,
    'ackTimeout': ackTimeout,
    'command': command,
    'data': data,
    'commandLoop': commandLoop,
  };
    
}