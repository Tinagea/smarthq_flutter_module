import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/cubits/recipe_steps_cubit.dart';
import 'package:smarthq_flutter_module/managers/error_manager.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/models/recipe_capabilities_response.dart';
import 'package:smarthq_flutter_module/models/recipe_profile.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_request.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_response.dart';
import 'package:smarthq_flutter_module/resources/repositories/recipe_repository.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository _recipeRepository;
  RecipeCubit(this._recipeRepository) : super(RecipeInitial());

  Future<RecipeCapabilitiesResponse?> getRecipeCapabilities(bool isGuided, BuildContext context) async {
    RecipeCapabilitiesResponse? response;
    try {
      response = await _recipeRepository.getRecipeCapabilities();
      emit(CapabilitiesLoaded(response));
      geaLog.debug('RecipeCapabilitiesResponse: $response');
    } on RestApiResponseError catch (e) {
      RecipeErrorManager().handleError(e.reason, context);
    } catch (e) {
      geaLog.debug("RecipeCapabilitesResponse Error: ${e.toString()}");      
    }
    return response;
  }

  Future<DiscoverRecipeResponse?> getDiscoverRecipes(bool isAuto, bool isArthur, String searchQuery, List<String>? domains, BuildContext context) async {
    RecipeCapabilitiesResponse? response;
    try {
      response = await _recipeRepository.getRecipeCapabilities();
      emit(CapabilitiesLoaded(response));
      geaLog.debug('RecipeCapabilitiesResponse: $response');
    } on RestApiResponseError catch (e) {
      RecipeErrorManager().handleError(e.reason, context);
    } catch (e) {
      geaLog.debug("RecipeCapabilitesResponse Error: ${e.toString()}");      
    }

    List<Profile> profiles = [];
    response!.profiles?.forEach((element) {
      profiles.add(Profile.fromMap(element));
    });
    DiscoverRecipeResponse? recipe = await getDiscoverRecipe(
        request: DiscoverRecipeRequest(
          kind: "recipe#search",
          userId: response.userId!,
          affiliateBrands: isArthur ? RecipeAffiliateBrands.kingArthur : null,
          domains: domains,
          supportedDeviceProfiles: profiles,
          searchQuery: searchQuery
        ), context: context);
    return recipe;
  }
  
  List<String> determineDomains(ApplianceType applianceType, bool isAuto) {
    if(applianceType == ApplianceType.STAND_MIXER){
      if(isAuto){
        return RecipeDomains.StandMixerAutoSense;
      } else {
        return RecipeDomains.StandMixerGuided;
      }
    } else {
      switch (applianceType){
        case ApplianceType.TOASTER_OVEN:
          return RecipeDomains.SpeedcookGuided;
        default:
         return [''];
      }
    }
  }

  Future<DiscoverRecipeResponse?> getDiscoverRecipe({required DiscoverRecipeRequest request, required BuildContext context}) async {
    DiscoverRecipeResponse? response;
    try {
      geaLog.debug('RecipeRequest: ${request.toString()}');
      response = await _recipeRepository.requestDiscoverRecipe(request: request);
      emit(DiscoverRecipeLoaded(response));
      geaLog.debug('RecipeResponse: $response');
    } on RestApiResponseError catch (e) {
      RecipeErrorManager().handleError(e.reason, context);
    } catch (e) {
      geaLog.debug("DiscoverRecipeResponse Error: ${e.toString()}");      
    }
    return response;
  }

  Future<Recipe?> getRecipe({required String recipeId, required BuildContext context}) async {
    RecipeResponse response;
    Recipe? recipe;
    try {
      response = await _recipeRepository.getRecipe(recipeId: recipeId);
      recipe = response.recipe;
      emit(RecipeLoaded(recipe!));
      geaLog.debug('RecipeResponse: $response');
    } on RestApiResponseError catch (e) {
      RecipeErrorManager().handleError(e.reason, context);
    } catch (e) {
      geaLog.debug("DiscoverRecipeResponse Error: ${e.toString()}");      
    }
    return recipe;
  }

  Recipe? getRecipeFromState() {
    if (state is RecipeLoaded) {
      return (state as RecipeLoaded).recipe;
    }
    return null;
  }

  void resetState() {
    emit(RecipeInitial());
    // _recipeRepository
  }

 void clearAllRecipes() {
  geaLog.debug("CLEAR ALL RECIPES");
    emit(RecipeCleared());
    // _recipeRepository
  }

  Future<void> closePageIfApplianceWasSwitched(BuildContext context, String page) async{
    if (state is RecipeCleared){
      geaLog.debug("$page UPDATED: RECIPE CLEARED");
      resetState();
      Future.delayed(Duration.zero, ()
      {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    }
  }

}
