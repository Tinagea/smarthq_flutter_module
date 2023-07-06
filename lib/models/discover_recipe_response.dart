import 'dart:convert';
import 'package:collection/collection.dart';

class DiscoverRecipeResponse {
  final String kind;
  final List<Result> result;
  DiscoverRecipeResponse({
    required this.kind,
    required this.result,
  });

  DiscoverRecipeResponse copyWith({
    String? kind,
    List<Result>? result,
  }) {
    return DiscoverRecipeResponse(
      kind: kind ?? this.kind,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kind': kind,
      'result': result.map((x) => x.toMap()).toList(),
    };
  }

  factory DiscoverRecipeResponse.fromMap(Map<String, dynamic> map) {
    return DiscoverRecipeResponse(
      kind: map['kind'] ?? "",
      result: List<Result>.from((map['result'] as List<dynamic>).map<Result>((x) => Result.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());
  
  factory DiscoverRecipeResponse.fromJson(Map<String, dynamic> source) => DiscoverRecipeResponse.fromMap(json.decode(jsonEncode(source)));

  factory DiscoverRecipeResponse.asEmpty(){
    return DiscoverRecipeResponse(
      kind: '',
      result: [],
    );
  }

  @override
  String toString() => 'DiscoverRecipeResponse(kind: $kind, result: $result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is DiscoverRecipeResponse &&
      other.kind == kind &&
      listEquals(other.result, result);
  }

  @override
  int get hashCode => kind.hashCode ^ result.hashCode;
}

class Result {
  final String metaId;
  final String metaName;
  final String status;
  final String recipeId;
  final String mediaId;
  final String recipeEnvironment;
  final bool isPublic;
  final bool isCookbook;
  final bool isScanToCook;
  final bool isCommunityPublic;
  final bool isConsumerRecipe;
  final String label;
  final String? brand;
  final String notes;
  final String updated;
  final String lastModifiedBy;
  final List<dynamic> dietaryPreference;
  final List<dynamic> season;
  final List<dynamic> course;
  final List<dynamic> cuisine;
  final List<Instruction> instructions;
  final List<MatchedInstruction> matchedInstructions;
  final List<Media> media;
  final bool isAuthenticatedUserFavorite;
  final String shortDescription;
  final List<dynamic>? domains;
  final List<dynamic>? affiliateBrands;
  Result({
    required this.metaId,
    required this.metaName,
    required this.status,
    required this.recipeId,
    required this.mediaId,
    required this.recipeEnvironment,
    required this.isPublic,
    required this.isCookbook,
    required this.isScanToCook,
    required this.isCommunityPublic,
    required this.isConsumerRecipe,
    required this.label,
    required this.brand,
    required this.notes,
    required this.updated,
    required this.lastModifiedBy,
    required this.dietaryPreference,
    required this.season,
    required this.course,
    required this.cuisine,
    required this.instructions,
    required this.matchedInstructions,
    required this.media,
    required this.isAuthenticatedUserFavorite,
    required this.shortDescription,
    required this.domains,
    required this.affiliateBrands,
  });

  Result copyWith({
    String? metaId,
    String? metaName,
    String? status,
    String? recipeId,
    String? mediaId,
    String? recipeEnvironment,
    bool? isPublic,
    bool? isCookbook,
    bool? isScanToCook,
    bool? isCommunityPublic,
    bool? isConsumerRecipe,
    String? label,
    String? brand,
    String? notes,
    String? updated,
    String? lastModifiedBy,
    List<dynamic>? dietaryPreference,
    List<dynamic>? season,
    List<dynamic>? course,
    List<dynamic>? cuisine,
    List<Instruction>? instructions,
    List<MatchedInstruction>? matchedInstructions,
    List<Media>? media,
    bool? isAuthenticatedUserFavorite,
    String? shortDescription,
    List<dynamic>? domains,
    List<dynamic>? affiliateBrands,
  }) {
    return Result(
      metaId: metaId ?? this.metaId,
      metaName: metaName ?? this.metaName,
      status: status ?? this.status,
      recipeId: recipeId ?? this.recipeId,
      mediaId: mediaId ?? this.mediaId,
      recipeEnvironment: recipeEnvironment ?? this.recipeEnvironment,
      isPublic: isPublic ?? this.isPublic,
      isCookbook: isCookbook ?? this.isCookbook,
      isScanToCook: isScanToCook ?? this.isScanToCook,
      isCommunityPublic: isCommunityPublic ?? this.isCommunityPublic,
      isConsumerRecipe: isConsumerRecipe ?? this.isConsumerRecipe,
      label: label ?? this.label,
      brand: brand ?? this.brand,
      notes: notes ?? this.notes,
      updated: updated ?? this.updated,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      dietaryPreference: dietaryPreference ?? this.dietaryPreference,
      season: season ?? this.season,
      course: course ?? this.course,
      cuisine: cuisine ?? this.cuisine,
      instructions: instructions ?? this.instructions,
      matchedInstructions: matchedInstructions ?? this.matchedInstructions,
      media: media ?? this.media,
      isAuthenticatedUserFavorite: isAuthenticatedUserFavorite ?? this.isAuthenticatedUserFavorite,
      shortDescription: shortDescription ?? this.shortDescription,
      domains: domains ?? this.domains,
      affiliateBrands: affiliateBrands ?? this.affiliateBrands,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'metaId': metaId,
      'metaName': metaName,
      'status': status,
      'recipeId': recipeId,
      'mediaId': mediaId,
      'recipeEnvironment': recipeEnvironment,
      'isPublic': isPublic,
      'isCookbook': isCookbook,
      'isScanToCook': isScanToCook,
      'isCommunityPublic': isCommunityPublic,
      'isConsumerRecipe': isConsumerRecipe,
      'label': label,
      'brand': brand,
      'notes': notes,
      'updated': updated,
      'lastModifiedBy': lastModifiedBy,
      'dietaryPreference': dietaryPreference,
      'season': season,
      'course': course,
      'cuisine': cuisine,
      'instructions': instructions.map((x) => x.toMap()).toList(),
      'matchedInstructions': matchedInstructions.map((x) => x.toMap()).toList(),
      'media': media.map((x) => x.toMap()).toList(),
      'isAuthenticatedUserFavorite': isAuthenticatedUserFavorite,
      'shortDescription': shortDescription,
      'domains': domains,
      'affiliateBrands': affiliateBrands,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      metaId: map['metaId'] ?? "",
      metaName: map['metaName'] ?? "",
      status: map['status'] ?? "",
      recipeId: map['recipeId'] as String,
      mediaId: map['mediaId'] ?? "",
      recipeEnvironment: map['recipeEnvironment'] ?? "",
      isPublic: map['isPublic'] ?? false,
      isCookbook: map['isCookbook'] ?? false,
      isScanToCook: map['isScanToCook'] ?? false,
      isCommunityPublic: map['isCommunityPublic'] ?? false,
      isConsumerRecipe: map['isConsumerRecipe'] ?? false,
      label: map['label'] ?? "",
      brand: map['brand'] ?? "",
      notes: map['notes'] ?? "",
      updated: map['updated'] ?? "",
      lastModifiedBy: map['lastModifiedBy'] ?? "",
      dietaryPreference: List<dynamic>.from((map['dietaryPreference'] ?? [])),
      season: List<dynamic>.from((map['season'] ?? [])),
      course: List<dynamic>.from((map['course'] ?? [])),
      cuisine: List<dynamic>.from((map['cuisine'] ?? [])),
      instructions: List<Instruction>.from((map['instructions'] ?? []).map<Instruction>((x) => Instruction.fromMap(x as Map<String,dynamic>),),),
      matchedInstructions: List<MatchedInstruction>.from((map['matchedInstructions'] ?? []).map<MatchedInstruction>((x) => MatchedInstruction.fromMap(x as Map<String,dynamic>),),),
      media: List<Media>.from((map['media'] ?? []).map<Media>((x) => Media.fromMap(x as Map<String,dynamic>),),),
      isAuthenticatedUserFavorite: map['isAuthenticatedUserFavorite'] ?? false,
      shortDescription: map['shortDescription'] ?? "",
      domains: List<dynamic>.from((map['domains'] ?? [])),
      affiliateBrands: List<dynamic>.from((map['affiliateBrands'] ?? [])),
    );
  }

  factory Result.asEmpty(){
    return Result(
      metaId: "",
      metaName: "",
      status: "",
      recipeId: "",
      mediaId: "",
      recipeEnvironment: "",
      isPublic: false,
      isCookbook: false,
      isScanToCook: false,
      isCommunityPublic: false,
      isConsumerRecipe: false,
      label: "",
      brand: "",
      notes: "",
      updated: "",
      lastModifiedBy: "",
      dietaryPreference: [],
      season: [],
      course: [],
      cuisine: [],
      instructions: [],
      matchedInstructions: [],
      media: [],
      isAuthenticatedUserFavorite: false,
      shortDescription: "",
      domains: [],
      affiliateBrands: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source) as Map<String, dynamic>);


  @override
  String toString() {
    return 'Result(metaId: $metaId, metaName: $metaName, status: $status, recipeId: $recipeId, mediaId: $mediaId, recipeEnvironment: $recipeEnvironment, isPublic: $isPublic, isCookbook: $isCookbook, isScanToCook: $isScanToCook, isCommunityPublic: $isCommunityPublic, isConsumerRecipe: $isConsumerRecipe, label: $label, brand: $brand, notes: $notes, updated: $updated, lastModifiedBy: $lastModifiedBy, dietaryPreference: $dietaryPreference, season: $season, course: $course, cuisine: $cuisine, instructions: $instructions, matchedInstructions: $matchedInstructions, media: $media, isAuthenticatedUserFavorite: $isAuthenticatedUserFavorite, shortDescription: $shortDescription, domains: $domains)';
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is Result &&
      other.metaId == metaId &&
      other.metaName == metaName &&
      other.status == status &&
      other.recipeId == recipeId &&
      other.mediaId == mediaId &&
      other.recipeEnvironment == recipeEnvironment &&
      other.isPublic == isPublic &&
      other.isCookbook == isCookbook &&
      other.isScanToCook == isScanToCook &&
      other.isCommunityPublic == isCommunityPublic &&
      other.isConsumerRecipe == isConsumerRecipe &&
      other.label == label &&
      other.brand == brand &&
      other.notes == notes &&
      other.updated == updated &&
      other.lastModifiedBy == lastModifiedBy &&
      listEquals(other.dietaryPreference, dietaryPreference) &&
      listEquals(other.season, season) &&
      listEquals(other.course, course) &&
      listEquals(other.cuisine, cuisine) &&
      listEquals(other.instructions, instructions) &&
      listEquals(other.matchedInstructions, matchedInstructions) &&
      listEquals(other.media, media) &&
      other.isAuthenticatedUserFavorite == isAuthenticatedUserFavorite &&
      other.shortDescription == shortDescription &&
      listEquals(other.domains, domains);
      
  }

}

class Instruction {
  final String id;
  final ReadyInMins readyInMins;
  final List<dynamic> requiredCapabilities;
  final int requiredCapabilitiesMinimumMatches;
  Instruction({
    required this.id,
    required this.readyInMins,
    required this.requiredCapabilities,
    required this.requiredCapabilitiesMinimumMatches,
  });

  Instruction copyWith({
    String? id,
    ReadyInMins? readyInMins,
    List<dynamic>? requiredCapabilities,
    int? requiredCapabilitiesMinimumMatches,
  }) {
    return Instruction(
      id: id ?? this.id,
      readyInMins: readyInMins ?? this.readyInMins,
      requiredCapabilities: requiredCapabilities ?? this.requiredCapabilities,
      requiredCapabilitiesMinimumMatches: requiredCapabilitiesMinimumMatches ?? this.requiredCapabilitiesMinimumMatches,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'readyInMins': readyInMins.toMap(),
      'requiredCapabilities': requiredCapabilities,
      'requiredCapabilitiesMinimumMatches': requiredCapabilitiesMinimumMatches,
    };
  }

  factory Instruction.fromMap(Map<String, dynamic> map) {
    return Instruction(
      id: map['id'] ?? "",
      readyInMins: ReadyInMins.fromMap(map['readyInMins'] ?? ReadyInMins.asEmpty()),
      requiredCapabilities: List<dynamic>.from((map['requiredCapabilities'] ?? [])),
      requiredCapabilitiesMinimumMatches: map['requiredCapabilitiesMinimumMatches'].toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());


  factory Instruction.asEmpty(){
    return Instruction(
      id: "",
      readyInMins: ReadyInMins.asEmpty(),
      requiredCapabilities: [],
      requiredCapabilitiesMinimumMatches: 0,
    );
  }

  factory Instruction.fromJson(String source) => Instruction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Instruction(id: $id, readyInMins: $readyInMins, requiredCapabilities: $requiredCapabilities, requiredCapabilitiesMinimumMatches: $requiredCapabilitiesMinimumMatches)';
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is Instruction &&
      other.id == id &&
      other.readyInMins == readyInMins &&
      listEquals(other.requiredCapabilities, requiredCapabilities) &&
      other.requiredCapabilitiesMinimumMatches == requiredCapabilitiesMinimumMatches;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      readyInMins.hashCode ^
      requiredCapabilities.hashCode ^
      requiredCapabilitiesMinimumMatches.hashCode;
  }
}

class ReadyInMins {
  final String gte;
  final String lte;
  ReadyInMins({
    required this.gte,
    required this.lte,
  });

  ReadyInMins copyWith({
    String? gte,
    String? lte,
  }) {
    return ReadyInMins(
      gte: gte ?? this.gte,
      lte: lte ?? this.lte,
    );
  }

  factory ReadyInMins.asEmpty() {
    return ReadyInMins(
      gte: "",
      lte: "",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gte': gte,
      'lte': lte,
    };
  }

  factory ReadyInMins.fromMap(Map<String, dynamic> map) {
    return ReadyInMins(
      gte: map['gte'] ?? "",
      lte: map['lte'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ReadyInMins.fromJson(String source) => ReadyInMins.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReadyInMins(gte: $gte, lte: $lte)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReadyInMins &&
      other.gte == gte &&
      other.lte == lte;
  }

  @override
  int get hashCode => gte.hashCode ^ lte.hashCode;
}

class MatchedInstruction {
  final String instructionId;
  final RecipeReadyInMins recipeReadyInMins;
  final List<dynamic> requiredCapabilities;
  final int requiredCapabilitiesMinimumMatches;
  final List<MatchedDeviceProfile> matchedDeviceProfiles;
  MatchedInstruction({
    required this.instructionId,
    required this.recipeReadyInMins,
    required this.requiredCapabilities,
    required this.requiredCapabilitiesMinimumMatches,
    required this.matchedDeviceProfiles,
  });
  
  factory MatchedInstruction.asEmpty(){
    return MatchedInstruction(
      instructionId: '',
      recipeReadyInMins: RecipeReadyInMins.asEmpty(),
      requiredCapabilities: [],
      requiredCapabilitiesMinimumMatches: 0,
      matchedDeviceProfiles: [],
    );
  }

  MatchedInstruction copyWith({
    String? instructionId,
    RecipeReadyInMins? recipeReadyInMins,
    List<dynamic>? requiredCapabilities,
    int? requiredCapabilitiesMinimumMatches,
    List<MatchedDeviceProfile>? matchedDeviceProfiles,
  }) {
    return MatchedInstruction(
      instructionId: instructionId ?? this.instructionId,
      recipeReadyInMins: recipeReadyInMins ?? this.recipeReadyInMins,
      requiredCapabilities: requiredCapabilities ?? this.requiredCapabilities,
      requiredCapabilitiesMinimumMatches: requiredCapabilitiesMinimumMatches ?? this.requiredCapabilitiesMinimumMatches,
      matchedDeviceProfiles: matchedDeviceProfiles ?? this.matchedDeviceProfiles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'instructionId': instructionId,
      'recipeReadyInMins': recipeReadyInMins.toMap(),
      'requiredCapabilities': requiredCapabilities,
      'requiredCapabilitiesMinimumMatches': requiredCapabilitiesMinimumMatches,
      'matchedDeviceProfiles': matchedDeviceProfiles.map((x) => x.toMap()).toList(),
    };
  }

  factory MatchedInstruction.fromMap(Map<String, dynamic> map) {
    return MatchedInstruction(
      instructionId: map['instructionId'] ?? "",
      recipeReadyInMins: RecipeReadyInMins.fromMap(map['recipeReadyInMins'] ?? []),
      requiredCapabilities: List<dynamic>.from((map['requiredCapabilities'] ?? [])),
      requiredCapabilitiesMinimumMatches: map['requiredCapabilitiesMinimumMatches'].toInt() ?? 0,
      matchedDeviceProfiles: List<MatchedDeviceProfile>.from((map['matchedDeviceProfiles'] as List<dynamic>).map<MatchedDeviceProfile>((x) => MatchedDeviceProfile.fromMap(x ?? ""),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchedInstruction.fromJson(String source) => MatchedInstruction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MatchedInstruction(instructionId: $instructionId, recipeReadyInMins: $recipeReadyInMins, requiredCapabilities: $requiredCapabilities, requiredCapabilitiesMinimumMatches: $requiredCapabilitiesMinimumMatches, matchedDeviceProfiles: $matchedDeviceProfiles)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is MatchedInstruction &&
      other.instructionId == instructionId &&
      other.recipeReadyInMins == recipeReadyInMins &&
      listEquals(other.requiredCapabilities, requiredCapabilities) &&
      other.requiredCapabilitiesMinimumMatches == requiredCapabilitiesMinimumMatches &&
      listEquals(other.matchedDeviceProfiles, matchedDeviceProfiles);
  }



  @override
  int get hashCode {
    return instructionId.hashCode ^
      recipeReadyInMins.hashCode ^
      requiredCapabilities.hashCode ^
      requiredCapabilitiesMinimumMatches.hashCode ^
      matchedDeviceProfiles.hashCode;
  }
}

class RecipeReadyInMins {
  final String gte;
  final String lte;
  RecipeReadyInMins({
    required this.gte,
    required this.lte,
  });

  RecipeReadyInMins copyWith({
    String? gte,
    String? lte,
  }) {
    return RecipeReadyInMins(
      gte: gte ?? this.gte,
      lte: lte ?? this.lte,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gte': gte,
      'lte': lte,
    };
  }

  factory RecipeReadyInMins.fromMap(Map<String, dynamic> map) {
    return RecipeReadyInMins(
      gte: map['gte'] ?? "",
      lte: map['lte'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeReadyInMins.fromJson(String source) => RecipeReadyInMins.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RecipeReadyInMins(gte: $gte, lte: $lte)';

  factory RecipeReadyInMins.asEmpty(){
    return RecipeReadyInMins(
      gte: '',
      lte: '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RecipeReadyInMins &&
      other.gte == gte &&
      other.lte == lte;
  }

  @override
  int get hashCode => gte.hashCode ^ lte.hashCode;
}

class MatchedDeviceProfile {
  final String profileId;
  final String applianceId;
  final String applianceType;
  final String applianceJid;
  final String applianceNickname;
  final String cavity;
  final List<dynamic> recipeCapabilities;
  MatchedDeviceProfile({
    required this.profileId,
    required this.applianceId,
    required this.applianceType,
    required this.applianceJid,
    required this.applianceNickname,
    required this.cavity,
    required this.recipeCapabilities,
  });

  MatchedDeviceProfile copyWith({
    String? profileId,
    String? applianceId,
    String? applianceType,
    String? applianceJid,
    String? applianceNickname,
    String? cavity,
    List<dynamic>? recipeCapabilities,
  }) {
    return MatchedDeviceProfile(
      profileId: profileId ?? this.profileId,
      applianceId: applianceId ?? this.applianceId,
      applianceType: applianceType ?? this.applianceType,
      applianceJid: applianceJid ?? this.applianceJid,
      applianceNickname: applianceNickname ?? this.applianceNickname,
      cavity: cavity ?? this.cavity,
      recipeCapabilities: recipeCapabilities ?? this.recipeCapabilities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profileId': profileId,
      'applianceId': applianceId,
      'applianceType': applianceType,
      'applianceJid': applianceJid,
      'applianceNickname': applianceNickname,
      'cavity': cavity,
      'recipeCapabilities': recipeCapabilities,
    };
  }

  factory MatchedDeviceProfile.asEmpty(){
    return MatchedDeviceProfile(
      profileId: '',
      applianceId: '',
      applianceType: '',
      applianceJid: '',
      applianceNickname: '',
      cavity: '',
      recipeCapabilities: [],
    );
  }

  factory MatchedDeviceProfile.fromMap(Map<String, dynamic> map) {
    return MatchedDeviceProfile(
      profileId: map['profileId'] ?? "",
      applianceId: map['applianceId'] ?? "",
      applianceType: map['applianceType'] ?? "",
      applianceJid: map['applianceJid'] ?? "",
      applianceNickname: map['applianceNickname'] ?? "",
      cavity: map['cavity'] ?? "",
      recipeCapabilities: List<dynamic>.from((map['recipeCapabilities'] ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchedDeviceProfile.fromJson(String source) => MatchedDeviceProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MatchedDeviceProfile(profileId: $profileId, applianceId: $applianceId, applianceType: $applianceType, applianceJid: $applianceJid, applianceNickname: $applianceNickname, cavity: $cavity, recipeCapabilities: $recipeCapabilities)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is MatchedDeviceProfile &&
      other.profileId == profileId &&
      other.applianceId == applianceId &&
      other.applianceType == applianceType &&
      other.applianceJid == applianceJid &&
      other.applianceNickname == applianceNickname &&
      other.cavity == cavity &&
      listEquals(other.recipeCapabilities, recipeCapabilities);
  }

  @override
  int get hashCode {
    return profileId.hashCode ^
      applianceId.hashCode ^
      applianceType.hashCode ^
      applianceJid.hashCode ^
      applianceNickname.hashCode ^
      cavity.hashCode ^
      recipeCapabilities.hashCode;
  }
}

class Media {
  final String id;
  final String type;
  final String mimetype;
  final List<MediaSize> sizes;
  Media({
    required this.id,
    required this.type,
    required this.mimetype,
    required this.sizes,
  });

  Media copyWith({
    String? id,
    String? type,
    String? mimetype,
    List<MediaSize>? sizes,
  }) {
    return Media(
      id: id ?? this.id,
      type: type ?? this.type,
      mimetype: mimetype ?? this.mimetype,
      sizes: sizes ?? this.sizes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'mimetype': mimetype,
      'sizes': sizes.map((x) => x.toMap()).toList(),
    };
  }

  factory Media.asEmpty(){
    return Media(
      id: '',
      type: '',
      mimetype: '',
      sizes: [],
    );
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map['id'] ?? "",
      type: map['type'] ?? "",
      mimetype: map['mimetype'] ?? "",
      sizes: List<MediaSize>.from((map['sizes'] as List<dynamic>).map<MediaSize>((x) => MediaSize.fromMap(x ?? ""),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Media(id: $id, type: $type, mimetype: $mimetype, sizes: $sizes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return other is Media &&
      other.id == id &&
      other.type == type &&
      other.mimetype == mimetype &&
      listEquals(other.sizes, sizes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      type.hashCode ^
      mimetype.hashCode ^
      sizes.hashCode;
  }
}

class MediaSize {
  final String id;
  final String widthPixels;
  final String heightPixels;
  final String mediaUrl;
  final String? mediaSha256;
  final String internalMediaUrl;
  MediaSize({
    required this.id,
    required this.widthPixels,
    required this.heightPixels,
    required this.mediaUrl,
    required this.mediaSha256,
    required this.internalMediaUrl,
  });


  factory MediaSize.toEmpty(){
    return MediaSize(
      id: '',
      widthPixels: '',
      heightPixels: '',
      mediaUrl: '',
      mediaSha256: '',
      internalMediaUrl: '',
    );
  }



  MediaSize copyWith({
    String? id,
    String? widthPixels,
    String? heightPixels,
    String? mediaUrl,
    String? mediaSha256,
    String? internalMediaUrl,
  }) {
    return MediaSize(
      id: id ?? this.id,
      widthPixels: widthPixels ?? this.widthPixels,
      heightPixels: heightPixels ?? this.heightPixels,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaSha256: mediaSha256 ?? this.mediaSha256,
      internalMediaUrl: internalMediaUrl ?? this.internalMediaUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'widthPixels': widthPixels,
      'heightPixels': heightPixels,
      'mediaUrl': mediaUrl,
      'mediaSha256': mediaSha256,
      'internalMediaUrl': internalMediaUrl,
    };
  }

  factory MediaSize.fromMap(Map<String, dynamic> map) {
    return MediaSize(
      id: map['id'] ?? "",
      widthPixels: map['widthPixels'] ?? "",
      heightPixels: map['heightPixels'] ?? "",
      mediaUrl: map['mediaUrl'] ?? "",
      mediaSha256: map['mediaSha256'] ?? "",
      internalMediaUrl: map['internalMediaUrl'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaSize.fromJson(String source) => MediaSize.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Size(id: $id, widthPixels: $widthPixels, heightPixels: $heightPixels, mediaUrl: $mediaUrl, mediaSha256: $mediaSha256, internalMediaUrl: $internalMediaUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MediaSize &&
      other.id == id &&
      other.widthPixels == widthPixels &&
      other.heightPixels == heightPixels &&
      other.mediaUrl == mediaUrl &&
      other.mediaSha256 == mediaSha256 &&
      other.internalMediaUrl == internalMediaUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      widthPixels.hashCode ^
      heightPixels.hashCode ^
      mediaUrl.hashCode ^
      mediaSha256.hashCode ^
      internalMediaUrl.hashCode;
  }
}