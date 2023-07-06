/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/recipe_cubit.dart';
import 'package:smarthq_flutter_module/cubits/recipe_steps_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/control/toaster_oven_control_model.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x922F.dart';
import 'package:smarthq_flutter_module/resources/erd/toaster_oven/0x9209.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:collection/collection.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/view/recipes/common/full_width_button.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_cheat_sheet.dart';
import 'package:smarthq_flutter_module/view/recipes/common/oven_recipe_bake_card.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_tip_card.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_up_next_card.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';


// ignore: must_be_immutable
class RecipeArchetypeOvenScreen extends StatefulWidget {
  final Recipe recipe;
  final int stepIndex;
  final List<bool> indexTracker;
  RecipeArchetypeOvenScreen({required this.recipe, required this.stepIndex, required this.indexTracker});

  @override
  State<RecipeArchetypeOvenScreen> createState() => _RecipeArchetypeOvenScreenState();
}

class _RecipeArchetypeOvenScreenState extends State<RecipeArchetypeOvenScreen> {
  late RecipeCubit recipeCubit;
  late RecipeStepsCubit recipeStepsCubit;
  int minRemain = 0;
  Size mediaSize = Size(0, 0);
  bool executionSent = false;
  bool hasNavigated = false;



  @override
  void initState() {
    super.initState();
  }
  
  @override
  void didUpdateWidget (covariant RecipeArchetypeOvenScreen oldWidget) {
    BlocProvider.of<RecipeCubit>(context).closePageIfApplianceWasSwitched(context, "Recipe Measure Screen");
    if((BlocProvider.of<RecipeCubit>(context).state is RecipeCleared) == false){
      BlocProvider.of<NativeCubit>(context).showTopBar(false);
    } else {
      BlocProvider.of<NativeCubit>(context).showTopBar(true);
    }
    super.didUpdateWidget(oldWidget);
  }

  bool showCheatSheet = false;

  String? getMediaURL(Steps currentStep){
    String? mediaURL;
    widget.recipe.media!.forEach((recipe) {
      if(recipe.id == currentStep.mediaId){
        recipe.sizes!.forEach((element) {
          if(int.parse(element.heightPixels ?? "0") > 96 || int.parse(element.widthPixels ?? "0") > 96){
            mediaURL = element.mediaUrl;
          } else if(element.id == "96x96"){
            mediaURL = element.mediaUrl;
          } else {
            mediaURL = element.mediaUrl;
          }
        });
      }
    });
    geaLog.debug("mediaURL: $mediaURL");
    return mediaURL;
  }

  String? getMimeType(Steps currentStep){
    String? mimeType;
    widget.recipe.media!.forEach((recipe) {
      if(recipe.id == currentStep.mediaId){
        mimeType = recipe.mimetype;
      }
    });
    return mimeType;
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

  Future<void> navigateToTimerArchetype(BuildContext context, ToasterOvenControlState state) async {
    int _currentStep = await BlocProvider.of<RecipeStepsCubit>(context).checkRecipeStepWithout5300(context);
    geaLog.debug("STEPPP $_currentStep");
    if(_currentStep == widget.stepIndex){
      if(BlocProvider.of<ToasterOvenControlCubit>(context).getToasterOvenCurrentState() == ToasterOvenCurrentState.TOASTER_OVEN_COOKING){
        if(!hasNavigated){
          int timerSecRemaining = ERD0x922F(state.cache![ERD.TOASTER_OVEN_COOK_TIME_REMAINING]!).remainingCookTimeSeconds;
          Navigator.of(context).pushReplacementNamed(Routes.RECIPE_MIXING_TIMER_ARCHETYPE,
              arguments: RecipeArchetypeArguments(widget.recipe,widget.stepIndex,widget.indexTracker, timerSecRemaining: timerSecRemaining));
        }
        hasNavigated = true;
      }
    }
  }
  
  void exitToDetailsPage(BuildContext context){
    String applianceStringForRequest = BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest();
    String userId = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).userId;
    bool isAuto = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isAuto;
    bool isArthur = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isArthur;
    BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(widget.stepIndex, context, applianceStringForRequest, isFinishedOrQuit: true,);
    BlocProvider.of<RecipeStepsCubit>(context).clearRecipeExecutionId();
    Navigator.of(context).pushReplacementNamed(Routes.RECIPE_DETAILS_PAGE, arguments: RecipeArguments(widget.recipe.id!, userId, isAuto, isArthur));
  }
  
  @override
  Widget build(BuildContext context) {
    final currentStep = widget.recipe.steps![widget.stepIndex];
    recipeStepsCubit = BlocProvider.of<RecipeStepsCubit>(context);
    var cubitState = (recipeStepsCubit.state as ControlStep);
    String applianceString = BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest();
    return Scaffold(
        appBar: AppBar(
          title: Text("${LocaleUtil.getString(context, LocaleUtil.STEP)
              ?.toUpperCase()} ${widget.stepIndex + 1}/${widget.recipe.steps!
              .length}",
            style: showCheatSheet
                ? textStyle_size_16_bold_color_white_wide_faded()
                : textStyle_size_16_bold_color_white_wide()),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: showCheatSheet ? Colors.white.withOpacity(0.5) : Colors
                  .white,
            ),
            onPressed: () {
              if (widget.stepIndex == 0) {
                geaLog.debug(
                    "RecipeArchetypeMeasureScreen: Back to RecipeDetailsScreen");
                BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(
                    widget.stepIndex, context, isFinishedOrQuit: true, applianceString);
                Navigator.of(context).pop();
              } else {
                String route = BlocProvider.of<RecipeStepsCubit>(context)
                    .returnRoutedArchetype(
                    widget.stepIndex - 1, widget.recipe);
                Navigator.of(context).pushReplacementNamed(route,
                    arguments: RecipeArchetypeArguments(
                        widget.recipe, widget.stepIndex - 1,
                        widget.indexTracker,
                        isBack: true));
              }
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.close,
                color: showCheatSheet ? Colors.white.withOpacity(0.5) : Colors
                    .white,),
              onPressed: () {
                exitToDetailsPage(context);
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: BlocConsumer<ToasterOvenControlCubit, ToasterOvenControlState>(
          listener: (context, state){
            if(mounted) {
              navigateToTimerArchetype(context, state);
            }
          }, 
            listenWhen: (previous, current) {
            return previous.cache![ERD.TOASTER_OVEN_CURRENT_STATE] != current.cache![ERD.TOASTER_OVEN_CURRENT_STATE];
            },
          builder: (context, snapshot) {
            return SafeArea(
              child: FocusDetector(
                onFocusGained: () {
                  BlocProvider.of<NativeCubit>(context).showTopBar(false);
                  navigateToTimerArchetype(context, snapshot);
                },
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: showCheatSheet ? toggleCheatSheet : () => {},
                      child: Opacity(
                        opacity: showCheatSheet ? 0.5 : 1,
                        child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints viewportConstraints) {
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: viewportConstraints.maxHeight),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: RecipeOvenCard(
                                            label: currentStep.label ?? "",
                                            direction: currentStep.directions,
                                            mediaURL: getMediaURL(currentStep),
                                            mimeType: widget.recipe.media
                                                ?.firstWhereOrNull((element) =>
                                            element.id == currentStep.mediaId)
                                                ?.mimetype ?? "",
                                            stepIndex: widget.stepIndex,
                                            userId: cubitState.userId,
                                            indexTracker: widget.indexTracker,
                                            buttonText: LocaleUtil.getString(
                                                context, LocaleUtil.SEND_TO_OVEN)!,
                                            altText: LocaleUtil.getString(context,
                                                LocaleUtil.SENT_TO_OVEN)!,
                                            applianceString: applianceString,
                                          )
                                      ),
                                      SizedBox(height: 20.h,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: RecipeUpNextCard(
                                          nextStep: widget.recipe.steps![widget
                                              .stepIndex + 1].label ?? "",
                                          cheatSheetCallback: toggleCheatSheet,),
                                      ),
                                      SizedBox(height: 20.h,),
                                      Visibility(
                                        visible: currentStep.tip != null,
                                        child: RecipeTipCard(
                                            tip: currentStep.tip ?? ""),
                                      ),
                                      SizedBox(height: 65.h)
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: FullWidthButton(
                            text: LocaleUtil.getString(context, LocaleUtil.NEXT)!
                                .toUpperCase(), callback: () {
                          recipeStepsCubit.advanceToNextStepArchetype(
                              context, widget.stepIndex, widget.recipe,
                              widget.indexTracker);
                        }
                        )
                    ),
                    RecipeCheatSheet(
                        ingredientsList: cubitState.updatedIngredients ?? [],
                        recipeTitle: widget.recipe.label!,
                        isAutoSense: cubitState.isAuto,
                        isShown: showCheatSheet,
                        stepsList: widget.recipe.steps!
                    ),
                  ],
                ),
              ),
            );
          }
        )
    );
  }
}