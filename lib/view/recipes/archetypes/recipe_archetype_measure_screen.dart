import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/control/stand_mixer_control_cubit.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/recipe_cubit.dart';
import 'package:smarthq_flutter_module/cubits/recipe_steps_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/recipes/common/full_width_button.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_cheat_sheet.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_ingredient_card.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_text_card.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_tip_card.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_up_next_card.dart';
import 'package:collection/collection.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class RecipeArchetypeMeasureScreen extends StatefulWidget {
  Recipe recipe;
  int stepIndex;
  List<bool> indexTracker;
  RecipeArchetypeMeasureScreen({required this.recipe, required this.stepIndex, required this.indexTracker});

  @override
  State<RecipeArchetypeMeasureScreen> createState() => _RecipeArchetypeMeasureScreenState();
}

class _RecipeArchetypeMeasureScreenState extends State<RecipeArchetypeMeasureScreen> with WidgetsBindingObserver {
  Size mediaSize = Size(0,0);
  bool showCheatSheet = false;

  @override
  void didUpdateWidget (covariant RecipeArchetypeMeasureScreen oldWidget) {

    super.didUpdateWidget(oldWidget);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      if (BlocProvider.of<RecipeCubit>(context).state is RecipeCleared){
            BlocProvider.of<RecipeCubit>(context).resetState();
            Future.delayed(Duration.zero, () {
              Navigator.popUntil(context, (route) => route.isFirst);
            });
        }  
      }
  }

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

  void exitToDetailsPage(BuildContext context, String applianceStringForRequest){
    String userId = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).userId;
    bool isAuto = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isAuto;
    bool isArthur = (BlocProvider.of<RecipeStepsCubit>(context).state as ControlStep).isArthur;
    BlocProvider.of<RecipeStepsCubit>(context).advanceCloudIndex(widget.stepIndex, context, applianceStringForRequest, isFinishedOrQuit: true);
    BlocProvider.of<StandMixerControlCubit>(context).clearRecipeStatus();
    BlocProvider.of<RecipeStepsCubit>(context).clearRecipeExecutionId();
    Navigator.of(context).pushReplacementNamed(Routes.RECIPE_DETAILS_PAGE, arguments: RecipeArguments(widget.recipe.id!, userId, isAuto, isArthur));
  }


  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
    String applianceStringForRequest = BlocProvider.of<ApplianceCubit>(context).getApplianceTypeForRequest();
    return BlocBuilder<RecipeStepsCubit, RecipeStepsState>(
        builder: (context, state) {
          if(state is ControlStep){
            final currentStep = widget.recipe.steps![widget.stepIndex];
            return Scaffold(
              appBar: AppBar(
                title: Text("${LocaleUtil.getString(context, LocaleUtil.STEP)?.toUpperCase()} ${widget.stepIndex+1}/${widget.recipe.steps!.length}",
                  style: showCheatSheet ? textStyle_size_16_bold_color_white_wide_faded() : textStyle_size_16_bold_color_white_wide(),),
                centerTitle: true,
                elevation: 0.0,
                leading:  IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: showCheatSheet ? Colors.white.withOpacity(0.5) : Colors.white,
                  ),
                  onPressed: () {
                    if(widget.stepIndex == 0){
                      geaLog.debug("RecipeArchetypeMeasureScreen: Back to RecipeDetailsScreen");
                      exitToDetailsPage(context, applianceStringForRequest);
                    } else {
                      String route = BlocProvider.of<RecipeStepsCubit>(context).returnRoutedArchetype(widget.stepIndex-1, widget.recipe);
                      Navigator.of(context).pushReplacementNamed(route, arguments: RecipeArchetypeArguments(widget.recipe, widget.stepIndex-1, widget.indexTracker, isBack: true));
                    }
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.close, color: showCheatSheet ? Colors.white.withOpacity(0.5) : Colors.white,),
                    onPressed: () {
                      geaLog.debug("RecipeArchetypeMeasureScreen: Back to RecipeDetailsScreen");
                      exitToDetailsPage(context, applianceStringForRequest);
                    },
                  ),
                ],
              ),
              backgroundColor: Colors.black,
              body: FocusDetector(
                onFocusGained: () {
                  BlocProvider.of<NativeCubit>(context).showTopBar(false);
                },
                child: SafeArea(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: showCheatSheet ? toggleCheatSheet : ()=>{},
                        child: Opacity(
                          opacity: showCheatSheet ? 0.5 : 1,
                          child: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                                return SingleChildScrollView(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                          child: currentStep.type == "prep" || currentStep.type == "manual"
                                              ? RecipeTextCard(label: currentStep.label ?? "", direction: currentStep.directions, mediaURL: getMediaURL(currentStep),mimeType: widget.recipe.media?.firstWhereOrNull((element) => element.id == currentStep.mediaId)?.mimetype ?? "",)
                                              : RecipeIngredientCard(
                                            label: currentStep.label ?? "",
                                            mediaURL: getMediaURL(currentStep),
                                            direction: currentStep.directions ?? "",
                                            alternateDirection: currentStep.alternateDirection ?? "",
                                            indexTracker: widget.indexTracker,
                                            userId: state.userId,
                                            stepIndex: widget.stepIndex,
                                            buttonText: LocaleUtil.getString(context, LocaleUtil.PRESS_TO_WEIGH)!,
                                            isAuto: state.isAuto, stepType: currentStep.type ?? "",
                                            mediaSize: mediaSize,
                                            applianceString: applianceStringForRequest,
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                          child: RecipeUpNextCard(
                                              nextStep: widget.recipe.steps![widget.stepIndex +1].label ?? "", cheatSheetCallback: toggleCheatSheet),
                                        ),
                                        SizedBox(height: 20.h,),
                                        Visibility(
                                          visible: currentStep.tip != null,
                                          child: RecipeTipCard(tip: currentStep.tip ?? ""),
                                        ),
                                        SizedBox(height: 65.h)
                                      ],
                                    ),
                                  ),
                                );}
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: FullWidthButton(text: LocaleUtil.getString(context, LocaleUtil.NEXT)!.toUpperCase(), callback: () {
                            BlocProvider.of<RecipeStepsCubit>(context).clearScale();
                            BlocProvider.of<RecipeStepsCubit>(context).advanceToNextStepArchetype(context, widget.stepIndex, widget.recipe, widget.indexTracker);
                          }
                          )
                      ),
                      RecipeCheatSheet(
                          ingredientsList: state.updatedIngredients ?? [],
                          recipeTitle: widget.recipe.label!,
                          isAutoSense: state.isAuto,
                          isShown: showCheatSheet,
                          stepsList: widget.recipe.steps!
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else return Container();
        }
    );
  }
}