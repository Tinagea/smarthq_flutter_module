import 'package:equatable/equatable.dart';

class NativeState extends Equatable {
  final int? seedValue;
  final bool? isTopBarShown;
  final bool? isBottomBarShown;
  final String? returnedRoute; 

  NativeState({
    this.seedValue,
    this.isTopBarShown,
    this.isBottomBarShown,
    this.returnedRoute,
  });

  @override
  List<Object?> get props => [
    seedValue,
    isTopBarShown,
    isBottomBarShown,
    returnedRoute,
  ];

  @override
  String toString() => "RoutingState {"
      "seedValue: $seedValue\n"
      "isTopBarShown: $isTopBarShown\n"
      "isBottomBarShown: $isBottomBarShown\n"
      "returnedRoute: $returnedRoute\n"
      "}";

  NativeState copyWith({
    int? seedValue,
    bool? isTopBarShown,
    bool? isBottomBarShown,
    String? returnedRoute,
  }) {
    return NativeState(
        seedValue: seedValue ?? this.seedValue,
        isTopBarShown: isTopBarShown ?? this.isTopBarShown,
        isBottomBarShown: isBottomBarShown ?? this.isBottomBarShown,
        returnedRoute: returnedRoute);
  }
}