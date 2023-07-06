import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/models/appliance_modifications_model.dart';

class ErdLimitsModel {
  final int min;
  final int max;

  const ErdLimitsModel({
    required this.min,
    required this.max});
}

class StandMixerSettingsModel {
  final int speed;
  final int timer;
  final String direction;


  const StandMixerSettingsModel({
    required this.speed,
    required this.timer,
    required this.direction,
    });
}

class StandMixerContentModel extends Equatable {
  final String? mixerMode;
  final String? mixerState;
  final bool? isReversed;
  final bool? isRunning;
  final bool? isPaused;
  final bool? isIdle;
  final int? timerMinRemaining;
  final int? timerSecRemaining;
  final int? directionValue;
  final double? currentSliderValue;
  final double? sliderMaxVal;
  final double? sliderMinVal;
  final bool? shouldScroll;
  final ApplianceAvailableModifications? availableModifications;
  final bool? isActiveStirEnabled;

  StandMixerContentModel ({
    this.mixerMode,
    this.mixerState,
    this.isReversed,
    this.isRunning,
    this.isPaused,
    this.isIdle,
    this.timerMinRemaining,
    this.timerSecRemaining,
    this.directionValue,
    this.currentSliderValue,
    this.sliderMaxVal,
    this.sliderMinVal,
    this.availableModifications,
    this.shouldScroll,
    this.isActiveStirEnabled
  });

  @override
  List<Object?> get props => [
    mixerMode,
    mixerState,
    isReversed,
    isRunning,
    isPaused,
    isIdle,
    timerMinRemaining,
    timerSecRemaining,
    currentSliderValue,
    sliderMaxVal,
    sliderMinVal,
    availableModifications,
    shouldScroll,
    isActiveStirEnabled
  ];

  @override
  String toString() => "StandMixerContentModel {\n"
      "mixerMode: $mixerMode\n"
      "mixerState: $mixerState\n"
      "isReversed: $isReversed\n"
      "isRunning: $isRunning\n"
      "isPaused: $isPaused\n"
      "isIdle: $isIdle\n"
      "timerMinRemaining: $timerMinRemaining\n"
      "timerSecRemaining: $timerSecRemaining\n"
      "directionValue: $directionValue\n"
      "currentSliderValue: $currentSliderValue\n"
      "sliderMaxVal: $sliderMaxVal\n"
      "sliderMinVal: $sliderMinVal\n"
      "availableModifications: $availableModifications\n"
      "shouldScroll: $shouldScroll\n"
      "isActiveStirEnabled: $isActiveStirEnabled\n"
      "}";

  StandMixerContentModel copyWith({
    String? mixerMode,
    String? mixerState,
    bool? isReversed,
    bool? isRunning,
    bool? isPaused,
    bool? isIdle,
    int? timerMinRemaining,
    int? timerSecRemaining,
    int? directionValue,
    double? currentSliderValue,
    double? sliderMaxVal,
    double? sliderMinVal,
    bool? shouldScroll,
    ApplianceAvailableModifications? availableModifications,
    bool? isActiveStirEnabled
  }) {
    return StandMixerContentModel(
        mixerMode: mixerMode ?? this.mixerMode,
        mixerState: mixerState ?? this.mixerState,
        isReversed: isReversed ?? this.isReversed,
        isRunning: isRunning ?? this.isRunning,
        isPaused: isPaused ?? this.isPaused,
        isIdle: isIdle ?? this.isIdle,
        timerMinRemaining: timerMinRemaining ?? this.timerMinRemaining,
        timerSecRemaining: timerSecRemaining ?? this.timerSecRemaining,
        currentSliderValue: currentSliderValue ?? this.currentSliderValue,
        sliderMaxVal: sliderMaxVal ?? this.sliderMaxVal,
        sliderMinVal: sliderMinVal ?? this.sliderMinVal,
        availableModifications: availableModifications ?? this.availableModifications,
        shouldScroll: shouldScroll ?? this.shouldScroll,
        isActiveStirEnabled: isActiveStirEnabled ?? this.isActiveStirEnabled
    );
  }
}