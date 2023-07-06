import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/control/stand_mixer_control_cubit.dart';
import 'package:smarthq_flutter_module/cubits/control/toaster_oven_control_cubit.dart';
import 'package:smarthq_flutter_module/cubits/erd_cubit.dart';
import 'package:smarthq_flutter_module/cubits/recipe_steps_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/control/stand_mixer_control_model.dart';
import 'package:smarthq_flutter_module/models/control/toaster_oven_control_model.dart';
import 'package:smarthq_flutter_module/models/recipe.dart';
import 'package:smarthq_flutter_module/resources/erd/ERD.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x922F.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/stand_mixer_erd_parser.dart';
import 'package:smarthq_flutter_module/services/erd_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_tip_card.dart';
import 'package:smarthq_flutter_module/view/recipes/common/recipe_up_next_card.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class CircleTimerAndCards extends StatefulWidget {
  final String? nextStep;
  final Steps currentStep;
  Function() timerCompleteCallback;
  Function cheatSheetCallback;
  final int timerStartTime;
  List<bool> indexTracker;
  int stepIndex;
  String stateText;
  Recipe recipe;
  ApplianceType applianceType;
  
  CircleTimerAndCards(
      {required this.timerCompleteCallback, this.nextStep, required this.currentStep, required this.cheatSheetCallback, required this.timerStartTime, required this.indexTracker, required this.stepIndex, required this.stateText, required this.recipe, required this.applianceType});

  @override
  State<CircleTimerAndCards> createState() => _CircleTimerAndCardsState();
}

class _CircleTimerAndCardsState extends State<CircleTimerAndCards> with TickerProviderStateMixin{
  String? nextStep;
  bool timerComplete = false;
  late AnimationController _animationController;
  late int timerSecRemaining;
  Timer? timer;
  bool timerPaused = false;
  bool hasNavigated = false;
  bool cookCanceled = false;

  void pauseTimer() {
    _animationController.stop();
    BlocProvider.of<RecipeStepsCubit>(context).pauseTimer();
    setState(() {
      timerPaused = true;
    });
  }
  
  void _cancelCook() {
    setState(() {
      cookCanceled = true;
    });
    if(widget.applianceType == ApplianceType.TOASTER_OVEN){
      BlocProvider.of<ToasterOvenControlCubit>(context).cancelBake();
    } else if(widget.applianceType == ApplianceType.STAND_MIXER){
      BlocProvider.of<StandMixerControlCubit>(context).cancelMix();
    }
  }
  
  void resumeTimer(){
    if(timerComplete){
      _animationController.reset();
      _animationController.forward();
    } else {
      _animationController.repeat();      
    }
    BlocProvider.of<ErdCubit>(context).postErd(ApplianceErd.STAND_MIXER, ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS, StandMixerAction.setSpeed, widget.currentStep.mixerSpeed.toString(), commit: false);
    BlocProvider.of<ErdCubit>(context).postErd(ApplianceErd.STAND_MIXER, ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS, StandMixerAction.setTimerSetValue, (timerSecRemaining).toString());
    setState((){
      timerPaused = false;
    });
  }

  Future<void> _get9305() async {
  StandMixerContentModel? _contentModel = BlocProvider.of<StandMixerControlCubit>(context).state.contentModel;
    if(_contentModel == null){
      return;
    }
    //Needs to use setstate to update the animationController
    setState(() {
        timerPaused = _contentModel.mixerState == CycleState.paused;
        if(_contentModel.mixerState == CycleState.mixing){
            _animationController.repeat();
        }
        if(_contentModel.mixerState == CycleState.paused){
            _animationController.stop();
        }
    });
  }


  void showTipDialog(){
    late String _tipHeader;
    switch(widget.applianceType) {
      case ApplianceType.STAND_MIXER :
        _tipHeader = LocaleUtil.BEFORE_MIXING;
        break;
      default :
        _tipHeader = LocaleUtil.REMINDER;
    }
      showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Padding(
              padding:  EdgeInsets.only(bottom: 6.0.h),
              child: Text(LocaleUtil.getString(context, _tipHeader)!, style: textStyle_size_16_semi_bold_color_black()),
            ),
            content: Text(widget.currentStep.tip.toString(), style: textStyle_size_14_color_grey_spaced(),),
            actions: [
              CupertinoDialogAction(child: Text(LocaleUtil.getString(context, LocaleUtil.GOT_IT)!), onPressed: () {
                Navigator.of(context).pop();
              },
                textStyle: textStyle_size_16_bold_color_deep_purple(),
              )
            ],
          ));
  }

  int calcMin() {
    print(timerSecRemaining);
    if (timerSecRemaining < 60){
      return 1;
    }
    else
      return ((timerSecRemaining) ~/ 60) + 1;
  }

  @override
  void initState() {
    if(widget.timerStartTime == 0){
      timerSecRemaining = -1;
    } else {
      timerSecRemaining = widget.timerStartTime;
    }
    super.initState();
    _animationController = AnimationController(vsync: this);
       if(widget.currentStep.tip != null){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTipDialog();
      });
    }
  }

  @override void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _get922F(String value) {
    var _erd0x922f = ERD0x922F(value);
    timerSecRemaining = _erd0x922f.remainingCookTimeSeconds;
    if(timerSecRemaining == 0){
        timerComplete = true;
    } else {
        timerComplete = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StandMixerControlCubit, StandMixerControlState> (
            listener: (context, state) {
              if(mounted && widget.applianceType == ApplianceType.STAND_MIXER && state.erdState == StandMixerErdState.loaded){
                _get922F(state.cache![ERD.TOASTER_OVEN_COOK_TIME_REMAINING]!);
                _get9305();
              }
            }
        ),
        BlocListener<ToasterOvenControlCubit, ToasterOvenControlState> (
            listener: (context, state) {
              if(mounted && widget.applianceType == ApplianceType.TOASTER_OVEN && state.erdState == ToasterOvenErdState.loaded){
                _get922F(state.cache![ERD.TOASTER_OVEN_COOK_TIME_REMAINING]!);
                geaLog.debug("STATE : ${state.cache![ERD.TOASTER_OVEN_CURRENT_STATE]} && SEC: $timerSecRemaining");
                if(state.cache![ERD.TOASTER_OVEN_CURRENT_STATE] != "03" && timerSecRemaining > 10) {
                  BlocProvider.of<RecipeStepsCubit>(context).advanceToNextStepArchetype(
                      context,
                      widget.stepIndex - 1,
                      widget.recipe,
                      BlocProvider.of<RecipeStepsCubit>(context).getUpdatedIndexTracker(widget.recipe, widget.stepIndex -1, resetBake: true)
                  );
                }
              }
            }
        ),
      ],
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 60,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 85.h),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.45,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Lottie.asset(
                        timerComplete 
                        ? ImagePath.LOTTIE_MIXING_COMPLETE 
                        : ImagePath.LOTTIE_MIXING_COUNTDOWN,
                        width: MediaQuery.of(context).size.height * 0.5,
                        height: MediaQuery.of(context).size.height * 0.5,
                        controller: _animationController,
                        onLoaded: (composition){
                          _animationController..duration = composition.duration;
                          if(timerComplete){
                            _animationController.reset();
                            _animationController.forward();
                          } else if(timerPaused){
                            _animationController.stop();
                          } else {
                            _animationController.repeat();
                          }
                        }
                    ),
                    Center(
                      child: Column(
                        children: [
                          Spacer(flex: 10),
                          Text(timerComplete 
                          ? LocaleUtil.getString(context, widget.stateText)!.toLowerCase() 
                          : LocaleUtil.getString(context, LocaleUtil.ABOUT)!,
                              style: textStyle_size_16_light_color_grey()),
                          Spacer(),
                          timerComplete
                              ? Text(LocaleUtil.getString(context, LocaleUtil.COMPLETE)!.toUpperCase(),
                              style: textStyle_size_36_color_white())
                              : timerSecRemaining == -1 ? SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ) : Row(
                            children: [
                              Spacer(flex: 10),
                        
                              Text("${calcMin()}",
                                style: textStyle_bold_size_36_color_white(),
                              ),
                              Spacer(),
                              Text(LocaleUtil.getString(context, LocaleUtil.MIN)!.toLowerCase(),
                                style: textStyle_size_36_color_white(),
                              ),
                              Spacer(flex: 10),
                            ],
                          ),
                          Spacer(),
                          Text(timerComplete ? "" : LocaleUtil.getString(context, LocaleUtil.REMAINING)!,
                              style: textStyle_size_16_light_color_grey()),
                          Spacer(flex: 10)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.355
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20.h),
                      !timerComplete ?  cookCancelButton(context, LocaleUtil.getString(context, LocaleUtil.CANCEL)!, cookCanceled, _cancelCook) : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 20.h),
                        child: RecipeUpNextCard(nextStep: widget.nextStep!, cheatSheetCallback: () => widget.cheatSheetCallback(),),),
                    Visibility(
                      visible: widget.currentStep.tip != null,
                      child: GestureDetector(
                        onTap: showTipDialog,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: RecipeTipCard(tip: widget.currentStep.tip))),
                    ),
                    SizedBox(height: 60.h)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget cookCancelButton(BuildContext context, String buttonText, bool buttonPressed, Function cancelCook) {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w))),
          backgroundColor: buttonPressed
              ? MaterialStateProperty.all(colorOldSilver())
              : MaterialStateProperty.all(colorDeepPurple()),
        ),
        onPressed: () {
          cancelCook();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.0.w),
          child: Text(buttonText,
              style: textStyle_size_16_bold_color_white()
          ),
        ),
      )
  );
}
