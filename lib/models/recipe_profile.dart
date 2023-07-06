import 'dart:convert';

class Profile {
  final String profileId;
  final String applianceId;
  final String applianceType;
  final String applianceJid;
  final String applianceNickname;
  final String cavity;
  List<String> recipeCapabilities;
  Profile({
    required this.profileId,
    required this.applianceId,
    required this.applianceType,
    required this.applianceJid,
    required this.applianceNickname,
    required this.recipeCapabilities,
    required this.cavity,
  });

  Profile copyWith({
    String? profileId,
    String? applianceId,
    String? applianceType,
    String? applianceJid,
    String? applianceNickname,
    List<String>? recipeCapabilities,
    String? cavity,
  }) {
    return Profile(
      profileId: profileId ?? this.profileId,
      applianceId: applianceId ?? this.applianceId,
      applianceType: applianceType ?? this.applianceType,
      applianceJid: applianceJid ?? this.applianceJid,
      applianceNickname: applianceNickname ?? this.applianceNickname,
      recipeCapabilities: recipeCapabilities ?? this.recipeCapabilities,
      cavity: cavity ?? this.cavity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileId': profileId,
      'applianceId': applianceId,
      'applianceType': applianceType,
      'applianceJid': applianceJid,
      'applianceNickname': applianceNickname,
      'recipeCapabilities': recipeCapabilities,
      'cavity': cavity,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      profileId: map['profileId'] ?? '',
      applianceId: map['applianceId'] ?? '',
      applianceType: map['applianceType'] ?? '',
      applianceJid: map['applianceJid'] ?? '',
      applianceNickname: map['applianceNickname'] ?? '',
      recipeCapabilities: List<String>.from(map['recipeCapabilities']),
      cavity: map['cavity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['profileId'] = this.profileId;
    data['applianceId'] = this.applianceId;
    data['applianceType'] = this.applianceType;
    data['applianceJid'] = this.applianceJid;
    data['applianceNickname'] = this.applianceNickname;
    data['recipeCapabilities'] = this.recipeCapabilities;
    data['cavity'] = this.cavity;
    return data;
  }
  
  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'profileId: $profileId, applianceId: $applianceId, applianceType: $applianceType, applianceJid: $applianceJid, applianceNickname: $applianceNickname, recipeCapabilities: $recipeCapabilities' + ', cavity: $cavity';
  }
}
