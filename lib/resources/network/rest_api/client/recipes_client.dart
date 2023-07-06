import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_request.dart';
import 'package:smarthq_flutter_module/models/execution_control_request.dart';
import 'package:smarthq_flutter_module/models/execution_control_response.dart';
import 'package:smarthq_flutter_module/models/execution_id_request.dart';
import 'package:smarthq_flutter_module/models/execution_id_response.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/models/discover_recipe_response.dart';
import 'package:smarthq_flutter_module/models/recipe_capabilities_response.dart';
import 'package:smarthq_flutter_module/models/recipe_execution.dart';
import '../profile/rest_api_profile.dart' as rest_api_profile;

part 'recipes_client.g.dart';

@RestApi(baseUrl: "")
abstract class RecipeClient {
  factory RecipeClient(Dio dio, {String baseUrl}) = _RecipeClient;

  @GET(rest_api_profile.CloudApiUri.recipe)
  Future<RecipeCapabilitiesResponse> getRecipeCapabilities(
    @Path("applianceId") String applianceId);

  @POST(rest_api_profile.CloudApiUri.discoverRecipeSearch)
  Future<DiscoverRecipeResponse> requestDiscoverRecipe(
      @Body() DiscoverRecipeRequest request,
      );

  @GET(rest_api_profile.CloudApiUri.fetchRecipe)
  Future<RecipeResponse> getRecipe(@Path("recipeId") String recipeId);

  @POST(rest_api_profile.CloudApiUri.executionID)
  Future<ExecutionIDResponse> getExecutionID(
      {
      @Path("applianceId") required String applianceId,
      @Path("recipeId") required String recipeId,
      @Body() required ExecutionIDRequest data});
    

  @POST(rest_api_profile.CloudApiUri.executionControl)
  Future<ExecutionControlResponse> getExecutionControl(
        {
        @Path("executionId") required String executionId,
        @Body() required ExecutionControlRequest data});

  @GET(rest_api_profile.CloudApiUri.executionControl)
  Future<ExecutionResponse> getExecution(@Path("executionId") String executionId);
  
  }
