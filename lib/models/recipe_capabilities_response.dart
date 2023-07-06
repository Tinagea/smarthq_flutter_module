import 'dart:convert';


class RecipeCapabilitiesResponse {
  String? kind;
  String? userId;
  List<dynamic>? profiles;
  List<dynamic>? domains;

  RecipeCapabilitiesResponse({
    this.kind,
    this.userId,
    this.profiles,
    this.domains
  });

  factory RecipeCapabilitiesResponse.fromJson(Map<String, dynamic> source) => RecipeCapabilitiesResponse.fromMap(json.decode(jsonEncode(source)));
  
  factory RecipeCapabilitiesResponse.fromMap(Map<String, dynamic> json) => RecipeCapabilitiesResponse(
    kind: json['kind'],
    userId: json['userId'],
    profiles: json['profiles'],
    domains: json['domains'],
  );

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'userId': userId,
    'profiles': profiles,
    'domains': domains,
  };
}
