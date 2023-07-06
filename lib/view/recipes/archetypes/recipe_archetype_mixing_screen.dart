import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/control/stand_mixer_control_cubit.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/recipe_cubit.dart';
import 'package:smarthq_flutter_module/cubits/recipe_steps_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/control/stand_mixer_control_model.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9300.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9305.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/stand_mixer_erd_parser.dart';
import 'package:smarthq_flutter_module/services/erd_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/view/recipes/common/cloud_action_button.dart';
import 'package:smarthq_flutter_module/view/recipes/common/full_width_button.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_tip_card.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class RecipeArchetypeMixingScreen extends StatefulWidget {
  Recipe recipe;
  int stepIndex;
  List<bool> indexTracker;

  RecipeArchetypeMixingScreen({required this.recipe, required this.stepIndex, required this.indexTracker});

  @override
  State<RecipeArchetypeMixingScreen> createState() =>
      _RecipeArchetypeMixingScreenState();
}

class _RecipeArchetypeMixingScreenState extends State<RecipeArchetypeMixingScreen> {
  bool executionSent = false;
  bool hasNavigated = false;
  MixerState? mixerState;

  String targetTimeSecToMin(){
    int targetInSec = widget.recipe.steps![widget.stepIndex].mixerTargetTimeSeconds!.toInt();
    int targetInMin = targetInSec ~/ 60;
    if(targetInMin < 1){
      return "< 1";
    } else {
      return targetInMin.toString();
    }
  }

  String getMixerSpeed(int speed){
    if(speed == 1){
      return LocaleUtil.getString(context, LocaleUtil.STIR) ?? "1";
    } else {
      return speed.toString();
    }
  }

  void toggleExecutionSent(){
    setState(() {
      if (!executionSent){
        executionSent = !executionSent;
      }
    });
  }

  Future<void> navigateToTimerArchetype(BuildContext context, StandMixerContentModel _contentModel) async {
    // get 0x5300
    int currentActiveStep = await BlocProvider.of<RecipeStepsCubit>(context).currentActiveStep();
    if(currentActiveStep == widget.stepIndex){
      if(_contentModel.mixerMode == MixerMode.MIXER_REMOTE_MODE.toFormatted()){
        if(_contentModel.mixerState == CycleState.mixing || _contentModel.mixerState == CycleState.paused){
          //IF THE MIXER IS MIXING OR PAUSED, MOVE TO THE NEzXT PAGE AUTOMATICALLY
          if(!hasNavigated){
            Navigator.of(context).pushReplacementNamed(Routes.RECIPE_MIXING_TIMER_ARCHETYPE,
                arguments: RecipeArchetypeArguments(widget.recipe,widget.stepIndex,widget.indexTracker));
            }
          hasNavigated = true;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      geaLog.debug("RecipeArchetypeMixingScreen initState");
      BlocProvider.of<StandMixerControlCubit>(context).requestCache();
    });
  }

  @override
  void didUpdateWidget (covariant RecipeArchetypeMixingScreen oldWidget) {
      if (BlocProvider.of<RecipeCubit>(context).state is RecipeCleared){
            BlocProvider.of<RecipeCubit>(context).resetState();
            Future.delayed(Duration.zero, () {
              Navigator.popUntil(context, (route) => route.isFirst);
            });
        }
      super.didUpdateWidget(oldWidget);
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
          final currentStep = widget.recipe.steps![widget.stepIndex];
          if(state is ControlStep){
            return Scaffold(
              appBar: AppBar(
                title: Text("${LocaleUtil.getString(context, LocaleUtil.STEP)?.toUpperCase()} ${widget.stepIndex+1}/${widget.recipe.steps!.length}",
                    style: textStyle_size_16_bold_color_white_wide()),
                centerTitle: true,
                elevation: 0.0,
                leading:  IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if(widget.stepIndex == 0){
                      exitToDetailsPage(context, applianceStringForRequest);
                    } else {
                      String route = BlocProvider.of<RecipeStepsCubit>(context).returnRoutedArchetype(widget.stepIndex-1, widget.recipe);
                      Navigator.of(context).pushReplacementNamed(route, arguments: RecipeArchetypeArguments(widget.recipe, widget.stepIndex-1, widget.indexTracker, isBack: true));
                    }
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      exitToDetailsPage(context, applianceStringForRequest);
                    },
                  ),
                ],
              ),
              backgroundColor: Colors.black,
              body: BlocConsumer<StandMixerControlCubit, StandMixerControlState>(
                listener: (context, state) {
                  if(state.erdState == StandMixerErdState.loaded){
                    if(state.contentModel != null){
                      navigateToTimerArchetype(context, state.contentModel!);
                    }
                  }
                },
                builder: (context, cubitState) {
                  return FocusDetector(
                    onFocusGained: () {
                      BlocProvider.of<NativeCubit>(context).showTopBar(false);
                      if(cubitState.erdState == StandMixerErdState.loaded){
                        if(cubitState.contentModel != null){
                          navigateToTimerArchetype(context, cubitState.contentModel!);
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                gradient: gradientDarkGreyCharcoalGrey(),
                                                borderRadius: BorderRadius.circular(10.w)),
                                            child: Padding(
                                              padding: EdgeInsets.all(26.w),
                                              child: Column(
                                                children: [
                                                  Row(
                                                      children: [
                                                        Container(
                                                            height: 24.w,
                                                            width: 24.w,
                                                            child: SvgPicture.asset(ImagePath.TIME_ICON)),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10.w),
                                                          child: Text(LocaleUtil.getString(context, LocaleUtil.ESTIMATED_TIME)!,
                                                              style: textStyle_size_16_semi_bold_color_light_silver()),
                                                        ),
                                                        Spacer(),
                                                        Text("${targetTimeSecToMin()} Min",
                                                          style: textStyle_size_16_semi_bold_color_light_silver(),
                                                        )
                                                      ]),
                                                  Padding(padding: EdgeInsets.only(top: 10)),
                                                  Row(
                                                      children: [
                                                        Container(
                                                            height: 24.w,
                                                            width: 24.w,
                                                            child: SvgPicture.asset(ImagePath.SPEED_ICON)),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10),
                                                          child: Text(LocaleUtil.getString(context, LocaleUtil.SPEED)!,
                                                              style: textStyle_size_16_semi_bold_color_light_silver()),
                                                        ),
                                                        Spacer(),
                                                        Text(getMixerSpeed(currentStep.mixerSpeed!),
                                                          style: textStyle_size_16_semi_bold_color_light_silver(),
                                                        )
                                                      ]),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 20.h),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width - 20,
                                            decoration: BoxDecoration(
                                                gradient: gradientDarkGreyCharcoalGrey(),
                                                borderRadius: BorderRadius.circular(10.w)),
                                            child: Column(children: [
                                              Padding(
                                                padding:  EdgeInsets.symmetric(vertical: 20.0.h),
                                                child: Text(
                                                    executionSent ?
                                                    LocaleUtil.getString(context, LocaleUtil.PRESS_CENTER_BUTTON_MIXER)! :
                                                    LocaleUtil.getString(context, LocaleUtil.ATTACH_MIXING_BOWL)!,
                                                    textAlign: TextAlign.center,
                                                    style: textStyle_size_20_color_white()),
                                              ),
                                              Visibility(
                                                visible:  executionSent,
                                                child: Padding(
                                                  padding:  EdgeInsets.only(bottom: 20.h),
                                                  child: Image(
                                                      height: 218.h,
                                                      width: 235.w,
                                                      image: AssetImage(ImagePath.MIXER_ILLUSTRATION)),
                                                ),
                                              ),
                                              CloudActionButton(
                                                stepIndex: widget.stepIndex,
                                                userId: state.userId,
                                                executionSent: executionSent,
                                                toggleExecutionSent: toggleExecutionSent,
                                                buttonText: LocaleUtil.getString(context, LocaleUtil.SEND_TO_MIXER)!,
                                                altText: LocaleUtil.getString(context, LocaleUtil.SENT_TO_MIXER)!,
                                                indexTracker: widget.indexTracker,
                                                applianceString: applianceStringForRequest,
                                                mixerIsIdle: cubitState.contentModel?.isIdle,
                                              ),
                                            ]),
                                          ),
                                        ),
                                        Visibility(
                                          visible: currentStep.tip != null,
                                          child: RecipeTipCard(tip: currentStep.tip ?? "tip"),
                                        ),
                                        SizedBox(
                                          height: 60.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: FullWidthButton(text: LocaleUtil.getString(context, LocaleUtil.NEXT)?.toUpperCase() ?? "",
                              callback: () {                                                          
                                  BlocProvider.of<RecipeStepsCubit>(context).advanceToNextStepArchetype(
                                      context,
                                      widget.stepIndex,
                                      state.recipe,
                                      widget.indexTracker);                              
                              }
                            )
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        }
    );
  }
}
