import 'package:smarthq_flutter_module/models/execution_control_request.dart';
import 'package:smarthq_flutter_module/models/execution_control_response.dart';
import 'package:smarthq_flutter_module/models/execution_id_request.dart';
import 'package:smarthq_flutter_module/models/execution_id_response.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_request.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_response.dart';
import 'package:smarthq_flutter_module/models/recipe_capabilities_response.dart';
import 'package:smarthq_flutter_module/models/recipe_execution.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/provider/rest_api_recipe_provider.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

abstract class RecipeRepository {
  Future<RecipeCapabilitiesResponse> getRecipeCapabilities();
  Future<DiscoverRecipeResponse> requestDiscoverRecipe({required DiscoverRecipeRequest request});
  Future<RecipeResponse> getRecipe({required String recipeId});
  Future<ExecutionIDResponse> getExecutionID({required ExecutionIDRequest request});
  Future<ExecutionControlResponse> getExecutionControl({required ExecutionControlRequest request});
  Future<ExecutionResponse> getExecution({required String executionId});
}

class RecipeRepositoryImpl implements RecipeRepository {
  Future<RecipeCapabilitiesResponse> getRecipeCapabilities() async {
    var response = await RestApiClientRecipeProvider().requestRecipeCapabilities();
    geaLog.debug('RecipeCapabilitiesResponse: $response');
    return response;
  }

  @override
  Future<DiscoverRecipeResponse> requestDiscoverRecipe({
    required DiscoverRecipeRequest request,
    
  }) {
    return RestApiClientRecipeProvider().requestDiscoverRecipe(request: request);
  }

  @override
  Future<RecipeResponse> getRecipe({required String recipeId}) {
    return RestApiClientRecipeProvider().requestRecipe(recipeId);
  }
   @override
  Future<ExecutionIDResponse> getExecutionID({required ExecutionIDRequest request}) {
    return RestApiClientRecipeProvider().requestExecutionID(request: request);
  }

  @override
  Future<ExecutionControlResponse> getExecutionControl({required ExecutionControlRequest request}) {
    return RestApiClientRecipeProvider().requestExecutionControl(request: request);
  }
  
  @override
  Future<ExecutionResponse> getExecution({required String executionId}) {
    return RestApiClientRecipeProvider().requestExecution(executionId);
  }


}
