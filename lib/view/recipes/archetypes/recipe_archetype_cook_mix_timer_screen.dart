import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/control/toaster_oven_control_model.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/erd/ERD.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x922F.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/models/control/stand_mixer_control_model.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/recipes/circle_timer/circle_timer.dart';
import 'package:smarthq_flutter_module/view/recipes/common/full_width_button.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_cheat_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class RecipeArchetypeCookMixTimerScreen extends StatefulWidget {
  Recipe recipe;
  int stepIndex;
  List<bool> indexTracker;
  int? timerSecRemaining;
  
  RecipeArchetypeCookMixTimerScreen({required this.recipe, required this.stepIndex, required this.indexTracker, this.timerSecRemaining});

  @override
  State<RecipeArchetypeCookMixTimerScreen> createState() =>
      _RecipeArchetypeCookMixTimerScreenState();
}

class _RecipeArchetypeCookMixTimerScreenState extends State<RecipeArchetypeCookMixTimerScreen> with WidgetsBindingObserver {

  bool timerComplete = false;
  bool showCheatSheet = false;
  bool hasNavigated = false;

  late bool isToaster;
  late var applianceControlCubit;
  late var applianceState;
  late ApplianceType applianceType;

  timerCompleteCallback() {
    setState(() {
      timerComplete = true;
    });
  }

  void toggleCheatSheet(){
    setState(() {
      showCheatSheet = !showCheatSheet;
      if (showCheatSheet)
        BlocProvider.of<NativeCubit>(context).showBottomBar(false);
      else
        BlocProvider.of<NativeCubit>(context).showBottomBar(true);
    });
  }
  
  String returnText(){
    applianceType = BlocProvider.of<ApplianceCubit>(context).state.applianceType ?? ApplianceType.UNDEFINED;
    switch(applianceType) {
      case ApplianceType.TOASTER_OVEN : {
        return (LocaleUtil.COOKING);
      }
      case ApplianceType.STAND_MIXER : {
        return LocaleUtil.MIXING;
      }
      default : {
        return "";
      }
    }
  }
  
  void determineAppliance() {
    applianceType = BlocProvider.of<ApplianceCubit>(context).state.applianceType ?? ApplianceType.UNDEFINED;
    switch (applianceType) {
      case ApplianceType.TOASTER_OVEN:
        {
          isToaster = true;
          break;
        }
      default:
        {
          isToaster = false;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      determineAppliance();
      shouldNavigate();
    });
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (BlocProvider.of<RecipeCubit>(context).state is RecipeCleared){
            BlocProvider.of<RecipeCubit>(context).resetState();
            Future.delayed(Duration.zero, () {
              Navigator.popUntil(context, (route) => route.isFirst);
            });
          }
      shouldNavigate();
    }
  }

  void exitToDetailsPage(BuildContext context){
    String applianceStringForRequest = BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest();
    String userId = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).userId;
    bool isAuto = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isAuto;
    bool isArthur = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isArthur;
    BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(widget.stepIndex, context, applianceStringForRequest, isFinishedOrQuit: true);
    BlocProvider.of<StandMixerControlCubit>(context).clearRecipeStatus();
    BlocProvider.of<RecipeStepsCubit>(context).clearRecipeExecutionId();
    Navigator.of(context).pushReplacementNamed(Routes.RECIPE_DETAILS_PAGE, arguments: RecipeArguments(widget.recipe.id!, userId, isAuto, isArthur));
  }

  void shouldNavigate(){
    BlocProvider.of<RecipeStepsCubit>(context).isApplianceIdleAndNeedsToBeNavigatedOut(hasNavigated,
      context,
      widget.stepIndex,
      widget.indexTracker,
      applianceType, 
      applianceType == ApplianceType.TOASTER_OVEN ? BlocProvider.of<ToasterOvenControlCubit>(context).getToasterOvenCurrentState() : null
    );
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
    String applianceStringForRequest = BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest();
    return Scaffold(
      appBar: AppBar(
        title: Text("${LocaleUtil.getString(context, LocaleUtil.STEP)?.toUpperCase()} ${widget.stepIndex+1}/${widget.recipe.steps!.length}",
          style: showCheatSheet ? textStyle_size_16_bold_color_white_wide_faded() : textStyle_size_16_bold_color_white_wide()),
        centerTitle: true,
        elevation: 0.0,
        leading:  IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: showCheatSheet ? Colors.white.withOpacity(0.5) : Colors.white,
          ),
          onPressed: () {
            if(widget.stepIndex == 0) {
              geaLog.debug("RecipeMixTimerScreen: Back to RecipeDetailsScreen");
              BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(widget.stepIndex, context, isFinishedOrQuit: true, applianceStringForRequest);
              BlocProvider.of<RecipeDetailsCubit>(context).clearState();
              isToaster ? BlocProvider.of<ToasterOvenControlCubit>(context).clearRecipeStatus() : BlocProvider.of<StandMixerControlCubit>(context).clearRecipeStatus();
            } else {
              String route = BlocProvider.of<RecipeStepsCubit>(context).returnRoutedArchetype(widget.stepIndex-1, widget.recipe);
              Navigator.of(context).pushReplacementNamed(route, arguments: RecipeArchetypeArguments(widget.recipe, widget.stepIndex-1, widget.indexTracker, isBack: true));
            }
          },
        ),
        actions: [
        IconButton(
          icon: Icon(Icons.close, color: showCheatSheet ? Colors.white.withOpacity(0.5) : Colors.white),
          onPressed: () {
            exitToDetailsPage(context);
          },
        ),
      ],
      ),
      backgroundColor: Colors.black,
      body: MultiBlocListener(
        listeners: [
          BlocListener<StandMixerControlCubit, StandMixerControlState>(
          listener: (context, state) {
            if(mounted && applianceType == ApplianceType.STAND_MIXER && state.erdState == StandMixerErdState.loaded){
              shouldNavigate();
            }
          },),
          BlocListener<ToasterOvenControlCubit, ToasterOvenControlState>(
              listener: (context, state) {
                // appliance check and isMounted check
                if(mounted && applianceType == ApplianceType.TOASTER_OVEN && state.erdState == ToasterOvenErdState.loaded){
                  shouldNavigate();
                }
              })
        ],
        child: FocusDetector(
            onFocusGained: () {
              BlocProvider.of<NativeCubit>(context).showTopBar(false);
            },
            child: Stack(
                children: [
                  GestureDetector(
                    onTap: showCheatSheet ? toggleCheatSheet : ()=>{},
                    child: Opacity(
                      opacity: showCheatSheet ? 0.5 : 1,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleTimerAndCards(
                            timerCompleteCallback: timerCompleteCallback,
                            nextStep: widget.recipe.steps![widget.stepIndex + 1].label,
                            currentStep: widget.recipe.steps![widget.stepIndex],
                            cheatSheetCallback: toggleCheatSheet,
                            timerStartTime: widget.timerSecRemaining ?? 0,
                            stepIndex: widget.stepIndex,
                            indexTracker: widget.indexTracker,
                            stateText: returnText(),
                            recipe: widget.recipe,
                            applianceType: applianceType,
                          )
                        ],),
                      ),
                    ),
                  ),
                  BlocBuilder<RecipeStepsCubit, RecipeStepsState>(
                    builder: (context, state) {
                      if(state is ControlStep){
                        return AnimatedOpacity(
                            duration: Duration(milliseconds: 400),
                            opacity: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FullWidthButton(
                                  text: LocaleUtil.getString(context, LocaleUtil.NEXT)?.toUpperCase() ?? "",
                                  callback: () {
                                    BlocProvider.of<RecipeStepsCubit>(context).advanceToNextStepArchetype(context, widget.stepIndex, state.recipe, widget.indexTracker);
                                  }
                              ),
                            ),
                          );
                      }
                      return Container();
                    },
                  ),
                  BlocBuilder<RecipeStepsCubit, RecipeStepsState>(
                    builder: (context, state) {
                      if(state is ControlStep){
                      return RecipeCheatSheet(
                            ingredientsList: state.updatedIngredients ?? [],
                            recipeTitle: widget.recipe.label!,
                            isAutoSense: state.isAuto,
                            isShown: showCheatSheet,
                            stepsList: widget.recipe.steps!
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
          ),
      ),
    );
  }

}
