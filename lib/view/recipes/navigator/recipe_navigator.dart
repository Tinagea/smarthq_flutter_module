/* * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved. */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/models/recipe_details_model.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/common_navigate_page.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/recipes/recipe_detail_screen_page.dart';
import 'package:smarthq_flutter_module/view/recipes/archetypes/recipe_archetype_cook_mix_timer_screen.dart' as recipe;
import 'package:smarthq_flutter_module/view/recipes/archetypes/recipe_archetype_finish_screen.dart' as recipe;
import 'package:smarthq_flutter_module/view/recipes/archetypes/recipe_archetype_measure_screen.dart'as recipe;
import 'package:smarthq_flutter_module/view/recipes/archetypes/recipe_archetype_mixing_screen.dart' as recipe;
import 'package:smarthq_flutter_module/view/recipes/archetypes/oven_recipe_archetype_bake_screen.dart' as recipe;
import 'package:smarthq_flutter_module/view/recipes/recipe_discover_screen_page.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
class RecipeNavigator extends StatelessWidget {

  final RecipeFilterArguments? args;
  RecipeNavigator(this.args);

  @override  
  Widget build(BuildContext context) {
    geaLog.debug('RecipeNavigator:build');
    geaLog.debug('RecipeNavigator:build:args: ${args.toString()}');
    return WillPopScope(
        onWillPop: () async {
          geaLog.debug('RecipeNavigator:onWillPop');
          switch (BlocProvider.of<RecipeDetailsCubit>(context).currentRoute) {
            case Routes.RECIPE_DICOVER_PAGE:
              if(BlocProvider.of<ApplianceCubit>(context).state.applianceType == ApplianceType.STAND_MIXER){
                globals.subRouteName = Routes.STAND_MIXER_CONTROL_PAGE;
                Navigator.of(context, rootNavigator: true).pushNamed(Routes.STAND_MIXER_CONTROL_MAIN_NAVIGATOR);
              } else {
                if(BlocProvider.of<ApplianceCubit>(context).state.applianceType == ApplianceType.TOASTER_OVEN){
                  BlocProvider.of<RecipeDetailsCubit>(context).clearState();
                  BlocProvider.of<RecipeStepsCubit>(context).clearState();
                  BlocProvider.of<NativeCubit>(context).clearReturnedRoute();
                  BlocProvider.of<RecipeCubit>(context).clearAllRecipes();
                }
                SystemNavigator.pop();
              }
              break;
            case Routes.RECIPE_DETAILS_PAGE:
              globals.subRouteName = Routes.RECIPE_DICOVER_PAGE;
              Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR);
              break;
            case Routes.RECIPE_ADD_INGREDIENT_ARCHETYPE:
            case Routes.RECIPE_MIXING_ARCHETYPE:
            case Routes.RECIPE_MIXING_TIMER_ARCHETYPE:
            case Routes.RECIPE_FINISH_ARCHETYPE:
              if(BlocProvider.of<RecipeStepsCubit>(context).state is ControlStep){
                ControlStep controlRecipe = BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep;
                //If the current step is zero just go back to the recipe details page
                if(controlRecipe.currentStep == 0){
                  BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(controlRecipe.currentStep,
                      context,
                      BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest(),
                      isFinishedOrQuit: true);

                  globals.subRouteName = Routes.RECIPE_DETAILS_PAGE;
                  Navigator.of(context, rootNavigator: true).pushNamed(Routes.RECIPE_MAIN_NAVIGATOR);

                } else {
                  //Only the stand mixer can retrieve the true active step since the Toaster oven does not support 0x5300
                  int? activeStep;
                  if(BlocProvider.of<ApplianceCubit>(context).state.applianceType == ApplianceType.TOASTER_OVEN){
                    activeStep = controlRecipe.currentStep + 1;
                  } else {
                    activeStep = await BlocProvider.of<RecipeStepsCubit>(context).currentActiveStep();
                  }
      
                  //Bring the user back to the previous step
                  Future.delayed(Duration.zero, () {
                    BlocProvider.of<RecipeStepsCubit>(context).advanceToNextStepArchetype(
                        ContextUtil.instance.routingContext ?? context,
                        controlRecipe.currentStep - 2,
                        controlRecipe.recipe,
                        BlocProvider.of<RecipeStepsCubit>(context).getUpdatedIndexTracker(controlRecipe.recipe, activeStep ?? 0),
                        );
                  });
                }
              }
              break;
          }
          return false;
        },
        child: MultiBlocProvider(
          providers: [
            BlocProvider<RecipeDetailsCubit>.value(
              value: GetIt.I.get<RecipeDetailsCubit>(),
            ),
            BlocProvider<RecipeCubit>.value(
              value: GetIt.I.get<RecipeCubit>(),
            ),
            BlocProvider<RecipeStepsCubit>.value(
              value: GetIt.I.get<RecipeStepsCubit>(),
            ),
            BlocProvider<StandMixerControlCubit>(
              create: (context) =>  GetIt.I.get<StandMixerControlCubit>(),
            ),
            BlocProvider<ToasterOvenControlCubit>(
              create: (context) =>  GetIt.I.get<ToasterOvenControlCubit>(),
            ),
          ],
          child: BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(
            builder: (context, state) {
              return Navigator(
                initialRoute: Routes.COMMON_NAVIGATE_PAGE,
                onGenerateRoute: (RouteSettings settings) {
                  geaLog.debug('RecipeNavigator:onGenerateRoute: ${settings.name}');
                  BlocProvider.of<RecipeDetailsCubit>(context).currentRoute = settings.name ?? '';
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case Routes.COMMON_NAVIGATE_PAGE:
                      builder = (BuildContext _) => CommonNavigatePage();
                      break;
                    case Routes.RECIPE_MAIN_NAVIGATOR:
                    case Routes.RECIPE_DICOVER_PAGE:
                      late RecipeFilterArguments attemptedArgs;
                      if(args != null){
                        attemptedArgs = args!;
                        Future.delayed(Duration.zero, () {
                          BlocProvider.of<RecipeDetailsCubit>(context).setArthur(args?.isArthur ?? false);
                          BlocProvider.of<RecipeDetailsCubit>(context).setDomains(args?.domains, context);
                        });
                      } else {
                        attemptedArgs = RecipeFilterArguments(
                          domains: state.domains,
                          isArthur: state.isArthur ?? false,
                        );
                      }
                      builder = (BuildContext _) => RecipeDiscoverPage(domains: attemptedArgs.domains, isArthur: attemptedArgs.isArthur);
                      break;
                    case Routes.RECIPE_DETAILS_PAGE:
                      late RecipeArguments args;
                      try{
                        args = settings.arguments as RecipeArguments;
                      } catch(e) {
                        args = RecipeArguments(
                          state.recipe!.id!,
                          '',
                          state.isAuto ?? false,
                          state.isArthur ?? false,
                        );
                      }
                      builder = (BuildContext _) => RecipeDetailScreen(recipeId: args.recipeId, userId: args.userId, isAuto: args.isAuto, isArthur: args.isArthur);
                      break;
                    case Routes.RECIPE_ADD_INGREDIENT_ARCHETYPE:
                      final args = settings.arguments as RecipeArchetypeArguments;
                      builder = (BuildContext _) => recipe.RecipeArchetypeMeasureScreen(recipe: args.recipe, stepIndex: args.stepIndex, indexTracker: args.indexTracker);
                      break;
                    case Routes.RECIPE_MIXING_ARCHETYPE:
                      final args = settings.arguments as RecipeArchetypeArguments;
                      builder = (BuildContext _) => recipe.RecipeArchetypeMixingScreen(recipe: args.recipe, stepIndex: args.stepIndex, indexTracker: args.indexTracker);
                      break;
                    case Routes.RECIPE_MIXING_TIMER_ARCHETYPE:
                      final args = settings.arguments as RecipeArchetypeArguments;
                      builder = (BuildContext _) => recipe.RecipeArchetypeCookMixTimerScreen(recipe: args.recipe, stepIndex: args.stepIndex, indexTracker: args.indexTracker, timerSecRemaining: args.timerSecRemaining,);
                      break;
                    case Routes.RECIPE_FINISH_ARCHETYPE:
                      final args = settings.arguments as RecipeArchetypeArguments;
                      builder = (BuildContext _) => recipe.RecipeFinishScreen(recipe: args.recipe, stepIndex: args.stepIndex, indexTracker: args.indexTracker);
                      break;
                    case Routes.RECIPE_OVEN_ARCHETYPE:
                      final args = settings.arguments as RecipeArchetypeArguments;
                      builder = (BuildContext _) => recipe.RecipeArchetypeOvenScreen(recipe: args.recipe, stepIndex: args.stepIndex, indexTracker: args.indexTracker);
                      break;
                    case Routes.STAND_MIXER_CONTROL_PAGE:
                      globals.subRouteName = Routes.STAND_MIXER_CONTROL_PAGE;
                      Navigator.of(context, rootNavigator: true).pushNamed(Routes.STAND_MIXER_CONTROL_MAIN_NAVIGATOR);
                      builder = (BuildContext _) => Container();
                      break;
                    default:
                      throw Exception('Invalid route: ${settings.name}');
                  }
                  if(settings.name?.contains("archetypes/") == true){
                    return PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        final args = settings.arguments as RecipeArchetypeArguments;
                        if(args.isBack == true){
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(-1,0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        } else {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        }
                    },
                  );
                }
                  return MaterialPageRoute(
                    builder: builder,
                    settings: settings,
                  );
                },
              );
            }
          ),
        )
    );
  }
}

class RecipeArguments {
  final String recipeId;
  final String userId;
  final bool isAuto;
  final bool isArthur;
  RecipeArguments(this.recipeId, this.userId, this.isAuto, this.isArthur);
}

class RecipeArchetypeArguments {
  final Recipe recipe;
  final int stepIndex;
  final List<bool> indexTracker;
  final bool? isBack;
  final int? timerSecRemaining;
  RecipeArchetypeArguments(this.recipe, this.stepIndex, this.indexTracker, {this.isBack = false, this.timerSecRemaining});
}

class RecipeFilterArguments {
  final List<String>? domains;
  final bool isArthur;
  RecipeFilterArguments({ this.domains, required this.isArthur});
}
