import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/cubits/stand_mixer_cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/managers/error_manager.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9300.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/0x9305.dart';
import 'package:smarthq_flutter_module/resources/erd/stand_mixer/stand_mixer_erd_parser.dart';
import 'package:smarthq_flutter_module/resources/erd/toaster_oven/0x9209.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/control/common_widget/custom_alert_popup.dart';
import 'package:smarthq_flutter_module/view/recipes/common/ApplianceBusyPopup.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class CloudActionButton extends StatefulWidget {
  int stepIndex;
  String userId;
  bool executionSent;
  Function? toggleExecutionSent;
  String buttonText;
  String? altText;
  List<bool> indexTracker;
  bool isFinish;
  String applianceString;
  bool busyPopupCanSendSettings;
  bool? mixerIsIdle;

  CloudActionButton({
    required this.stepIndex, 
    required this.userId, 
    this.executionSent = false, 
    this.toggleExecutionSent, 
    required this.buttonText, 
    this.altText, 
    required this.indexTracker,
    this.isFinish = false,
    required this.applianceString,
    this.busyPopupCanSendSettings = true,
    this.mixerIsIdle
  });

  @override
  State<CloudActionButton> createState() => _CloudActionButtonState();
}

class _CloudActionButtonState extends State<CloudActionButton> {
  late ApplianceType _applianceType = ApplianceType.UNDEFINED;
  late String _titleTypeString = "";
  late String _actionTypeString = "";
  late var _applianceCubit;
  bool _cancelForNewSettings = false;

  void setErd(String erdAddress, String value, bool settingNewSettings) {
    _applianceCubit.postErd(erdAddress, value);
    if(settingNewSettings){
      setState(() {
        _cancelForNewSettings = true;
      });
    }
  }

  void _setApplianceSpecifics(){
    switch(widget.applianceString) {
      case ApplianceStrings.ToasterOven :
        _applianceType = ApplianceType.TOASTER_OVEN;
        _titleTypeString = LocaleUtil.getString(context, LocaleUtil.OVEN)!.toUpperCase();
        _actionTypeString = LocaleUtil.getString(context, LocaleUtil.COOKING)!.toUpperCase();
        _applianceCubit = BlocProvider.of<ToasterOvenControlCubit>(context);
        break;
      case ApplianceStrings.StandMixer :
        _applianceType = ApplianceType.STAND_MIXER;
        _titleTypeString = "${LocaleUtil.getString(context, LocaleUtil.MIXER)!.toUpperCase()}";
        _actionTypeString = "${LocaleUtil.getString(context, LocaleUtil.MIXING)!.toUpperCase()}";
        _applianceCubit = BlocProvider.of<StandMixerControlCubit>(context);
        break;
      default:
        _applianceType = ApplianceType.UNDEFINED;
        _titleTypeString = LocaleUtil.getString(context, LocaleUtil.APPLIANCE)!.toUpperCase();
        _actionTypeString = LocaleUtil.getString(context, LocaleUtil.ACTION)!.toUpperCase();
    }
    _applianceCubit.requestCache();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  didChangeDependencies(){
    super.didChangeDependencies();
    _setApplianceSpecifics();
  }

  Future<void> sendCloudAction() async {
    ApplianceType? appliance = BlocProvider.of<ApplianceCubit>(context).state.applianceType;
    final recipeStepsCubit = BlocProvider.of<RecipeStepsCubit>(context);
    if(appliance == ApplianceType.STAND_MIXER) {
      final standMixerCubit = BlocProvider.of<StandMixerControlCubit>(context);
      bool isOn = standMixerCubit.state.contentModel?.mixerMode != MixerMode.MIXER_OFF.toFormatted();
      if (!isOn){
        showSwitchModeDialog();
        return;
      }
      String? state = standMixerCubit.state.contentModel?.mixerState;
      if(state == CycleState.mixing || state == CycleState.paused){
        RecipeErrorManager().handleError("appliance standmixer changes restricted while active", context);
        return;
      } 
      if(standMixerCubit.state.presence == DevicePresence.offline){
        RecipeErrorManager().handleError("appliance is offline", context);
        return;
      }   
    }
    if(appliance == ApplianceType.TOASTER_OVEN){
      final toasterOvenCubit = BlocProvider.of<ToasterOvenControlCubit>(context);
      if(toasterOvenCubit.state.presence == DevicePresence.offline){
        RecipeErrorManager().handleError("appliance is offline", context);
        return;
      }
    }
    widget.indexTracker[widget.stepIndex] = true;
    recipeStepsCubit.advanceCloudIndex(
      widget.stepIndex,
      context,
      widget.applianceString,
      isFinishedOrQuit: widget.isFinish);
        
    if (widget.toggleExecutionSent != null){
      widget.toggleExecutionSent!();
    } else {
      widget.executionSent = true;
    }
    if(widget.isFinish){
      BlocProvider.of<RecipeDetailsCubit>(context).clearState();
      BlocProvider.of<StandMixerControlCubit>(context).clearRecipeStatus();
    }
  }
  
  Future<void> handleCloudActionButtonPressed() async {
    ApplianceType? appliance = BlocProvider.of<ApplianceCubit>(context).state.applianceType;
    if( appliance == ApplianceType.STAND_MIXER) {
      bool isOn = await BlocProvider.of<RecipeStepsCubit>(context).isApplianceInRemoteEnabled();
      if (!isOn){
        showSwitchModeDialog();
        return;
      }
    }
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Padding(
          padding:  EdgeInsets.only(bottom: 6.0.h),
          child: Text(LocaleUtil.getString(context, LocaleUtil.STEP_COMPLETED)!.toUpperCase(), style: textStyle_size_18_color_black(),),
        ),
        content: Text(LocaleUtil.getString(context, LocaleUtil.STEP_ALREADY_COMPLETE)!, style: textStyle_size_14_color_grey_spaced(),),
        actions: [
          CupertinoDialogAction(child: Text(LocaleUtil.getString(context, LocaleUtil.NO)!), onPressed: () {
            Navigator.of(context).pop();
            },
            textStyle: textStyle_size_16_semi_bold_color_dark_grey(),
          ),
          CupertinoDialogAction(child: Text(LocaleUtil.getString(context, LocaleUtil.YES)!), onPressed: () {
            sendCloudAction();
            Navigator.of(context).pop();
            },
            textStyle: textStyle_size_16_bold_color_deep_purple(),
          )
        ],
      ));
  }

    void showSwitchModeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_SET_TO_REMOTE_ENABLED_POPUP)!,
          bodyText: "",
          imageSize: Size(220.w, 220.h),
          buttonActions: [AlertPopupAction(title: "OK", action: (){
          })],
          imageUri: ImagePath.STAND_MIXER_REMOTE_ENABLE,
        );
      },
    );
  }
  
  void showApplianceBusyPopup(){
    showDialog(
        context: context, 
        builder: (BuildContext context) => 
          ApplianceBusyPopup(
            sendNewSettings: sendCloudAction, 
            applianceType: _applianceType, 
            titleTypeString: _titleTypeString, 
            actionTypeString: _actionTypeString,
            setErd: setErd, 
            hasSendSettings: widget.busyPopupCanSendSettings,
            mixerIsIdle: widget.mixerIsIdle ?? false,
          ),
    );
  }
  
  bool _isApplianceRunning() {
    String? _jid = BlocProvider.of<RecipeStepsCubit>(context).getJid() ?? "";
    switch (_applianceType) {
      case ApplianceType.TOASTER_OVEN : {
        switch (BlocProvider.of<ToasterOvenControlCubit>(context).getToasterOvenCurrentState()) {
          case ToasterOvenCurrentState.TOASTER_OVEN_COOKING : 
          case ToasterOvenCurrentState.TOASTER_OVEN_PREHEATING :
          case ToasterOvenCurrentState.TOASTER_OVEN_TEMPERATURE_ACHIEVED : 
            return true;
          default:
            return false;
        }
      }
      case ApplianceType.STAND_MIXER : {
        return BlocProvider.of<StandMixerControlCubit>(context).getIsRunning(_jid);
      }
      default :
        return false;
    }
  }

  /// The function is never called
  void _showMixerError() async {
    MixerState? state = await BlocProvider.of<RecipeStepsCubit>(context).getStandMixerState();
    if(state == MixerState.MIXER_MIXING || state == MixerState.MIXER_PAUSED){
      RecipeErrorManager().handleError("appliance standmixer changes restricted while active", context);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool cloudActionTaken = widget.indexTracker[widget.stepIndex];
    if(widget.mixerIsIdle != null && widget.mixerIsIdle! && _cancelForNewSettings){
      sendCloudAction();
      _cancelForNewSettings = false;
    }
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.w))),
            backgroundColor: widget.executionSent || widget.indexTracker[widget.stepIndex]
                ? MaterialStateProperty.all(colorOldSilver())
                : MaterialStateProperty.all(colorDeepPurple()),
        ), 
          onPressed: () {
            if(cloudActionTaken){
              handleCloudActionButtonPressed();
            } else {
              if(_isApplianceRunning()){
                  showApplianceBusyPopup();
              } else {
                sendCloudAction();
              }
            }
        },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.0.w),
            child: Text(widget.executionSent || widget.indexTracker[widget.stepIndex] == true 
            ? widget.altText != null 
            ? widget.altText! 
            : widget.buttonText 
            : widget.buttonText,
                style: textStyle_size_16_bold_color_white()
            ),
          ),
        )
    );
  }
}