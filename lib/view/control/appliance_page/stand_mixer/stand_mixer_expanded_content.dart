import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/cubits/control/stand_mixer_control_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';
import 'package:smarthq_flutter_module/services/erd_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_style_model.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_widget.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_ball_widget.dart' as sliderBall;
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/stand_mixer_add_timer_page.dart';
import 'package:smarthq_flutter_module/view/control/common_widget/custom_alert_popup.dart';

enum ButtonMethod {
  add,
  minus
}

class StandMixerExpandedContent extends StatefulWidget {
  final StandMixerContentModel? contentModel;

  const StandMixerExpandedContent({Key? key,
    this.contentModel}) : super(key: key);

  @override
  State<StandMixerExpandedContent> createState() => _StandMixerExpandedContentState(
      contentModel: this.contentModel
  );
}

class _StandMixerExpandedContentState extends State<StandMixerExpandedContent> {
  static const String tag = "StandMixerExpandedContent:";
  
  StandMixerContentModel? _contentModel;

  _StandMixerExpandedContentState({
    StandMixerContentModel? contentModel}) {
    _contentModel = contentModel;
  }

  bool _shouldSendSpeedValueWhileMixing = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setContentModel(){
    setState(() {
      _contentModel = widget.contentModel;
    });
  }

  @override
  void didUpdateWidget(covariant StandMixerExpandedContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contentModel != widget.contentModel) {
      setContentModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_contentModel == null) {
      return Container();
    } else {
      return Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 15.0.w, left: 15.0.w),
                child: Container(
                  child: _activeStirSwitch(context, ((_mixSpeedVal == '1') ? (_contentModel?.isActiveStirEnabled ?? false) : null))),
              )
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 15.0.w, right: 15.0.w),
                child: _reverseSwitch(context, _contentModel!),
              )
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 45.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _minusButton(context, _contentModel!),
                    _horseShoeSlider(context, _contentModel!),
                    SizedBox(
                      height: 200.h,
                      child: Stack(
                        children: [
                          _addButton(context, _contentModel!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _shouldHideTimer(context, _contentModel!) ? Container() : _timerSection(context, _contentModel!),
              _sendToMixerButton(context, _contentModel!),
            ],
          ),
        ],
      );
    }
  }

  Widget _minusButton(BuildContext context, StandMixerContentModel model) {
    return  Container(
      margin: EdgeInsets.only(left: 20.w),
      child: IconButton(
        disabledColor: Colors.grey,
        iconSize: 50,
        color: Colors.white,
        onPressed: (){
          _handleTap(context,
            ButtonMethod.minus,
            model);
          },
        icon: const Icon(Icons.remove),
      ),
    );
  }

  Widget _horseShoeSlider(BuildContext context, StandMixerContentModel model) {
    return Stack(
      children: [
        GestureDetector(
          onHorizontalDragStart: ((event) {
            _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(model: model, shouldScroll: false);
          }),
          onHorizontalDragEnd: ((event){
            _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(model: model, shouldScroll: true);
          }),
          onVerticalDragStart: ((event) {
            _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(model: model, shouldScroll: false);
          }),
          onVerticalDragEnd: ((event){
            _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(model: model, shouldScroll: true);
          }),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: CircleSliderWidget(
              style: CircleSliderStyleModel.sweepGradient(
                isFilled: model.isRunning ?? StandMixerStateDefaultValue.isRunning,
                outlineColor: [
                  Colors.transparent,
                ],
                valueColor: [
                  colorBrilliantAzure(),
                  colorDeepPurple(),
                ],
                glow: CircleSliderGlow(
                  duration: const Duration(milliseconds: 1200),
                  min: 1.5,
                  max: 5,
                ),
              ),
            value: model.currentSliderValue ?? StandMixerStateDefaultValue.currentSliderValue,
            ball: sliderBall.CircleSliderBallWidget.circular(
              radius: 17.5,
            ),
            diameter: 170,
            thickness: 15,
            startAngle: 240,
            endAngle: 300,
            isRunning: model.isRunning ?? StandMixerStateDefaultValue.isRunning,
            centerChild: FittedBox(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  _mixSpeedVal == '1' ? LocaleUtil.getString(context, LocaleUtil.STIR)! : _mixSpeedVal,
                  key: ValueKey<String>(_mixSpeedVal),
                  style: textStyle_size_64_bold_color_white()
                ),
              ),
            ),
            onChanged: (value) {
              _handleSliderChanged(context, value, model);
            },),
          ),
        ),
        Positioned.fill(
          bottom: 18.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  "${model.mixerState.toString().split('_').last.substring(0, 1)}${model.mixerState.toString().split('_').last.substring(1).toLowerCase()}",
                  textAlign: TextAlign.center,
                  style: textStyle_size_16_bold_color_white()
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reverseSwitch(BuildContext context, StandMixerContentModel model) {
    bool? isReversed = model.isReversed ?? StandMixerStateDefaultValue.isReversed;
    if (model.isActiveStirEnabled != null && model.isActiveStirEnabled!){
      isReversed = null;
    }
    String _label = LocaleUtil.REVERSE;
    Color _thumbColor = model.availableModifications!.direction == false ? Colors.grey : Colors.white;
    Color _trackColor = model.availableModifications!.direction == false ?  Colors.grey : Colors.transparent;
    
    void _onChanged(bool val)  {
      if(model.availableModifications == null){
        return;
      }
      if(model.availableModifications!.direction == true) {
        setState(() {
          _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(
              model: _contentModel,
              isReversed: val,
              directionValue: val ? 2: 1);
        });
        _onToggleMixerDirection(context, _contentModel!);
      }
    }
    
    return reusableSwitch(isReversed, _label, _thumbColor, _trackColor, _onChanged, false, (){}, false);
  }
  
  Widget _activeStirSwitch(BuildContext context, bool? activeStirOn){
    String _label = LocaleUtil.ACTIVE_STIR;
    Color _thumbColor = Colors.grey;
    Color _trackColor = Colors.transparent;
    if(activeStirOn != null){
      _trackColor = activeStirOn ?  Colors.grey : Colors.transparent;
      _thumbColor = Colors.white;
    }
    void _onChanged(bool isSwitchEnabled) {
      if(activeStirOn == true && isSwitchEnabled == false && _contentModel?.isRunning == true){
        _onCancelMixing();
      }
      if(isSwitchEnabled && _contentModel?.isRunning == true && _mixSpeedVal == '1'){
        BlocProvider.of<StandMixerControlCubit>(context).sendStartActiveStir();
        BlocProvider.of<StandMixerControlCubit>(context).saveTimeStampToLocalStorage("AA:${DateTime.now().toIso8601String()}");
      }
      setState(() {
        _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(
            model: _contentModel,
            isActiveStirEnabled: isSwitchEnabled
        );
      });
    }
    void _showDialog(bool isDisabled) {
      showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Padding(
              padding:  EdgeInsets.only(bottom: 6.0.h),
              child: Text(LocaleUtil.getString(context, isDisabled ? LocaleUtil.ACTIVE_STIR_DEACTIVATED : LocaleUtil.ACTIVE_STIR)!, style: textStyle_size_16_semi_bold_color_black()),
            ),
            content: Text(LocaleUtil.getString(context, isDisabled ? LocaleUtil.ACTIVE_STIR_DEACTIVATED_INFO : LocaleUtil.ACTIVE_STIR_INFO)!, style: textStyle_size_14_color_grey_spaced(),),
            actions: [
              CupertinoDialogAction(child: Text(LocaleUtil.getString(context, LocaleUtil.OK)!), onPressed: () {
                Navigator.of(context).pop();
              },
                textStyle: textStyle_size_16_bold_color_deep_purple(),
              )
            ],
          ));
    }
    
    bool infoPopUpVisible = activeStirOn != null ? !activeStirOn : true;
    
    return activeStirOn == null ?
        Stack(
          children: [
            reusableSwitch(activeStirOn, _label, _thumbColor, _trackColor, _onChanged, infoPopUpVisible, _showDialog, true), 
            InkWell(
                onTap: () { _showDialog(true);}, 
                child: SizedBox(
                  height: 100.h, 
                  width: 60.w,
                )
            )
          ],
        ) :
    reusableSwitch(activeStirOn, _label, _thumbColor, _trackColor, _onChanged, infoPopUpVisible, _showDialog, true);
  }
  
  Widget reusableSwitch(bool? isOn, String label, Color thumbColor, Color trackColor, Function onChanged, bool hasInfoPopup, Function popUpCallback, bool hasBetaTag){
    bool isOnNullChecked = false;
    if(isOn != null){
      isOnNullChecked = isOn;
    }
    return Opacity(
      opacity: isOn != null ? 1 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Stack(
              children: [
                RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: LocaleUtil.getString(context, label)!,
                            style: textStyle_size_13_color_spaced().apply(color: isOnNullChecked ? Colors.white : Colors.grey),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2.0),
                              child: SvgPicture.asset(
                                ImagePath.BETA_TAG_ICON,
                                width: hasBetaTag ? 25.w : 0
                              ),
                            )
                          ),
                          WidgetSpan(
                            child: hasInfoPopup ? 
                            Container(
                              height: 25.h,
                              width: 18.w,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () => {
                                  popUpCallback(false)
                                }, 
                                icon: Icon(Icons.info, color: colorDarkLiver(), size: 15.sp),
                              ),
                            ) : SizedBox(),
                          )
                        ]
                    )
                ),
              ],
            )
          ),
          Transform.scale(
            scale: 0.90,
            child: Container(
              decoration: BoxDecoration(
                color: isOnNullChecked ? colorDeepPurple() : Colors.transparent,
                border: Border.all(width: 1, color: isOnNullChecked ? colorDeepPurple() : Colors.grey),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Transform.scale(
                scale: 1.1,
                child: CupertinoSwitch(
                  value: isOnNullChecked,
                  thumbColor: thumbColor,
                  trackColor: trackColor,
                  onChanged: (val) {
                    if (isOn != null) {
                      onChanged(val);
                    }
                  },
                  activeColor: isOn != null ? colorDeepPurple() : Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addButton(BuildContext context, StandMixerContentModel model) {
    return Center(
      child: Container(
        margin:EdgeInsets.only(right: 20.w),
        child: IconButton(
          disabledColor: Colors.grey[800],
          iconSize: 50,
          color: Colors.white,
          onPressed: _mixSpeedVal == model.sliderMaxVal?.toInt().toString() || (model.isRunning ?? StandMixerStateDefaultValue.isRunning) ||  model.availableModifications!.speed == false
              ? null
              : () {
                  _handleTap(context, ButtonMethod.add, model);
                },
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _timerSection(BuildContext context, StandMixerContentModel model) {
    final timerSecRemaining = model.timerSecRemaining ?? StandMixerStateDefaultValue.timerSecRemaining;
    final isPaused = model.isPaused ?? StandMixerStateDefaultValue.isPaused;
    final isRunning = model.isRunning ?? StandMixerStateDefaultValue.isRunning;
    int timerMinRemaining = timerSecRemaining ~/ 60;
    return Stack(
      children: [
        Visibility(
          visible: timerSecRemaining == 0 && !isRunning && model.availableModifications!.timer == true && !isPaused,
          child: Container(
            child: TextButton(
              onPressed: () {
                if (!isRunning) {
                  final setValue = BlocProvider.of<StandMixerControlCubit>(context)
                      .getControlSettingsTimerSetValueWithoutCache();
                  final maxValue = setValue?.max ?? 0;
                  showAddTimerPage(context, _setTimerValue, maxValue, model);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: isRunning ? colorGrey() : colorDeepPurple(),
                    size: 20,
                  ),
                  Text(LocaleUtil.getString(context, LocaleUtil.ADD_TIMER)!,
                  textAlign: TextAlign.center,
                    style: (isRunning)? textStyle_size_18_bold_color_grey():
                    textStyle_size_18_bold_deep_purple()
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: timerSecRemaining != 0,
          child: Center(
            child: InkWell(
              onTap: () {
                if (!(isRunning || isPaused || model.availableModifications!.timer == false)) {
                  final setValue = BlocProvider.of<StandMixerControlCubit>(context)
                      .getControlSettingsTimerSetValueWithoutCache();
                  final maxValue = setValue?.max ?? 0;
                  showAddTimerPage(context, _setTimerValue, maxValue, model);
                }
              },
              child: Column(
                children: [
                  timerMinRemaining == 0
                      ? Text('< 1 ${LocaleUtil.getString(context, LocaleUtil.MIN)!}',
                          style: textStyle_size_16_bold_color_white(),
                        )
                      : Text('$timerMinRemaining ${LocaleUtil.getString(context, LocaleUtil.MIN)!}',
                          style: textStyle_size_16_bold_color_white(),
                        ),
                  Text(isRunning? LocaleUtil.getString(context, LocaleUtil.REMAINING)! : LocaleUtil.getString(context, LocaleUtil.MIX_TIMER)!,
                    style: textStyle_size_14_light_color_grey(),
                  ),
                ],
              ),
            ),
          )
        )
      ],
    );
  }

  Widget _sendToMixerButton(BuildContext context, StandMixerContentModel model) {
    final isPaused = model.isPaused ?? StandMixerStateDefaultValue.isPaused;
    final isRunning = model.isRunning ?? StandMixerStateDefaultValue.isRunning;
    final canChangeSendToMixer = BlocProvider.of<StandMixerControlCubit>(context).canChangeSendToMixer(model, _mixSpeedVal);
    return Container(
      width: double.infinity,
      margin:  EdgeInsets.symmetric(horizontal: 15.w),
      child: ElevatedButton(
        onPressed:  () {
          if (_mixSpeedVal != '0') {
            setState(() {
              if (isRunning) {
                BlocProvider.of<StandMixerControlCubit>(context).sendCyclePaused();
                showPressToResumeDialog(context);
              }
              else {
                sendStartMixData(context, model);
                showPressToStartDialog(context);
              }
            });
          }
        },
        child: Text(isRunning ? LocaleUtil.getString(context, LocaleUtil.PAUSE)!
            : (isPaused && !canChangeSendToMixer)
            ? LocaleUtil.getString(context, LocaleUtil.PAUSED)!
            : LocaleUtil.getString(context, LocaleUtil.SEND_TO_MIXER)!,
            style: textStyle_size_16_bold_color_white()
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          backgroundColor: _mixSpeedVal == '0' ? MaterialStateProperty.all(colorSpanishGray())
          : (isPaused && !canChangeSendToMixer) ? MaterialStateProperty.all(colorSpanishGray())
          : MaterialStateProperty.all(colorDeepPurple()),
        ),
      ),
    );
  }


  _setTimerValue(StandMixerContentModel model, int sec) {
    setState(() {
      _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(
          model: model,
          timerSecRemaining: sec);
    });
    _showBars(true);
  }

  void _showBars(bool show) {
    BlocProvider.of<StandMixerControlCubit>(context).showTopBar(show);
    BlocProvider.of<StandMixerControlCubit>(context).showBottomBar(show);
  }


  String get _mixSpeedVal {
    final double currentSliderValue = _contentModel?.currentSliderValue ?? StandMixerStateDefaultValue.currentSliderValue;
    final double sliderMaxVal = _contentModel?.sliderMaxVal ?? StandMixerStateDefaultValue.sliderMaxVal;

    var speedValue = (currentSliderValue * sliderMaxVal).toStringAsFixed(0);
    if (speedValue != '1') {
      setState(() {
        _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(
            model: _contentModel,
            isActiveStirEnabled: false
        );
      });
    }
        
    if (speedValue == '-0') return '0';
    return speedValue;
  }

  void _handleTap(BuildContext context, ButtonMethod method, StandMixerContentModel model) {
    geaLog.debug("$tag _handleTap");
    if(model.availableModifications == null){
      return;
    } 

    if(model.availableModifications!.speed == false) {
      geaLog.debug("$tag _handleTap speed is not available");
      return;
    }
    // ensures the slider will always reach the beginning/end point, regardless of value you are starting from
    final sliderMaxVal = model.sliderMaxVal ?? StandMixerStateDefaultValue.sliderMaxVal;
    final isRunning = model.isRunning ?? StandMixerStateDefaultValue.isRunning;
    double currentSliderValue = (double.parse(_mixSpeedVal) / sliderMaxVal);
    if (method == ButtonMethod.add) {
      currentSliderValue += (1 / sliderMaxVal);
      _mixSpeedVal;
      if (currentSliderValue > 0.985) {
        // does not allow slider ball from exceeding the slider end
        currentSliderValue = 0.985;
      }
    } else if (method == ButtonMethod.minus) {

      currentSliderValue -= (1 / sliderMaxVal);
      if (currentSliderValue <= 0.015) {
        // does not allow slider ball from exceeding the slider start
        currentSliderValue = 0.015;
      }
      if (isRunning) {
        //if the slider changes, wait 1 second before sending the new value to the mixer
          _mixSpeedVal;
          sendStartMixData(context, model, hideLoadingMessage: true, shouldWait: true);      
          }
    }

    if (model.currentSliderValue != currentSliderValue) {
      setState(() {
        _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(
            model: model,
            currentSliderValue: currentSliderValue);
      });
    }
  }

  void setErd(String erdAddress, String value) {
    BlocProvider.of<StandMixerControlCubit>(context).postErd(erdAddress, value);
  }

  Timer? _debounceTimer;
  void sendStartMixData(BuildContext context,StandMixerContentModel model,{ bool hideLoadingMessage = false, bool shouldWait = false }) {
    
    String speed = _mixSpeedVal;
    geaLog.debug("$tag sendStartMixData: Mix Speed Value -> $speed");
    _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(
        model: model,
        currentSliderValue: double.parse(speed)/11);

    if (shouldWait) {
       if (_debounceTimer != null) {
        _debounceTimer!.cancel();
      }
      _debounceTimer = Timer(Duration(milliseconds: 1500), () {
        BlocProvider.of<StandMixerControlCubit>(context).sendStartMixData(_mixSpeedVal, model.timerSecRemaining, model.directionValue);
      });
    } else {
      BlocProvider.of<StandMixerControlCubit>(context).sendStartMixData(_mixSpeedVal, model.timerSecRemaining, model.directionValue);
    }
  }

  bool _shouldHideTimer(BuildContext context, StandMixerContentModel model) {
    geaLog.debug("$tag _shouldHideTimer");
    final timerSecRemaining = model.timerSecRemaining ?? StandMixerStateDefaultValue.timerSecRemaining;
    if (timerSecRemaining > 0) {
      return false;
    }

    final isRunning = model.isRunning ?? StandMixerStateDefaultValue.isRunning;
    final isTimerChanged = BlocProvider.of<StandMixerControlCubit>(context).didChangeTimer(timerSecRemaining);
    if (isRunning && isTimerChanged) {
      return true;
    }

    return false;
  }

  void _onToggleMixerDirection(BuildContext context, StandMixerContentModel model) {
    // setErd(ERD.STAND_MIXER_CONTROL_REQUESTED_SETTINGS, model.directionValue.toString());
    if(_contentModel!.isRunning ?? false ){
    sendStartMixData(context, model, hideLoadingMessage: true);
    }
  }


  void _onCancelMixing() {
    setErd(ERD.TOASTER_OVEN_CANCEL_OPERATION, "01");
  }

  void _handleSliderChanged(BuildContext context, double value, StandMixerContentModel model) {
    final sliderMaxVal = model.sliderMaxVal ?? StandMixerStateDefaultValue.sliderMaxVal;
    final isPaused = model.isPaused ?? StandMixerStateDefaultValue.isPaused;
    final isRunning = model.isRunning ?? StandMixerStateDefaultValue.isRunning;
    final isIdle = model.isIdle ?? StandMixerStateDefaultValue.isIdle;
    if(model.availableModifications == null){
      return;
    }
    if(model.availableModifications!.speed == false) {
      geaLog.debug("$tag _handleTap speed is not available");
      return;
    }

    var val = (value * sliderMaxVal).toStringAsFixed(0);
    setState(() {
      if (isRunning) {
        if (int.parse(_mixSpeedVal) > int.parse(val)) {
          _shouldSendSpeedValueWhileMixing = true;
        }

        _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(
            model: model,
            currentSliderValue: value);
          if (_shouldSendSpeedValueWhileMixing) {
            sendStartMixData(context, model, hideLoadingMessage: true, shouldWait: true);
            _shouldSendSpeedValueWhileMixing = false;
          }
      }
      else {
        if (isPaused || isIdle ) {
          _contentModel = BlocProvider.of<StandMixerControlCubit>(context).setStateContentModel(
              model: model,
              currentSliderValue: value);
        }
      }
    });
  }

  void showPressToStartDialog(BuildContext context) {
    geaLog.debug("$tag showPressToStartDialog");
    showDialog(
        context: context,
        builder: (BuildContext context) => CustomAlertDialog(
          title: LocaleUtil.getString(context, LocaleUtil.PRESS_TO_START)!.toUpperCase(),
          bodyText: "",
          imageSize: Size(300.w, 300.h),
          imageUri: ImagePath.STAND_MIXER_START_ILLUSTRATION,
          fractionMultiplier: 0.85,
          buttonActions: [
            AlertPopupAction(title: LocaleUtil.getString(context, LocaleUtil.OK)!, action: () {}),
          ],
        )
    );
  }

  void showPressToResumeDialog(BuildContext context) {
    geaLog.debug("$tag showPressToResumeDialog");
    showDialog(
        context: context,
        builder: (BuildContext context) => CustomAlertDialog(
          title: LocaleUtil.getString(context, LocaleUtil.PRESS_TO_RESUME)!.toUpperCase(),
          titlePadding: EdgeInsets.only(top: 50.h),
          bodyText: "",
          imageSize: Size(280.w, 280.h),
          imageUri: ImagePath.STAND_MIXER_START_ILLUSTRATION,
          fractionMultiplier: 0.98,
          buttonActions: [
            AlertPopupAction(title: LocaleUtil.getString(context, LocaleUtil.CANCEL_MIXING)!,
                action: () {
                  _onCancelMixing();
                }),
            AlertPopupAction(title: LocaleUtil.getString(context, LocaleUtil.OK)!, action: () {})
          ],
        )
    );
  }


// void getErd(String erdKey) {
//   final erdValue = _cache?[erdKey] ?? "";
//   geaLog.debug("erdKey: $erdKey / erdValue $erdValue");
//   switch (erdKey) {
// case ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS:
//   _get9301(erdValue);
//   _isReversed = _erd0x9301.direction == 2;
//   break;
// case ERD.STAND_MIXER_CONTROL_SETTINGS_LIMITS:
//   _get9303(erdValue);
//   break;
// case ERD.STAND_MIXER_STATE:
//   _get9305(erdValue);
//   break;
// case ERD.TOASTER_OVEN_COOK_TIME_REMAINING:
//   _get922F(erdValue);
//   break;
//   }
// }
// void getAllErds(BuildContext context) {
//   try {
//     getErd(ERD.STAND_MIXER_CONTROL_SETTINGS_LIMITS); //9303
//     getErd(ERD.STAND_MIXER_CONTROL_CURRENT_SETTINGS); //9301
//     getErd(ERD.TOASTER_OVEN_COOK_TIME_REMAINING); //922f
//     getErd(ERD.STAND_MIXER_STATE); //9305
//     getErd(ERD.STAND_MIXER_CYCLE_SETTING_MODIFICATION_AVAILABILITY); //9309
//     _isReversed = _erd0x9301.direction == 2;
//   } catch (e) {
//     print(e);
//   }
// }
// void _get922F(String erdValue) {
//   _erd0x922f = ERD0x922F(erdValue);
//   if (timerMinRemaining != int.tryParse(_erd0x922f.remainingCookTimeSeconds.toString())! ~/ 60) {
//     setState(() {
//       geaLog.debug("Setting State for Timer");
//       timerSecRemaining = int.tryParse(_erd0x922f.remainingCookTimeSeconds.toString()) ?? 0;
//     });
//   }
// }
// void _get9301(String erdValue) {
//   _erd0x9301 = ERD0x9301(erdValue);
//   geaLog.debug("erd0x9301 SPEED: ${_erd0x9301.speed}");
//   setState(() {
//     _currentSliderValue = (double.tryParse((_erd0x9301.speed / _sliderMaxVal).toString()) ?? 0);
//     _timerSecRemaining = _erd0x9301.timerSetValue ?? 0;
//     directionValue = _erd0x9301.getDirection() == Direction.FORWARD ? 1 : _erd0x9301.getDirection() == Direction.REVERSE ? 2 : 0;
//     if (_currentSliderValue < 0.015) {
//       _currentSliderValue = 0.015; //sets & limits start position right to a more symmetrical start position
//     }
//     else if (_currentSliderValue > 0.985) {
//       _currentSliderValue = 0.985; //limits ending position to a more  symmetrical end position
//     }
//   });
// }
// void _get9303(String erdValue) {
//   _erd0x9303 = ERD0x9303(erdValue);
//   geaLog.debug("ERD 9303 MAX SPEED: " + _erd0x9303.maxSpeed.toString());
//   setState(() {
//     _sliderMaxVal = double.tryParse(_erd0x9303.maxSpeed.toString()) ?? 0;
//     _sliderMinVal = double.tryParse(_erd0x9303.minSpeed.toString()) ?? 0;
//   });
// }
// void _get9305(String erdValue) {
//   _erd0x9305 = ERD0x9305(erdValue);
//   setState(() {
//     _mixerState = _erd0x9305.getMixerState();
//     _isRunning = (_mixerState == MixerState.MIXER_MIXING);
//     _isPaused = (_mixerState == MixerState.MIXER_PAUSED);
//     _isIdle = (_mixerState == MixerState.MIXER_IDLE);
//   });
// }
}