import 'dart:convert';

class ExecutionControlResponse {
  final String kind;
  final String userId;
  final String applianceId;
  final String applianceType;
  final Execution execution;
  ExecutionControlResponse({
    required this.kind,
    required this.userId,
    required this.applianceId,
    required this.applianceType,
    required this.execution,
  });

  ExecutionControlResponse copyWith({
    String? kind,
    String? userId,
    String? applianceId,
    String? applianceType,
    Execution? execution,
  }) {
    return ExecutionControlResponse(
      kind: kind ?? this.kind,
      userId: userId ?? this.userId,
      applianceId: applianceId ?? this.applianceId,
      applianceType: applianceType ?? this.applianceType,
      execution: execution ?? this.execution,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'kind': kind,
      'userId': userId,
      'applianceId': applianceId,
      'applianceType': applianceType,
      'execution': execution.toMap(),
    };
  }

  factory ExecutionControlResponse.fromMap(Map<String, dynamic> map) {
    return ExecutionControlResponse(
      kind: map['kind'] ?? '',
      userId: map['userId'] ?? '',
      applianceId: map['applianceId'] ?? '',
      applianceType: map['applianceType'] ?? '',
      execution: Execution.fromMap(map['execution']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExecutionControlResponse.fromJson(Map<String,dynamic> source) => ExecutionControlResponse.fromMap(json.decode(json.encode(source)));

  @override
  String toString() {
    return 'ExecutionControlResponse(kind: $kind, userId: $userId, applianceId: $applianceId, applianceType: $applianceType, execution: $execution)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExecutionControlResponse &&
      other.kind == kind &&
      other.userId == userId &&
      other.applianceId == applianceId &&
      other.applianceType == applianceType &&
      other.execution == execution;
  }

  @override
  int get hashCode {
    return kind.hashCode ^
      userId.hashCode ^
      applianceId.hashCode ^
      applianceType.hashCode ^
      execution.hashCode;
  }
}

class Execution {
  final String id;
  final String userId;
  final String recipeId;
  final String cavity;
  final String instructionId;
  final String label;
  final String description;
  final String mediaUrl;
  final String mediaSha256;
  final bool isScanToCook;
  final bool isCookbook;
  final bool isTransient;
  final String created;
  final int currentStepIndex;
  final List<ExecutionStep> executionSteps;
  Execution({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.cavity,
    required this.instructionId,
    required this.label,
    required this.description,
    required this.mediaUrl,
    required this.mediaSha256,
    required this.isScanToCook,
    required this.isCookbook,
    required this.isTransient,
    required this.created,
    required this.currentStepIndex,
    required this.executionSteps,
  });

  Execution copyWith({
    String? id,
    String? userId,
    String? recipeId,
    String? cavity,
    String? instructionId,
    String? label,
    String? description,
    String? mediaUrl,
    String? mediaSha256,
    bool? isScanToCook,
    bool? isCookbook,
    bool? isTransient,
    String? created,
    int? currentStepIndex,
    List<ExecutionStep>? executionSteps,
  }) {
    return Execution(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      recipeId: recipeId ?? this.recipeId,
      cavity: cavity ?? this.cavity,
      instructionId: instructionId ?? this.instructionId,
      label: label ?? this.label,
      description: description ?? this.description,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaSha256: mediaSha256 ?? this.mediaSha256,
      isScanToCook: isScanToCook ?? this.isScanToCook,
      isCookbook: isCookbook ?? this.isCookbook,
      isTransient: isTransient ?? this.isTransient,
      created: created ?? this.created,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      executionSteps: executionSteps ?? this.executionSteps,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'recipeId': recipeId,
      'cavity': cavity,
      'instructionId': instructionId,
      'label': label,
      'description': description,
      'mediaUrl': mediaUrl,
      'mediaSha256': mediaSha256,
      'isScanToCook': isScanToCook,
      'isCookbook': isCookbook,
      'isTransient': isTransient,
      'created': created,
      'currentStepIndex': currentStepIndex,
      'executionSteps': executionSteps.map((x) => x.toMap()).toList(),
    };
  }

  factory Execution.fromMap(Map<String, dynamic> map) {
    return Execution(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      recipeId: map['recipeId'] ?? '',
      cavity: map['cavity'] ?? '',
      instructionId: map['instructionId'] ?? '',
      label: map['label'] ?? '',
      description: map['description'] ?? '',
      mediaUrl: map['mediaUrl'] ?? '',
      mediaSha256: map['mediaSha256'] ?? '',
      isScanToCook: map['isScanToCook'] ?? false,
      isCookbook: map['isCookbook'] ?? false,
      isTransient: map['isTransient'] ?? false,
      created: map['created'] ?? '',
      currentStepIndex: map['currentStepIndex'],
      executionSteps: List<ExecutionStep>.from(map['executionSteps']?.map((x) => ExecutionStep.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Execution.fromJson(String source) => Execution.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Execution(id: $id, userId: $userId, recipeId: $recipeId, cavity: $cavity, instructionId: $instructionId, label: $label, description: $description, mediaUrl: $mediaUrl, mediaSha256: $mediaSha256, isScanToCook: $isScanToCook, isCookbook: $isCookbook, isTransient: $isTransient, created: $created, currentStepIndex: $currentStepIndex, executionSteps: $executionSteps)';
  }
}
class ExecutionStep {
  final String id;
  final String type;
  final String label;
  final String directions;
  final String mediaUrl;
  final String mediaSha256;
  final String mode;
  final String temperatureF;
  ExecutionStep({
    required this.id,
    required this.type,
    required this.label,
    required this.directions,
    required this.mediaUrl,
    required this.mediaSha256,
    required this.mode,
    required this.temperatureF,
  });

  ExecutionStep copyWith({
    String? id,
    String? type,
    String? label,
    String? directions,
    String? mediaUrl,
    String? mediaSha256,
    String? mode,
    String? temperatureF,
  }) {
    return ExecutionStep(
      id: id ?? this.id,
      type: type ?? this.type,
      label: label ?? this.label,
      directions: directions ?? this.directions,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaSha256: mediaSha256 ?? this.mediaSha256,
      mode: mode ?? this.mode,
      temperatureF: temperatureF ?? this.temperatureF,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'label': label,
      'directions': directions,
      'mediaUrl': mediaUrl,
      'mediaSha256': mediaSha256,
      'mode': mode,
      'temperatureF': temperatureF,
    };
  }

  factory ExecutionStep.fromMap(Map<String, dynamic> map) {
    return ExecutionStep(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      label: map['label'] ?? '',
      directions: map['directions'] ?? '',
      mediaUrl: map['mediaUrl'] ?? '',
      mediaSha256: map['mediaSha256'] ?? '',
      mode: map['mode'] ?? '',
      temperatureF: map['temperatureF'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExecutionStep.fromJson(String source) => ExecutionStep.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExecutionStep(id: $id, type: $type, label: $label, directions: $directions, mediaUrl: $mediaUrl, mediaSha256: $mediaSha256, mode: $mode, temperatureF: $temperatureF)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExecutionStep &&
      other.id == id &&
      other.type == type &&
      other.label == label &&
      other.directions == directions &&
      other.mediaUrl == mediaUrl &&
      other.mediaSha256 == mediaSha256 &&
      other.mode == mode &&
      other.temperatureF == temperatureF;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      type.hashCode ^
      label.hashCode ^
      directions.hashCode ^
      mediaUrl.hashCode ^
      mediaSha256.hashCode ^
      mode.hashCode ^
      temperatureF.hashCode;
  }
}