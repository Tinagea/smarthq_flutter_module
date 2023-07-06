import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:smarthq_flutter_module/managers/error_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/managers/managers.dart';
import 'package:smarthq_flutter_module/models/execution_control_request.dart';
import 'package:smarthq_flutter_module/models/execution_control_response.dart';
import 'package:smarthq_flutter_module/models/execution_id_request.dart';
import 'package:smarthq_flutter_module/models/execution_id_response.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/models/recipe_execution.dart';
import 'package:smarthq_flutter_module/resources/erd/0x5300.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';
import 'package:smarthq_flutter_module/resources/erd/toaster_oven/0x9209.dart';
import 'package:smarthq_flutter_module/resources/repositories/recipe_repository.dart';
import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9300.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9305.dart';
import 'package:smarthq_flutter_module/resources/repositories/appliance_service_repository.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/rest_api_error.dart';

part 'recipe_steps_state.dart';

enum StepType {
  finish,
  noStep,
  cook,
  manual,
  manualMeasure,
  prep,
  
}
enum StepMode {
  noMode,
  bake,
  mixerMix,
  convectionBake, 
  convectionRoast,
  broil, 
  broilWithTime, 
  warm,
  proof,
  toast,
  airFry,
  cake, 
  cookieWarmUp,
  cookieFreshGooey, 
  cookieFreshNormal, 
  cookieFreshCrunchy, 
  cookieFrozenGooey, 
  cookieFrozenNormal,
  cookieFrozenCrunchy,
  reheat,
  roast, 
  warmWithTemp
}

class RecipeStepsCubit extends Cubit<RecipeStepsState> {
  final RecipeRepository _recipeRepository;
  final ApplianceServiceRepository _applianceServiceRepository;
  final NativeStorage _nativeStorage;
  final SharedDataManager _sharedDataManager;

  RecipeStepsCubit(this._recipeRepository, this._applianceServiceRepository, this._nativeStorage, this._sharedDataManager) : super(RecipeStepsInitial());


  Future <void> storeSteps(Recipe recipe, String? executionId, String userId, bool isAuto, bool isArthur, List<IngredientObjects> updatedIngredients, ApplianceType applianceType) async {
    if(applianceType == ApplianceType.TOASTER_OVEN){
      _sharedDataManager.setStringValue(SharedDataKey.recipeExecutionId, executionId);
    }
    emit(ControlStep(recipe: recipe, steps: recipe.steps ?? [], currentStep: 0, executionId: executionId, userId: userId, isAuto: isAuto, isArthur: isArthur, returnedRoute: null, updatedIngredients: updatedIngredients));
  }

  Future<void> advanceCloudIndex(int stepIndex, BuildContext context, String applianceString, {bool isFinishedOrQuit = false}) async {
  String applianceId = _nativeStorage.selectedAppliance ?? "";
    ExecutionControlRequest executionControlRequest = ExecutionControlRequest(
      kind: "recipe#controlExecution",
      userId: (state as ControlStep).userId,
      applianceType: applianceString,
      executionId: (state as ControlStep).executionId!,
      status: isFinishedOrQuit? "idle":"running",
      stepIndex: stepIndex,
      applianceId: applianceId.split('_')[0].toUpperCase(),
    );
    if(isFinishedOrQuit){
      if(((state as ControlStep).executionId == null || (state as ControlStep).executionId!.isEmpty)) {
        return;
      }
      clearState();
    } else {
     if(((state as ControlStep).executionId == null || (state as ControlStep).executionId!.isEmpty)){
        RecipeErrorManager().handleError("recipe execution not found", context);
        return;
      } else {
       emit((state as ControlStep).copyWith(currentStep: stepIndex));
      }
    }
      getExecutionControl(executionControlRequest, context);
  }

  Future<ExecutionIDResponse?> getExecutionID(String optionConfigId, String userId, String recipeId, String instructionID, BuildContext context, String applianceString) async {
    String applianceId = _nativeStorage.selectedAppliance ?? "";
    ExecutionIDRequest request = ExecutionIDRequest(
      kind: "recipe#runRecipe",
      userId: userId,
      applianceType: applianceString,
      recipeId: recipeId,
      instruction: instructionID,
      selectedOptionConfigId: optionConfigId,
      applianceId: applianceId.split('_')[0].toUpperCase(),
    );
    ExecutionIDResponse? response;
    LoadingDialog _loadingDialog = LoadingDialog();
    _loadingDialog.show(ContextUtil.instance.routingContext!, "Fetching Recipe...");
    try {
      response = await _recipeRepository.getExecutionID(request: request);
    }  on RestApiResponseError catch (e) {
      _loadingDialog.close(ContextUtil.instance.routingContext!);
      geaLog.debug("WE HAVE CAUGHT AN ERROR");
      RecipeErrorManager().handleError(e.reason, context);
    } catch (e) {
      geaLog.debug("ExecutionIDResponse Error: ${e.toString()}");
    }
    _loadingDialog.close(ContextUtil.instance.routingContext!);
    return response;
  }

  Future<ExecutionControlResponse?> getExecutionControl(ExecutionControlRequest request, BuildContext context) async {
    ExecutionControlResponse? response;
    try {
      response = await _recipeRepository.getExecutionControl(request: request);
      geaLog.debug('ExecutionControlResponse: $response');
    } on RestApiResponseError catch (e) {
      RecipeErrorManager().handleError(e.reason, context);
    } catch (e) {
      geaLog.debug("ExecutionIDResponse Error: ${e.toString()}");      
    }
    return response;
  }

  Future<ExecutionResponse?> getExecution(String executionId, BuildContext context) async {
    ExecutionResponse? response;
    try {
      response = await _recipeRepository.getExecution(executionId: executionId);
      geaLog.debug('ExecutionGetResponse: $response');
    } on RestApiResponseError catch (e) {
      if(executionId != "" && e.statusCode == 404){
        _sharedDataManager.setStringValue(SharedDataKey.recipeExecutionId, null);
      } else {
        RecipeErrorManager().handleError(e.message, context);
      }
    }
    return response;
  }


  advanceToNextStepArchetype(BuildContext context, int stepIndex, Recipe recipe, List<bool> indexTracker, {bool replace = true}) {
    stepIndex+=1;
    String route = returnRoutedArchetype(stepIndex, recipe);
    emit((state as ControlStep).copyWith(currentStep: stepIndex));
    if(replace){
      Navigator.of(context).pushReplacementNamed(route, arguments: RecipeArchetypeArguments(recipe, stepIndex, indexTracker,));
    } else {
      Navigator.of(context).pushNamed(route, arguments: RecipeArchetypeArguments(recipe, stepIndex, indexTracker,));
    }
  }
  
  bool isSpeedcookCook(StepMode stepMode){
    switch(stepMode){
      case StepMode.bake :
      case StepMode.convectionRoast :
      case StepMode.broil :
      case StepMode.broilWithTime :
      case StepMode.warm :
      case StepMode.proof :
      case StepMode.toast :
      case StepMode.airFry :
      case StepMode.cake :
      case StepMode.cookieWarmUp :
      case StepMode.cookieFreshGooey :
      case StepMode.cookieFreshNormal :
      case StepMode.cookieFreshCrunchy :
      case StepMode.cookieFrozenGooey :
      case StepMode.cookieFrozenNormal:
      case StepMode.cookieFrozenCrunchy :
      case StepMode.reheat :
      case StepMode.roast :
      case StepMode.warmWithTemp : {
        return true;
    }
      default: {
        return false;
      }
    }
  }
  
  String returnRoutedArchetype(int i, Recipe r){
    StepType nextStepType = StepType.noStep;
    StepMode nextStepMode = StepMode.noMode;
    if(i == r.steps!.length){
      nextStepType = StepType.finish;
    } else {
      nextStepType = ParseStepType.fromString(r.steps![i].type);
      nextStepMode = ParseStepMode.fromString(r.steps![i].mode);
    }
    switch(nextStepType){
      case StepType.cook :
        if(isSpeedcookCook(nextStepMode)){
          return Routes.RECIPE_OVEN_ARCHETYPE;
        } else if(nextStepMode == StepMode.mixerMix){
          return Routes.RECIPE_MIXING_ARCHETYPE;
        } else {
          return Routes.RECIPE_ADD_INGREDIENT_ARCHETYPE;
        }
      case StepType.manual:
      case StepType.manualMeasure:
      case StepType.prep: {
        return Routes.RECIPE_ADD_INGREDIENT_ARCHETYPE;
    }
      case StepType.finish : {
        return Routes.RECIPE_FINISH_ARCHETYPE;
      }
      default : 
        return StepType.noStep.toString();
    }
  }
  
  Future<MixerState?> getStandMixerState() async {
    String? jid = getJid() ?? "";
    if(jid.isEmpty) return null;
    String erdValue =_applianceServiceRepository.getErdValue(jid, ERD.STAND_MIXER_STATE) ?? "";
    ERD0x9305 standMixerState = ERD0x9305(erdValue);
    return standMixerState.getMixerState();
  }

    Future<MixerMode> getStandMixerMode() async {
    String? jid = getJid() ?? "";
    if(jid.isEmpty) return MixerMode.MIXER_OFF;
    String erdValue =_applianceServiceRepository.getErdValue(jid, ERD.STAND_MIXER_MODE_STATE) ?? "";
    ERD0x9300 standMixerState = ERD0x9300(erdValue);
    return standMixerState.mode;
  }

  Future<bool> isApplianceInRemoteEnabled() async {
    MixerMode mode = await getStandMixerMode();
    return mode == MixerMode.MIXER_REMOTE_MODE;
  }

  List<bool> getUpdatedIndexTracker(Recipe recipe, int stepIndex, {bool resetBake = false}){
    List<bool> indexTracker = List.filled(recipe.steps!.length, false);
    int _increment = 1;
    if(resetBake){
      _increment = 0;
    }
    //make all the index's up to the current index true
    for(int i = 0; i < stepIndex + _increment; i++){
      indexTracker[i] = true;
    }
    return indexTracker;
  }

  Future<bool> isApplianceIdleAndNeedsToBeNavigatedOut(bool hasNavigated, BuildContext context, int stepIndex,  List<bool> indexTracker, ApplianceType applianceType, ToasterOvenCurrentState? toasterOvenCurrentState) async{
    // ignore: missing_enum_constant_in_switch
    switch(applianceType) {
      case ApplianceType.TOASTER_OVEN : {
        if(toasterOvenCurrentState == ToasterOvenCurrentState.TOASTER_OVEN_IDLE) {
          advanceToNextStepArchetype(context,stepIndex,(state as ControlStep).recipe,indexTracker);
          return true;
        }
        break;
      }
      case ApplianceType.STAND_MIXER : {
        MixerState? mixerState = await getStandMixerState();
        if(mixerState == MixerState.MIXER_IDLE && !hasNavigated) {
          advanceToNextStepArchetype(context,stepIndex,(state as ControlStep).recipe,indexTracker);
          return true;
        }
        break;
      }
      case ApplianceType.WATER_HEATER:
      case ApplianceType.LAUNDRY_DRYER:
      case ApplianceType.LAUNDRY_WASHER:
      case ApplianceType.REFRIGERATOR:
      case ApplianceType.MICROWAVE:
      case ApplianceType.ADVANTIUM:
      case ApplianceType.DISHWASHER:
      case ApplianceType.DISH_DRAWER:
      case ApplianceType.OVEN:
      case ApplianceType.ELECTRIC_RANGE:
      case ApplianceType.GAS_RANGE:
      case ApplianceType.AIR_CONDITIONER:
      case ApplianceType.ELECTRIC_COOKTOP:
      case ApplianceType.PIZZA_OVEN:
      case ApplianceType.GAS_COOKTOP:
      case ApplianceType.SPLIT_AIR_CONDITIONER:
      case ApplianceType.HOOD:
      case ApplianceType.POE_WATER_FILTER:
      case ApplianceType.COOKTOP_STANDALONE:
      case ApplianceType.DELIVERY_BOX:
      case ApplianceType.ZONELINE:
      case ApplianceType.WATER_SOFTENER:
      case ApplianceType.PORTABLE_AIR_CONDITIONER:
      case ApplianceType.COMBINATION_WASHER_DRYER:
      case ApplianceType.DUAL_ZONE_WINE_CHILLER:
      case ApplianceType.BEVERAGE_CENTER:
      case ApplianceType.COFFEE_BREWER:
      case ApplianceType.OPAL_ICE_MAKER:
      case ApplianceType.IN_HOME_GROWER:
      case ApplianceType.DEHUMIDIFIER:
      case ApplianceType.UNDER_COUNTER_ICE_MAKER:
      case ApplianceType.BUILT_IN_AC:
      case ApplianceType.ESPRESSO_COFFEE_MAKER:
      case ApplianceType.GRIND_BREW:
      case ApplianceType.GATEWAY:
      case ApplianceType.UNDEFINED:
      case ApplianceType.APPL:
        //added to suppress warning for unaccounted for appliance types in switch case
        break;
    }
    return false;
  }

  clearState(){
    emit(RecipeStepsReset());
  }

  Future<void> clearScale() async {
    _applianceServiceRepository.postErd(getJid() ?? "", ERD.STAND_MIXER_SCALE_DISPLAY_ENABLE, "00");
  }

  Future<void> pauseTimer() async {
    _applianceServiceRepository.postErd(getJid() ?? "", ERD.STAND_MIXER_PAUSE_MIXING_CYCLE, "01");
  }

  void setCache(String jid) {
    _applianceServiceRepository.getCache(jid);
  }

  Future<int> currentActiveStep() async {
    String? jid = getJid() ?? "";
    if(jid.isEmpty) return 0;
    Map<String,String> cache = _applianceServiceRepository.formatCache(_applianceServiceRepository.getCache(jid));
    String erdValue = cache[ERD.RECIPE_STATUS] ?? "";
    ERD0x5300 erd  = ERD0x5300(erdValue);
    return erd.currentCookStepIndex;
  }

  Future<ERD0x5300?> get5300() async {
    String? jid = getJid();
    if(jid == null) return ERD0x5300("");
    Map<String,String> cache = _applianceServiceRepository.formatCache(_applianceServiceRepository.getCache(jid));
    String? erdValue = cache[ERD.RECIPE_STATUS];
    if(erdValue == null) return null;
    return ERD0x5300(erdValue);
  }


  Future<void> checkForActiveRecipes(BuildContext context, ApplianceType applianceType) async {
    String? uId = _nativeStorage.userId;
    ERD0x5300? erd = await get5300();
    String executionId = "";
    int? currentStepIndex;

    switch (applianceType) {
      case ApplianceType.TOASTER_OVEN:
        String? storedExecutionId = await _sharedDataManager.getStringValue(SharedDataKey.recipeExecutionId);
        geaLog.debug("STORED EXECUTION: $storedExecutionId");
        if(storedExecutionId == null){
          geaLog.debug("NO ACTIVE RECIPES");
          return;
          }
          executionId = storedExecutionId;
        try{
          ExecutionResponse? _response = await getExecution(executionId, context);
          currentStepIndex = _response?.execution.currentStepIndex;
          geaLog.debug("response STEP INDEX: $currentStepIndex");
        } on RestApiResponseError catch (e) {
          if(e.statusCode == 404){
           _sharedDataManager.setStringValue(SharedDataKey.recipeExecutionId, null);
          }
        }        
        break;
      case ApplianceType.STAND_MIXER:
        if(erd == null) return;
        executionId = erd.recipeExecutionId;
        currentStepIndex = erd.currentCookStepIndex;
        geaLog.debug("erdValue STEP INDEX: ${erd.currentCookStepIndex}");
        break;
      default:
    }

    if (executionId.isNotEmpty && int.tryParse(executionId) != 0) {
      ExecutionResponse? response = await _recipeRepository.getExecution(
          executionId: executionId);
      String recipeId = response.execution.recipeId;
      RecipeResponse? recipeResponse = await _recipeRepository.getRecipe(
          recipeId: recipeId);
      Recipe recipe = recipeResponse.recipe!;
      bool isAuto = recipe.domains!.contains(RecipeDomains.StandMixerAutoSenseString);
      bool isArthur = recipe.affiliateBrands!.contains(RecipeAffiliateBrands.kingArthurString);
      await storeSteps(
          recipe, executionId, uId ?? "", isAuto,
          isArthur, 
          recipe.ingredientObjects!,
          applianceType
          );
      List<bool> indexTracker = List.filled(recipe.steps!.length, false); 
      //make all the index's up to the current index true
      for (int i = 0; i < currentStepIndex!; i++) {
      indexTracker[i] = true;
      }
      emit((state as ControlStep).copyWith(
          returnedRoute: currentStepIndex, 
          currentStep: currentStepIndex
      ));
    }
  }
  
  Future<int> checkRecipeStepWithout5300(BuildContext context) async {
    int? currentStepIndex;
    String? storedExecutionId = await _sharedDataManager.getStringValue(SharedDataKey.recipeExecutionId);
    geaLog.debug("STORED EXECUTION: $storedExecutionId");
    if(storedExecutionId == null){
      geaLog.debug("NO ACTIVE RECIPES");
      return 0;
    }
    try{
      ExecutionResponse? _response = await getExecution(storedExecutionId, context);
      currentStepIndex = _response?.execution.currentStepIndex;
      geaLog.debug("response STEP INDEX: $currentStepIndex");
    } on RestApiResponseError catch (e) {
      if(e.statusCode == 404){
        _sharedDataManager.setStringValue(SharedDataKey.recipeExecutionId, null);
      }
    }
    return currentStepIndex ?? 0;
  }

  void setReturnedRouteFromState(){
    emit((state as ControlStep).copyWith(returnedRoute: (state as ControlStep).currentStep));
  }

  String? getJid() {
    if(_nativeStorage.selectedAppliance == null || _nativeStorage.userId == null) return null;
    return ("${_nativeStorage.selectedAppliance?.split("_")[0].toUpperCase()}_${_nativeStorage.userId}").toLowerCase();
  }
  
  void clearRecipeExecutionId(){
    _sharedDataManager.setStringValue(SharedDataKey.recipeExecutionId, null);
  }
  
}

extension ParseStepType on StepType {
  static StepType fromString(String? value) {
    geaLog.debug("StepType: $value");
    if (value == null) {
      return StepType.noStep;
    }
    switch (value) {
      case "finish":
        return StepType.finish;
      case "cook":
        return StepType.cook;
      case "manual":
        return StepType.manual;
      case "manualMeasure":
        return StepType.manualMeasure;
      case "prep":
        return StepType.prep;
      default:
        return StepType.noStep;
    }
  }
}


extension ParseStepMode on StepMode {
  static StepMode fromString(String? value) {
    geaLog.debug("StepMode: $value");
    if (value == null) {
      return StepMode.noMode;
    } else if (value == "bake") {
      return StepMode.bake;
    } else if (value == 'mixer-mix') {
      return StepMode.mixerMix;
    } else if (value == 'convection-bake'){
      return StepMode.convectionBake;
    } else if (value == 'convection-roast'){
      return StepMode.convectionRoast;
    } else if (value == 'broil'){
      return StepMode.broil;
    } else if (value == 'broil-with-time'){
      return StepMode.broilWithTime;
    } else if (value == 'warm'){
      return StepMode.warm;
    } else if (value == 'proof'){
      return StepMode.proof;
    } else if (value == 'toast'){
      return StepMode.toast;
    } else if (value == 'air-fry'){
      return StepMode.airFry;
    } else if (value == 'cake'){
      return StepMode.cake;
    } else if (value == 'cookie-warm-up'){
      return StepMode.cookieWarmUp;
    } else if (value == 'cookie-fresh-gooey'){
      return StepMode.cookieFreshGooey;
    } else if (value == 'cookie-fresh-normal'){
      return StepMode.cookieFreshNormal;
    } else if (value == 'cookie-fresh-crunchy'){
      return StepMode.cookieFreshCrunchy;
    } else if (value == 'cookie-frozen-gooey'){
      return StepMode.cookieFrozenGooey;
    } else if (value == 'cookie-frozen-normal'){
      return StepMode.cookieFrozenNormal;
    } else if (value == 'cookie-frozen-crunchy'){
      return StepMode.cookieFrozenCrunchy;
    } else if (value == 'reheat'){
      return StepMode.reheat;
    } else if (value == 'roast'){
      return StepMode.roast;
    } else if (value == 'warm-with-temp'){
      return StepMode.warmWithTemp;
    }
    return StepMode.noMode;
  }
}

class RecipeDomains {
  static const String StandMixerKey = 'mixer';
  static const String SpeedcookKey = 'speedcook';
  
  static const String StandMixerAutoSenseString = 'mixer.autoSense';
  static const String StandMixerGuidedString = 'mixer.guided';
  static const String SpeedcookGuidedString = 'speedcook.guided';

  static const List<String> StandMixerAutoSense = ['mixer.autosense'];
  static const List<String> StandMixerGuided = ['mixer.guided'];
  static const List<String> SpeedcookGuided = ['speedcook.guided'];
}

class RecipeAffiliateBrands {
  static final String kingArthurString = 'kingarthur';
  static final List<String> kingArthur = ['kingarthur'];
}

class RecipeRoutingStrings {
  static const String Archetypes = "archetypes";
}

class ApplianceStrings {
  static const String StandMixer = "Stand Mixer";
  static const String ToasterOven = "Toaster Oven";
}
