import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/recipe_cubit.dart';
import 'package:smarthq_flutter_module/cubits/recipe_steps_cubit.dart';
import 'package:smarthq_flutter_module/models/execution_id_response.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/models/recipe_details_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/utils/recipe_measurement_conversion_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

class RecipeDetailsStateDefaultValue {
  String userPreferenceSelection = "";
  String userServingSizeSelection = "";
  String placeholderTitle = "...";

  String userServingSizeId = "one-serving";
  String? userPreferenceId;
  late String optionConfigId;
  List<IngredientObjects> updatedIngredientList = [];

  late Color increaseButtonColor;
  late Color decreaseButtonColor;
  late Color inactiveButtonColor;
  late Color activeButtonColor;

  String optionConfigQuantity= "cups-1";

  bool showCheatSheet = false;
  bool hasPreferences = false;
  bool isInitialLoad = true;
  bool isScrolled = false;
}
class RecipeDetailsCubit extends Cubit<RecipeDetailsState> {
  late int _seedValue;
  String currentRoute = Routes.RECIPE_DICOVER_PAGE;


  RecipeDetailsCubit() : super(RecipeDetailsState(seedValue: -1)){
    geaLog.debug("RecipeDetailsCubit init");
    _seedValue = 0;
  }

  RecipeDetailContentModel? _getContentModel(){
    return RecipeDetailContentModel(
      userPreferenceSelection: state.contentModel == null ? SelectableValues() : state.contentModel!.userPreferenceSelection,
      userServingSizeSelection: state.contentModel == null ? SelectableValues() : state.contentModel!.userServingSizeSelection,
      placeholderTitle: state.contentModel == null ? "" : state.contentModel!.placeholderTitle,
      userServingSizeId: state.contentModel == null ? "" : state.contentModel!.userServingSizeId,
      userPreferenceId: state.contentModel == null ? "" : state.contentModel!.userPreferenceId,
      optionConfigId: state.contentModel == null ? "" : state.contentModel!.optionConfigId,
      updatedIngredientList: state.contentModel == null ? [] : state.contentModel!.updatedIngredientList,
      increaseButtonColor: state.contentModel == null ? Colors.white : state.contentModel!.increaseButtonColor,
      decreaseButtonColor: state.contentModel == null ? Colors.white : state.contentModel!.decreaseButtonColor,
      inactiveButtonColor: state.contentModel == null ? Colors.white : state.contentModel!.inactiveButtonColor,
      activeButtonColor: state.contentModel == null ? Colors.white : state.contentModel!.activeButtonColor,
      optionConfigQuantity: state.contentModel == null ? "" : state.contentModel!.optionConfigQuantity,
      showCheatSheet: state.contentModel == null ? false : state.contentModel!.showCheatSheet,
      hasPreferences: state.contentModel == null ? false : state.contentModel!.hasPreferences,
      isInitialLoad: state.contentModel == null ? true : state.contentModel!.isInitialLoad,
      isScrolled: state.contentModel == null ? false : state.contentModel!.isScrolled,
    );
  }

  RecipeDetailContentModel? setStateContentModel({required RecipeDetailContentModel? model,
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
    bool? isScrolled
  }){
    if (model == null) {
      return null;
    }
    return RecipeDetailContentModel(
      userPreferenceSelection: userPreferenceSelection ?? model.userPreferenceSelection,
      userServingSizeSelection: userServingSizeSelection ?? model.userServingSizeSelection,
      placeholderTitle: placeholderTitle ?? model.placeholderTitle,
      userServingSizeId: userServingSizeId ?? model.userServingSizeId,
      userPreferenceId: userPreferenceId ?? model.userPreferenceId,
      optionConfigId: optionConfigId ?? model.optionConfigId,
      updatedIngredientList: updatedIngredientList ?? model.updatedIngredientList,
      increaseButtonColor: increaseButtonColor ?? model.increaseButtonColor,
      decreaseButtonColor: decreaseButtonColor ?? model.decreaseButtonColor,
      inactiveButtonColor: inactiveButtonColor ?? model.inactiveButtonColor,
      activeButtonColor: activeButtonColor ?? model.activeButtonColor,
      optionConfigQuantity: optionConfigQuantity ?? model.optionConfigQuantity,
      showCheatSheet: showCheatSheet ?? model.showCheatSheet,
      hasPreferences: hasPreferences ?? model.hasPreferences,
      isInitialLoad: isInitialLoad ?? model.isInitialLoad,
      startedToProgressToNextPage: startedToProgressToNextPage ?? model.startedToProgressToNextPage,
      isScrolled: isScrolled ?? model.isScrolled,
    );
  }

  void clearStateButKeepDiscoveryData(){
    bool _isArthur = state.isArthur ?? false;
    List<String>? _domains = state.domains;
    emit(RecipeDetailsState(isArthur: _isArthur, domains: _domains));
  }

  void clearState(){
    emit(RecipeDetailsState());
  }

  void setScrolled(bool isScrolled) {
    RecipeDetailContentModel? model = setStateContentModel(model: state.contentModel, isScrolled: isScrolled);
    emit(state.copyWith(seedValue: _seedValue, contentModel: model));
  }

  String formatQuantityString(IngredientObjects ingredient) {
    String quantityString = "";

    List<String> lteList = ingredient.foodMeasure!.valueRange!.lte.toString().split('.');
    List<String> gteList = ingredient.foodMeasure!.valueRange!.gte.toString().split('.');

    bool isIdenticalLists = listEquals(lteList, gteList);
    String fraction = "";
    switch(lteList[1]){
      case "5":
        fraction = "½";
        break;
      case "25":
        fraction = "¼";
        break;
      case "0625":
        fraction = "1/16";
        break;
      case "125":
        fraction = "⅛";
        break;
      case "333":
        fraction = "⅓";
        break;
      case "666":
        fraction = "⅔";
        break;
      case "75":
        fraction = "¾";
        break;
      default:
        break;
    }
    if (isIdenticalLists) {
      quantityString = "${lteList[0] != "0" ? lteList[0] : ""}$fraction";
    } else {
      quantityString = "${lteList[0] != "0" ? lteList[0] : ""}$fraction-${gteList[0]}$fraction}";
    }

    if (ingredient.foodMeasure!.valueRange != null && ingredient.foodMeasure!.weightUnit != null) {
      quantityString = quantityString + " ${RecipeMeasurementConversions().getFormattedMeasurement(ingredient.foodMeasure!.weightUnit ?? "")}";
    } else if (ingredient.foodMeasure!.valueRange != null && ingredient.foodMeasure!.volumeUnit != null) {
      quantityString = quantityString + " ${RecipeMeasurementConversions().getFormattedMeasurement(ingredient.foodMeasure!.volumeUnit ?? "")}";
    } else if (ingredient.foodMeasure!.type == "FoodCount" && ingredient.foodMeasure!.size != null) {
      quantityString = quantityString + " ${RecipeMeasurementConversions().getFormattedMeasurement(ingredient.foodMeasure!.size ?? "")}";
    }
    return quantityString;
  }

  bool checkCurrentPreferenceSelection(Recipe recipe, int index, RecipeDetailContentModel? model) {
    if (recipe.menuTreeInstructions![0].selectableOptions != null &&
        recipe.menuTreeInstructions![0].selectableOptions!.length >= 2) {
      return recipe.menuTreeInstructions!.first.selectableOptions!.firstWhere((element) => element.type == "Preferences").selectableValues![index].consistency == model!.userPreferenceSelection!.consistency;
    } else {
      return false;
    }
  }

  List<Steps> getStepsList(Recipe data, String option, String serving, RecipeDetailContentModel model) {
    List<Steps> recipes = [];
    geaLog.debug("getStepsList option: $option, serving: $serving, userServings: ${model.userServingSizeSelection}");
    OptionTree? optionTree = data.menuTreeInstructions![0].optionTree?.firstWhere((element) => element.optionValue?.description == model.userServingSizeSelection?.description);
    if(model.userPreferenceSelection!.type == null){
      List<String> stepsInOrderRef = optionTree!.config!.steps!;
      for(int i = 0; i < stepsInOrderRef.length; i++){
        data.steps!.forEach((element) {
          if(element.id == stepsInOrderRef[i]){
            recipes.add(element);
          }
        });
      }
      try {
        model = setStateContentModel(model: model,
            userPreferenceSelection: data.menuTreeInstructions![0].selectableOptions?.firstWhere((element) => element.type?.toLowerCase() == "preferences").selectableValues?.first)!;
      } catch (e) {
        geaLog.debug("error : ${e.toString()}");
        model = setStateContentModel(model: model, userPreferenceSelection: SelectableValues())!;
      }
    }
    if(model.userPreferenceSelection!.type != null){
      List<String> stepsInOrderRef = optionTree!.options?.firstWhere((element) => element.optionValue?.description?.toLowerCase() == model.userPreferenceSelection!.description?.toLowerCase()).config?.steps ?? [];
      for(int i = 0; i < stepsInOrderRef.length; i++){
        data.steps!.forEach((element) {
          if(element.id == stepsInOrderRef[i]){
            recipes.add(element);
          }
        });
      }
    }
    if (recipes.length == 0 && data.steps!.length > 0){
      recipes = data.steps!;
    }
    return recipes;
  }

  String formatOptionConfigID(BuildContext context, RecipeDetailContentModel model)  {
    String optionConfigId = "";
    SelectableValues? optionConfigPref = model.userPreferenceSelection;
    SelectableValues configQuantity = model.userServingSizeSelection!;

    bool _determineOptionTree(OptionTree element){
      return element.optionValue?.valueRange?.gte == configQuantity.valueRange?.gte && element.optionValue?.valueRange?.lte == configQuantity.valueRange?.lte;
    }

    OptionTree optionTree = state.recipe!.menuTreeInstructions?.first.optionTree?.firstWhere((element) => _determineOptionTree(element)) ?? OptionTree();

    if(optionTree.options == null || optionTree.options!.isEmpty){
      optionConfigId = optionTree.config!.optionConfigId!;
    } else {
      optionConfigId = optionTree.options!.firstWhere((element) => element.optionValue?.consistency == optionConfigPref?.consistency).config!.optionConfigId!;
    }

    geaLog.debug("optionConfigId: ${model.optionConfigId}");
    return optionConfigId;

  }



  Future<ExecutionIDResponse?> getExecutionID(BuildContext context, RecipeDetailContentModel model, String userId, String recipeId, String instructionID, String applianceString) async {
    String optionConfigId = formatOptionConfigID(context, model);
    model = setStateContentModel(model: model, optionConfigId: optionConfigId)!;
    ExecutionIDResponse? response;
    response = await BlocProvider.of<RecipeStepsCubit>(context).getExecutionID(optionConfigId, userId, recipeId, instructionID, context, applianceString);
    geaLog.debug("EXECUTION RESPONSE: ${response.toString()}");
    return response ?? ExecutionIDResponse.toEmpty();
  }

  Future<Recipe> loadRecipeData(BuildContext context, String recipeId) async {
    final recipeCubit = BlocProvider.of<RecipeCubit>(context);
    geaLog.debug("recipeID at main page is: $recipeId");
    Recipe? recipe = await recipeCubit.getRecipe(recipeId: recipeId, context: context);
    RecipeDetailContentModel model = _getContentModel()!;
    if (recipe!.menuTreeInstructions![0].selectableOptions!.length > 1) {
      model = setStateContentModel(model: model,
          userPreferenceSelection: recipe.menuTreeInstructions![0].selectableOptions![1].selectableValues![0],
          userPreferenceId: recipe.menuTreeInstructions![0].selectableOptions![1].selectableValues![0].consistency!.toLowerCase())!;
      recipe.menuTreeInstructions![0].selectableOptions!.forEach((element) {
        if(element.type?.toLowerCase() == "preferences"){
          model = setStateContentModel(model: model,
            userPreferenceSelection: element.selectableValues![0],
            hasPreferences: true,
            userPreferenceId: recipe.menuTreeInstructions![0].selectableOptions![1].selectableValues![0].consistency!.toLowerCase(),
          )!;
        }
      });
    } else {
      model = setStateContentModel(model: model,
          userPreferenceSelection: SelectableValues(),
          userPreferenceId: "")!;
    }

    model = setStateContentModel(model: model,
      userServingSizeSelection: recipe.menuTreeInstructions![0].selectableOptions![0].selectableValues![0],
      placeholderTitle: recipe.label.toString(),
      isInitialLoad: false,
      startedToProgressToNextPage: false,
    )!;

    emit(state.copyWith(
        recipe: recipe,
        seedValue: _seedValue + 1,
        contentModel: model,
        state: RecipeDetailState.loaded
    ));
    return recipe;
  }

  Future<void> pushPreferencesAndProgressToNextPage(Recipe _recipe, RecipeDetailContentModel model, BuildContext context, String userId, bool isAuto, bool isArthur, String applianceString, Function setStepData, {int stepIndex = 0}) async {
    if(!model.startedToProgressToNextPage!){
      model = setStateContentModel(model: model, startedToProgressToNextPage: true)!;
      _recipe.steps = getStepsList(_recipe,model.userPreferenceId ?? "", model.userServingSizeSelection!.description!, model);
      List<bool>? indexTracker = List.filled(_recipe.steps!.length, false);
      if(stepIndex == 0){
        await setStepData(_recipe, userId, isAuto, isArthur, model.updatedIngredientList!,context, model, applianceString);
      } else {
        for(int i = 0; i < _recipe.steps!.length; i++){
          if(i < stepIndex + 1){
            indexTracker[i] = true;
          }
        }
      }
      String route = BlocProvider.of<RecipeStepsCubit>(context).returnRoutedArchetype(stepIndex, _recipe);
      Navigator.of(context).pushNamed(route, arguments: RecipeArchetypeArguments(_recipe, stepIndex, indexTracker)).then((value) {
        model = setStateContentModel(model: model, startedToProgressToNextPage: false)!;
      });
    }
  }

  void setIsAuto(bool isAuto) {
    emit(state.copyWith(isAuto: isAuto));
  }

  String intToNumberString(String number){
    String numberString = "";
    switch (number) {
      case "1":
        numberString = "one";
        break;
      case "2":
        numberString = "two";
        break;
      case "3":
        numberString = "three";
        break;
      case "4":
        numberString = "four";
        break;
      case "5":
        numberString = "five";
        break;
      case "6":
        numberString = "six";
        break;
      case "7":
        numberString = "seven";
        break;
      case "8":
        numberString = "eight";
        break;
      case "9":
        numberString = "nine";
        break;
      case "10":
        numberString = "ten";
        break;
      default:
        numberString = "";
        break;
    }
    return numberString;
  }

  void setArthur(bool arthur){
    emit(state.copyWith(isArthur: arthur));
  }

  void setDomains(List<String>? domains, BuildContext context){
    emit(state.copyWith(domains: domains));
  }

}