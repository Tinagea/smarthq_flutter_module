import 'dart:convert';

class ExecutionIDResponse {
  final String? kind;
  final String? status;
  final String? recipeId;
  final String? executionId;
  ExecutionIDResponse({
   this.kind,
   this.status,
   this.recipeId,
   this.executionId,
  });

  ExecutionIDResponse copyWith({
    String? kind,
    String? status,
    String? recipeId,
    String? executionId,
  }) {
    return ExecutionIDResponse(
      kind: kind ?? this.kind,
      status: status ?? this.status,
      recipeId: recipeId ?? this.recipeId,
      executionId: executionId ?? this.executionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'kind': kind ?? '',
      'status': status ?? '',
      'recipeId': recipeId ?? '',
      'executionId': executionId ?? '',
    };
  }

  factory ExecutionIDResponse.fromMap(Map<String, dynamic> map) {
    return ExecutionIDResponse(
      kind: map['kind'] ?? '',
      status: map['status'] ?? '',
      recipeId: map['recipeId'] ?? '',
      executionId: map['executionId'] ?? '',
    );
  }

  factory ExecutionIDResponse.toEmpty(){
    return ExecutionIDResponse(
      kind: '',
      status: '',
      recipeId: '',
      executionId: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExecutionIDResponse.fromJson(Map<String, dynamic> source) => ExecutionIDResponse.fromMap(json.decode(jsonEncode(source)));

  @override
  String toString() {
    return 'ExecutionIDResponse(kind: $kind, status: $status, recipeId: $recipeId, executionId: $executionId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExecutionIDResponse &&
      other.kind == kind &&
      other.status == status &&
      other.recipeId == recipeId &&
      other.executionId == executionId;
  }

  @override
  int get hashCode {
    return kind.hashCode ^
      status.hashCode ^
      recipeId.hashCode ^
      executionId.hashCode;
  }
}
