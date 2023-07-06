import 'dart:convert';

class ExecutionControlRequest {
  final String? kind;
  final String? userId;
  final String? applianceType;
  final String? executionId;
  final String? status;
  final int? stepIndex;
  final String? applianceId;
  final bool sendStepNotification;
  ExecutionControlRequest({
    this.kind,
    this.userId,
    this.applianceType,
    this.executionId,
    this.status,
    this.stepIndex,
    this.applianceId,
    this.sendStepNotification = false,
  });

  ExecutionControlRequest copyWith({
    String? kind,
    String? userId,
    String? applianceId,
    String? applianceType,
    String? executionId,
    String? status,
    int? stepIndex,
    bool? sendStepNotification,
  }) {
    return ExecutionControlRequest(
      kind: kind ?? this.kind,
      userId: userId ?? this.userId,
      applianceType: applianceType ?? this.applianceType,
      executionId: executionId ?? this.executionId,
      status: status ?? this.status,
      stepIndex: stepIndex ?? this.stepIndex,
      applianceId: applianceId ?? this.applianceId,
      sendStepNotification: sendStepNotification ?? this.sendStepNotification,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'kind': kind ?? '',
      'userId': userId ?? '',
      'applianceType': applianceType ?? '',
      'executionId': executionId ?? '',
      'status': status ?? '',
      'stepIndex': stepIndex ?? 0,
      'applianceId': applianceId ?? '',
      'sendStepNotification': sendStepNotification,
    };
  }

  factory ExecutionControlRequest.fromMap(Map<String, dynamic> map) {
    return ExecutionControlRequest(
      kind: map['kind'] ?? '',
      userId: map['userId'] ?? '',
      applianceType: map['applianceType'] ?? '',
      executionId: map['executionId'] ?? '',
      status: map['status'] ?? '',
      stepIndex: map['stepIndex']?.toInt() ?? 0,
      applianceId: map['applianceId'] ?? '',
      sendStepNotification: map['sendStepNotification'] ?? false,

    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory ExecutionControlRequest.fromJson(String source) => ExecutionControlRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExecutionControlRequest(kind: $kind, userId: $userId, applianceType: $applianceType, executionId: $executionId, status: $status, stepIndex: $stepIndex)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExecutionControlRequest &&
      other.kind == kind &&
      other.userId == userId &&
      other.applianceType == applianceType &&
      other.executionId == executionId &&
      other.status == status &&
      other.stepIndex == stepIndex &&
      other.applianceId == applianceId &&
      other.sendStepNotification == sendStepNotification;

  }

  @override
  int get hashCode {
    return kind.hashCode ^
      userId.hashCode ^
      applianceType.hashCode ^
      executionId.hashCode ^
      status.hashCode ^
      stepIndex.hashCode;
  }
}