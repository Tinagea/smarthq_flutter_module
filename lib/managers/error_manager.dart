
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/common_widget/custom_alert_popup.dart' as popup;

class RecipeErrorManager {

  RecipeErrorManager._();
  static final RecipeErrorManager _instance = RecipeErrorManager._();
  factory RecipeErrorManager() {
    return _instance;
  }

  void handleError(String error, BuildContext? context) {

     ActionableError _actionable = ActionableError.fromError(error.toLowerCase());
     geaLog.debug("ErrorManager: handleError: Message: ${_actionable.message} Action: ${_actionable.action}  ");
      _actionable.handle(
        action: _actionable.action,
        context: context,
        route: _actionable.route,
        message: _actionable.message,
      );
  }
}

enum ErrorAction {
  none,
  pushToRoute,
  standMixerNeedsRemoteMode,
}

class ActionableError {
  final String error;
  final ErrorAction action;
  final String? message;
  final String? route;

  ActionableError({
    required this.error,
    required this.action,
    this.message,
    this.route,
  });

    factory ActionableError.fromError(String error) {
    switch (error) {
      case RecipeErrorStrings.APPLIANCE_REMOTE_ENABLED_REQUIRED:
        return ActionableError(
          error: error,
          action: ErrorAction.standMixerNeedsRemoteMode,
        );
      case RecipeErrorStrings.APPLIANCE_DOES_NOT_SUPPORT_REQUIRED_CAPABILITIES:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_RECIPE_NOT_SUPPORTED)!,
        );
      case RecipeErrorStrings.APPLIANCE_REQUIRED_CAPABILITY_NOT_SUPPORTED:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_RECIPE_NOT_SUPPORTED)!);
      case RecipeErrorStrings.INVALID_APPLIANCE_TYPE:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_RECIPE_NOT_SUPPORTED)!);
      case RecipeErrorStrings.INSTRUCTION_NOT_FOUND:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_TRY_AGAIN)!);
      case RecipeErrorStrings.STEPINDEX_IS_OUT_OF_BOUNDS:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_TRY_AGAIN)!);
      case RecipeErrorStrings.INVALID_STEPINDEX:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_TRY_AGAIN)!);
      case RecipeErrorStrings.APPLIANCE_FOOD_NOT_DETECTED:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_APPLIANCE_FOOD_NOT_DETECTED)!);
      case RecipeErrorStrings.APPLIANCE_MICROWAVE_DOOR_IS_OPEN:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_MICROWAVE_DOOR_IS_OPEN)!);
      case RecipeErrorStrings.APPLIANCE_ADVANTIUM_DOOR_IS_OPEN:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_ADVANTIUM_DOOR_IS_OPEN)!);
      case RecipeErrorStrings.APPLIANCE_MICROWAVE_ALREADY_ON:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_MICROWAVE_IS_RUNNING)!);      
      case RecipeErrorStrings.APPLIANCE_ADVANTIUM_ALREADY_ON:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_ADVANTIUM_IS_RUNNING)!);
      case RecipeErrorStrings.APPLIANCE_OVEN_CAVITY_INVALID:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_INVALID_OVEN_CAVITY)!);
      case RecipeErrorStrings.CAVITY_MUST_NOT_BE_SET_ON_A_SINGLE_CAVITY_OVEN:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_INVALID_SINGLE_OVEN_CAVITY)!);
      case RecipeErrorStrings.INVALID_CAVITY:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_INVALID_CAVITY)!);            
      case RecipeErrorStrings.APPLIANCE_STATE_MODIFICATION_UNSUPPORTED:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_UNSUPPORTED_REQUEST)!);    
      case RecipeErrorStrings.APPLIANCE_STANDMIXER_CHANGES_RESTRICTED_WHILE_ACTIVE:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_MIXER_ACTIVE)!); 
      case RecipeErrorStrings.APPLIANCE_OFFLINE:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_APPLIANCE_OFFLINE)!);                       
      case RecipeErrorStrings.APPLIANCE_IS_OFFLINE:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_REASON_APPLIANCE_OFFLINE)!);                                     
      default:
        return ActionableError(
          error: error,
          action: ErrorAction.none,
          message: LocaleUtil.getString(
              ContextUtil.instance.context!,
              LocaleUtil.ERROR_DEFAULT)!,
        );
    }
  }

  void handle({required ErrorAction action, String? route, BuildContext? context, String? message}) {
    switch (action) {
      case ErrorAction.none:
        showErrorPopup(context, message ?? "");
        break;
      case ErrorAction.pushToRoute:
        showErrorPopup(context, message ?? "");
        if (route != null) {
          Navigator.of(context ?? ContextUtil.instance.routingContext!).pushNamedAndRemoveUntil(
              route, (Route<dynamic> route) => false);
        }
        break;
      case ErrorAction.standMixerNeedsRemoteMode:
         showDialog(
          context: context ?? ContextUtil.instance.routingContext!,
          builder: (BuildContext context) {
            return popup.StandMixerAlertDialog(
              title: LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_SET_TO_REMOTE_ENABLED_POPUP)!,
              bodyText: "",
              imageSize: Size(220.w, 220.h),
              buttonActions: [popup.StandMixerAlertPopupAction(title: "OK", action: (){
              })],
              imageUri: ImagePath.STAND_MIXER_REMOTE_ENABLE,
            );
          },
        );
        break;
      case ErrorAction.none:
        break;
    }
    
  }

  void showErrorPopup(BuildContext? context, String message){
       showDialog(
      context: context ?? ContextUtil.instance.routingContext!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Text("SmartHQ", style: textStyle_size_18_color_black())),
          content: Text(message),
          actions: <Widget>[
             CupertinoDialogAction(child: Text(LocaleUtil.getString(context, LocaleUtil.OK)!), onPressed: () {
                  Navigator.of(context).pop();
              },
              textStyle: textStyle_size_16_semi_bold_color_dark_grey(),
            ),
          ],
        );
      },
    );
  }
}

class RecipeErrorStrings {
  
  static const String APPLIANCE_REMOTE_ENABLED_REQUIRED = "appliance remote enabled required";
  static const String APPLIANCE_DOES_NOT_SUPPORT_REQUIRED_CAPABILITIES = "device does not support the required capabilities of any instruction";
  static const String APPLIANCE_REQUIRED_CAPABILITY_NOT_SUPPORTED = "a required capability is not supported on this device";
  static const String INVALID_APPLIANCE_TYPE = "invalid appliance type";
  static const String INSTRUCTION_NOT_FOUND = "instruction not found";
  static const String STEPINDEX_IS_OUT_OF_BOUNDS = "stepindex is out of bounds";
  static const String INVALID_STEPINDEX = "invalid stepindex";
  static const String APPLIANCE_FOOD_NOT_DETECTED = "appliance food not detected";
  static const String APPLIANCE_MICROWAVE_DOOR_IS_OPEN = "appliance microwave door is open";
  static const String APPLIANCE_ADVANTIUM_DOOR_IS_OPEN = "appliance advantium door is open";
  static const String APPLIANCE_MICROWAVE_ALREADY_ON = "appliance microwave already on";
  static const String APPLIANCE_ADVANTIUM_ALREADY_ON = "appliance advantium already on";
  static const String APPLIANCE_OVEN_CAVITY_INVALID = "appliance oven cavity invalid";
  static const String CAVITY_MUST_NOT_BE_SET_ON_A_SINGLE_CAVITY_OVEN = "cavity must not be set on a single cavity oven";
  static const String INVALID_CAVITY = "invalid cavity";
  static const String APPLIANCE_STATE_MODIFICATION_UNSUPPORTED = "appliance state modification unsupported";
  static const String APPLIANCE_STANDMIXER_CHANGES_RESTRICTED_WHILE_ACTIVE = "appliance standmixer changes restricted while active";
  static const String APPLIANCE_OFFLINE = "appliance offline";
  static const String APPLIANCE_IS_OFFLINE = "appliance is offline";

}