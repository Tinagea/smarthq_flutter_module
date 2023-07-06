import 'package:smarthq_flutter_module/models/execution_control_response.dart';
import 'dart:convert';

class ExecutionResponse {
  final String kind;
  final String userId;
  final String applianceId;
  final String applianceType;
  final Execution execution;
  final String status;
  final int stepIndex;

  ExecutionResponse({
    required this.kind,
    required this.userId,
    required this.applianceId,
    required this.applianceType,
    required this.execution,
    required this.status,
    required this.stepIndex,
  });

  ExecutionResponse copyWith({
    String? kind,
    String? userId,
    String? applianceId,
    String? applianceType,
    Execution? execution,
    String? status,
    int? stepIndex,
  }) {
    return ExecutionResponse(
      kind: kind ?? this.kind,
      userId: userId ?? this.userId,
      applianceId: applianceId ?? this.applianceId,
      applianceType: applianceType ?? this.applianceType,
      execution: execution ?? this.execution,
      status: status ?? this.status,
      stepIndex: stepIndex ?? this.stepIndex,
    );
  }

  //  fromMap
  
  factory ExecutionResponse.fromMap(Map<String, dynamic> map) {
    return ExecutionResponse(
      kind: map['kind'] ?? '',
      userId: map['userId'] ?? '',
      applianceId: map['applianceId'] ?? '',
      applianceType: map['applianceType'] ?? '',
      execution: Execution.fromMap(map['execution']),
      status: map['status'] ?? '',
      stepIndex: map['stepIndex'] ?? 0,
    );
  }

  // fromJson
  factory ExecutionResponse.fromJson(Map<String, dynamic> source) => ExecutionResponse.fromMap(json.decode(jsonEncode(source)));


}
