import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';

class RecipeDetailContentModel extends Equatable {
  final SelectableValues? userPreferenceSelection;
  final SelectableValues? userServingSizeSelection;
  final String? placeholderTitle;

  final String? userServingSizeId;
  final String? userPreferenceId;
  final String? optionConfigId;
  final List<IngredientObjects>? updatedIngredientList;

  final Color? increaseButtonColor;
  final Color? decreaseButtonColor;
  final Color? inactiveButtonColor;
  final Color? activeButtonColor;

  final String? optionConfigQuantity;

  final bool? showCheatSheet;
  final bool? hasPreferences;
  final bool? isInitialLoad;
  final bool? startedToProgressToNextPage;
  final bool? isScrolled;


  RecipeDetailContentModel({
    this.userPreferenceSelection,
    this.userServingSizeSelection,
    this.placeholderTitle,
    this.userServingSizeId,
    this.userPreferenceId,
    this.optionConfigId,
    this.updatedIngredientList,
    this.increaseButtonColor,
    this.decreaseButtonColor,
    this.inactiveButtonColor,
    this.activeButtonColor,
    this.optionConfigQuantity,
    this.showCheatSheet,
    this.hasPreferences,
    this.isInitialLoad,
    this.startedToProgressToNextPage,
    this.isScrolled,
  });
  
  @override
  List<Object?> get props => [
    userPreferenceSelection,
    userServingSizeSelection,
    placeholderTitle,
    userServingSizeId,
    userPreferenceId,
    optionConfigId,
    updatedIngredientList,
    increaseButtonColor,
    decreaseButtonColor,
    inactiveButtonColor,
    activeButtonColor,
    optionConfigQuantity,
    showCheatSheet,
    hasPreferences,
    isInitialLoad,
    startedToProgressToNextPage,
    isScrolled,
  ];

  RecipeDetailContentModel copyWith({
    SelectableValues? userPreferenceSelection,
    SelectableValues? userServingSizeSelection,
    String? placeholderTitle,
    String? userServingSizeId,
    String? userPreferenceId,
    String? optionConfigId,
    List<IngredientObjects>? updatedIngredientList,
    Color? increaseButtonColor,
    Color? decreaseButtonColor,
    Color? inactiveButtonColor,
    Color? activeButtonColor,
    String? optionConfigQuantity,
    bool? showCheatSheet,
    bool? hasPreferences,
    bool? isInitialLoad,
    bool? startedToProgressToNextPage,
    bool? isScrolled,
  }) {
    return RecipeDetailContentModel(
      userPreferenceSelection: userPreferenceSelection ?? this.userPreferenceSelection,
      userServingSizeSelection: userServingSizeSelection ?? this.userServingSizeSelection,
      placeholderTitle: placeholderTitle ?? this.placeholderTitle,
      userServingSizeId: userServingSizeId ?? this.userServingSizeId,
      userPreferenceId: userPreferenceId ?? this.userPreferenceId,
      optionConfigId: optionConfigId ?? this.optionConfigId,
      updatedIngredientList: updatedIngredientList ?? this.updatedIngredientList,
      increaseButtonColor: increaseButtonColor ?? this.increaseButtonColor,
      decreaseButtonColor: decreaseButtonColor ?? this.decreaseButtonColor,
      inactiveButtonColor: inactiveButtonColor ?? this.inactiveButtonColor,
      activeButtonColor: activeButtonColor ?? this.activeButtonColor,
      optionConfigQuantity: optionConfigQuantity ?? this.optionConfigQuantity,
      showCheatSheet: showCheatSheet ?? this.showCheatSheet,
      hasPreferences: hasPreferences ?? this.hasPreferences,
      isInitialLoad: isInitialLoad ?? this.isInitialLoad,
      startedToProgressToNextPage: startedToProgressToNextPage ?? this.startedToProgressToNextPage,
      isScrolled: isScrolled ?? this.isScrolled,
    );
  }

  @override
  String toString() {
    return 'RecipeDetailContentModel{userPreferenceSelection: $userPreferenceSelection, userServingSizeSelection: $userServingSizeSelection, placeholderTitle: $placeholderTitle, userServingSizeId: $userServingSizeId, userPreferenceId: $userPreferenceId, optionConfigId: $optionConfigId, updatedIngredientList: $updatedIngredientList, increaseButtonColor: $increaseButtonColor, decreaseButtonColor: $decreaseButtonColor, inactiveButtonColor: $inactiveButtonColor, activeButtonColor: $activeButtonColor, optionConfigQuantity: $optionConfigQuantity, showCheatSheet: $showCheatSheet, hasPreferences: $hasPreferences, isInitialLoad: $isInitialLoad}';
  }
}

  enum RecipeDetailState {
    initial,
    loading,
    loaded,
    error
  }
  
class RecipeDetailsState extends Equatable {
  final int? seedValue;
  final RecipeDetailState? state;
  final RecipeDetailContentModel? contentModel;
  final Recipe? recipe;
  final bool? isAuto;
  final bool? isArthur;
  final List<String>? domains;

  RecipeDetailsState( {
    this.seedValue,
    this.state,
    this.contentModel,
    this.recipe,
    this.isAuto,
    this.isArthur,
    this.domains
  });

  @override
  List<Object?> get props => [
    seedValue,
    state,
    contentModel,
    recipe,
    isAuto,
    isArthur,
    domains
  ];

  RecipeDetailsState copyWith({
    int? seedValue,
    RecipeDetailState? state,
    RecipeDetailContentModel? contentModel,
    Recipe? recipe,
    bool? isAuto,
    bool? isArthur,
    List<String>? domains
  }){
    return RecipeDetailsState(
      seedValue: seedValue ?? this.seedValue,
      state: state ?? this.state,
      contentModel: contentModel ?? this.contentModel,
      recipe: recipe ?? this.recipe,
      isAuto: isAuto ?? this.isAuto,
      isArthur: isArthur ?? this.isArthur,
      domains: domains ?? this.domains
    );
  }
}

