part of 'recipe_steps_cubit.dart';

@immutable
abstract class RecipeStepsState {}

class RecipeStepsInitial extends RecipeStepsState {}

class RecipeStepsReset extends RecipeStepsState {}

//Execution ID & Data Stored in State
class ExecutionIDLoaded extends RecipeStepsState {
  final ExecutionIDResponse response;
  ExecutionIDLoaded(this.response);
}

class ControlStep extends RecipeStepsState {
  final Recipe recipe;
  final List<Steps> steps;
  final int currentStep;
  final String? executionId;
  final String userId;
  final bool isAuto;
  final bool isArthur;
  final int? returnedRoute;
  final List<IngredientObjects>? updatedIngredients;
  ControlStep({required this.recipe, required this.steps, required this.currentStep, this.executionId, required this.userId, required this.isAuto, required this.isArthur, required this.returnedRoute, this.updatedIngredients});

  ControlStep copyWith({Recipe? recipe, List<Steps>? steps, int? currentStep, String? executionId, String? userId, bool? isAuto, bool? isArthur, int? returnedRoute, List<IngredientObjects>? updatedIngredients}) {
    return ControlStep(
      recipe: recipe ?? this.recipe,
      steps: steps ?? this.steps,
      currentStep: currentStep ?? this.currentStep,
      executionId: executionId ?? this.executionId,
      userId: userId ?? this.userId,
      isAuto: isAuto ?? this.isAuto,
      isArthur: isArthur ?? this.isArthur,
      returnedRoute: returnedRoute,
      updatedIngredients: updatedIngredients ?? this.updatedIngredients,
    );
  }

}