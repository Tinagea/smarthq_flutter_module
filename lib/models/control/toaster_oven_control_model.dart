/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';

enum ToasterOvenErdState {
  initiated,
  loading,
  loaded,
  cleared,
  exception
}

enum ToasterOvenState {
  cacheResponse,
  stateResponse,
  modelNumberResponse,
  contentResponse,
  timerUpdatedResponse,
  currentSettingsResponse,
  settingsLimitsResponse,
  reset,
}

class ToasterOvenControlState extends Equatable {
  final int? seedValue;
  final ToasterOvenState? state;
  final String? jid;
  final DevicePresence? presence;
  final ToasterOvenErdState? erdState;
  final String? erdResponse;
  final Map<String, String>? cache;

  ToasterOvenControlState({
    this.seedValue,
    this.state,
    this.jid,
    this.presence,
    this.erdState,
    this.erdResponse,
    this.cache,
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
      "}";

  ToasterOvenControlState copyWith({
    int? seedValue,
    ToasterOvenState? state,
    String? jid,
    DevicePresence? presence,
    ToasterOvenErdState? erdState,
    String? erdResponse,
    Map<String, String>? cache,
  }) {
    return ToasterOvenControlState(
      seedValue: seedValue ?? this.seedValue,
      state: state ?? this.state,
      jid: jid ?? this.jid,
      presence: presence ?? this.presence,
      erdState: erdState ?? this.erdState,
      erdResponse: erdResponse ?? this.erdResponse,
      cache: cache ?? this.cache,
    );
  }
}