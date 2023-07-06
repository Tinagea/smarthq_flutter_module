import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:smarthq_flutter_module/models/recipe_profile.dart';

class DiscoverRecipeRequest {
  final String kind;
  final String userId;
  final List<String>? domains;
  final List<Profile>? supportedDeviceProfiles;
  final String? searchQuery;
  final List<String>? affiliateBrands;
  final bool sendStepNotification;

  DiscoverRecipeRequest({
    required this.kind,
    required this.userId,
    this.domains,
    required this.supportedDeviceProfiles,
    this.searchQuery,
    this.affiliateBrands,
    this.sendStepNotification = false,
  });

  DiscoverRecipeRequest copyWith({
    String? kind,
    String? userId,
    List<String>? domains,
    List<Profile>? supportedDeviceProfiles,
    String? searchQuery,
    List<String>? affiliateBrands,
    bool? sendStepNotification,
  }) {
    return DiscoverRecipeRequest(
      kind: kind ?? this.kind,
      userId: userId ?? this.userId,
      domains: domains ?? this.domains,
      supportedDeviceProfiles: supportedDeviceProfiles ?? this.supportedDeviceProfiles,
      searchQuery: searchQuery ?? this.searchQuery,
      affiliateBrands: affiliateBrands ?? this.affiliateBrands,
      sendStepNotification: sendStepNotification ?? this.sendStepNotification,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'kind': kind,
      'userId': userId,
      'domains': domains,
      'supportedDeviceProfiles': supportedDeviceProfiles!.map((x) => x.toMap()).toList(),
      'searchQuery': searchQuery,
      'affiliateBrands': affiliateBrands,
      'sendStepNotification': sendStepNotification,
    };
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    data['userId'] = this.userId;
    data['domains'] = this.domains;
        if (this.supportedDeviceProfiles != null) {
      data['supportedDeviceProfiles'] =
          this.supportedDeviceProfiles!.map((v) => v.toJson()).toList();
    }
    data['searchQuery'] = this.searchQuery;
    data['affiliateBrands'] = this.affiliateBrands;
    data['sendStepNotification'] = this.sendStepNotification;
    return data;
  }

  factory DiscoverRecipeRequest.fromMap(Map<String, dynamic> map) {
    return DiscoverRecipeRequest(
      kind: map['kind'] ?? '',
      userId: map['userId'] ?? '',
      domains: List<String>.from(map['domains']),
      supportedDeviceProfiles: List<Profile>.from(map['supportedDeviceProfiles']?.map((x) => Profile.fromMap(x))),
      searchQuery: map['searchQuery'] ?? '',
      affiliateBrands: List<String>.from(map['affiliateBrands']),
      sendStepNotification: map['sendStepNotification'] ?? false,
    );
  }

  factory DiscoverRecipeRequest.fromJson(String source) => DiscoverRecipeRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RecipeRequest(kind: $kind, userId: $userId, domains: $domains, searchQuery: $searchQuery, supportedDeviceProfiles: $supportedDeviceProfiles, affiliateBrands $affiliateBrands)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is DiscoverRecipeRequest &&
        other.kind == kind &&
        other.userId == userId &&
        listEquals(other.domains, domains) &&
        listEquals(other.supportedDeviceProfiles, supportedDeviceProfiles) &&
        other.searchQuery == searchQuery &&
        other.affiliateBrands == affiliateBrands &&
        other.sendStepNotification == sendStepNotification;
  }

  @override
  int get hashCode {
    return kind.hashCode ^ userId.hashCode ^ domains.hashCode ^ supportedDeviceProfiles.hashCode ^ searchQuery.hashCode ^ affiliateBrands.hashCode;
  }
}