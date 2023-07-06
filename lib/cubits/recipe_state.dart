part of 'recipe_cubit.dart';

@immutable
abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeCleared extends RecipeState {}
class RecipeLoaded extends RecipeState {
  final Recipe recipe;

  RecipeLoaded(this.recipe);
}

class DiscoverRecipeLoaded extends RecipeState {
  final DiscoverRecipeResponse recipeCapabilitiesResponse;

  DiscoverRecipeLoaded(this.recipeCapabilitiesResponse);
}

class CapabilitiesLoaded extends RecipeState {
  final RecipeCapabilitiesResponse recipeCapabilitiesResponse;

  CapabilitiesLoaded(this.recipeCapabilitiesResponse);
}

