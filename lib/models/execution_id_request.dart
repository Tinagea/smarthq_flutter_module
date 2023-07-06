import 'dart:convert';

class ExecutionIDRequest {
  final String kind;
  final String userId;
  final String applianceType;
  final String recipeId;
  final String instruction;
  final String selectedOptionConfigId;
  final String applianceId;
  final bool sendStepNotification;
  ExecutionIDRequest({
    required this.kind,
    required this.userId,
    required this.applianceType,
    required this.recipeId,
    required this.instruction,
    required this.selectedOptionConfigId,
    required this.applianceId,
    this.sendStepNotification = false,
  });

  ExecutionIDRequest copyWith({
    String? kind,
    String? userId,
    String? applianceType,
    String? recipeId,
    String? instruction,
    String? selectedOptionConfigId,
    String? applianceId,
    bool? sendStepNotification,
  }) {
    return ExecutionIDRequest(
      kind: kind ?? this.kind,
      userId: userId ?? this.userId,
      applianceType: applianceType ?? this.applianceType,
      recipeId: recipeId ?? this.recipeId,
      instruction: instruction ?? this.instruction,
      selectedOptionConfigId: selectedOptionConfigId ?? this.selectedOptionConfigId,
      applianceId: applianceId ?? this.applianceId,
      sendStepNotification: sendStepNotification ?? this.sendStepNotification,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'kind': kind,
      'userId': userId,
      'applianceType': applianceType,
      'recipeId': recipeId,
      'instruction': instruction,
      'selectedOptionConfigId': selectedOptionConfigId,
      'applianceId': applianceId,
      'sendStepNotification': sendStepNotification,
    };
  }

  factory ExecutionIDRequest.fromMap(Map<String, dynamic> map) {
    return ExecutionIDRequest(
      kind: map['kind'] ?? '',
      userId: map['userId'] ?? '',
      applianceType: map['applianceType'] ?? '',
      recipeId: map['recipeId'] ?? '',
      instruction: map['instruction'] ?? '',
      selectedOptionConfigId: map['selectedOptionConfigId'] ?? '',
      applianceId: map['applianceId'] ?? '',
      sendStepNotification: map['sendStepNotification'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory ExecutionIDRequest.fromJson(String source) => ExecutionIDRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExecutionIDRequest(kind: $kind, userId: $userId, applianceType: $applianceType, recipeId: $recipeId, instruction: $instruction, selectedOptionConfigId: $selectedOptionConfigId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExecutionIDRequest &&
      other.kind == kind &&
      other.userId == userId &&
      other.applianceType == applianceType &&
      other.recipeId == recipeId &&
      other.instruction == instruction &&
      other.selectedOptionConfigId == selectedOptionConfigId &&
      other.applianceId == applianceId &&
      other.sendStepNotification == sendStepNotification;

  }

  @override
  int get hashCode {
    return kind.hashCode ^
      userId.hashCode ^
      applianceType.hashCode ^
      recipeId.hashCode ^
      instruction.hashCode ^
      selectedOptionConfigId.hashCode;
  }
}