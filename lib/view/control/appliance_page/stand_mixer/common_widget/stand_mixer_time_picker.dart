import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/services/erd_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class StandMixerTimePicker extends StatefulWidget {
  Function updateTimerData;
  bool maxTime;
  int maxSeconds;
  StandMixerContentModel standMixerContentModel;

  StandMixerTimePicker({
    Key? key,
    required this.updateTimerData,
    required this.maxTime,
    required this.maxSeconds,
    required this.standMixerContentModel,
  }) : super(key: key);

  @override
  State<StandMixerTimePicker> createState() => _StandMixerTimePickerState();
}

class _StandMixerTimePickerState extends State<StandMixerTimePicker> {
  bool isAtMaxMinutes = false;

   setIsAtMaxMinutes(bool value) {
    setState(() {
      isAtMaxMinutes = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(alignment: Alignment.center, children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: colorSpanishGray(), width: 0.2.w),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(flex: 5),
            TimerWheel(
              limit: widget.maxSeconds~/60 + 1,
              isMinutes: true,
              isActive: true,
              timerCallback: widget.updateTimerData,
              maxMinuteNotifier: setIsAtMaxMinutes,
              standMixerContentModel: widget.standMixerContentModel,
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 12.w),
              child: Text(LocaleUtil.getString(context, LocaleUtil.MIN)!, style: textStyle_size_16_bold_color_white()),
            ),
            Spacer(flex: 3),
            TimerWheel(
              limit: 60,
              interval: 10,
              isMinutes: false,
              isActive: !isAtMaxMinutes,
              timerCallback: widget.updateTimerData,
              standMixerContentModel: widget.standMixerContentModel,
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 6.w),
              child: Text(LocaleUtil.getString(context, LocaleUtil.SEC)!, style: textStyle_size_16_bold_color_white()),
            ),
            Spacer(flex: 2)
          ],
        ),
      ]),
    );
  }
}

class TimerWheel extends StatefulWidget {
  final bool isMinutes;
  final bool isActive;
  final int limit;
  final int interval;
  final StandMixerContentModel standMixerContentModel;
  final Function timerCallback;
  final Function? maxMinuteNotifier;

  TimerWheel({
    required this.isMinutes,
    required this.isActive,
    required this.limit,
    required this.timerCallback,
    required this.standMixerContentModel,
    this.maxMinuteNotifier,
    this.interval = 1
  });

  @override
  State<TimerWheel> createState() => _TimerWheelState();
}

class _TimerWheelState extends State<TimerWheel> {
  int valTracker = 0;
FixedExtentScrollController controller = FixedExtentScrollController(initialItem: 0);
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(widget.isMinutes){
        valTracker = widget.standMixerContentModel.timerSecRemaining! ~/ 60;
        geaLog.debug("valTracker: $valTracker");
      } else {
        valTracker = (widget.standMixerContentModel.timerSecRemaining! % 60) ~/ 10;
        geaLog.debug("valTracker: $valTracker");
      }
      controller.jumpToItem(valTracker);
      setState(() {});
    });
    super.initState();
  }


  TextStyle styleConditions(int i, int value) {
    if (widget.isMinutes) {
      if ((value - i == 2 || i == value + (widget.limit - 2)) ||
          (i == value + 2 || i - value == (2 - widget.limit)) ||
          (i - value == 3 || i - value == -3) ||
          (i - value == 2 || i - value == (3 - widget.limit)) ||
          (i - value == widget.limit - 3)) {
        return textStyle_size_16_light_color_white_33_opacity();
      }
      else if ((value - i == 1 || i == value + (widget.limit - 1)) ||
               (i == value + 1 || (value != (widget.limit - 1) ~/ 2 && i + value == (widget.limit - 1)))) {
        return textStyle_size_18_light_color_white_33_opacity();
      }
      else {
        return textStyle_size_20_bold_color_white();
      }
    } else {
      value = value * widget.interval;

      if ((value - i == (2 * widget.interval) || i == value + (4 * widget.interval)) ||
          (i == value + (2 * widget.interval) || i - value == (-4 * widget.interval)) ||
          (i - value == (3 * widget.interval) || i - value == (-3 * widget.interval))) {
        return textStyle_size_16_light_color_white_33_opacity();
      }
      else if ((value - i == widget.interval || i == value + (5 * widget.interval)) ||
               (i == value + widget.interval || i - value == (-5 * widget.interval))) {
        return textStyle_size_18_light_color_white_33_opacity();
      }
      else {
        return textStyle_size_20_bold_color_white();
      }
    }
  }

  List<Widget> generateSelectors(int selectedItem) {
    if (widget.isActive) {
      List<Widget> vals = [];

      for (int i = 0; i < widget.limit; i = i + widget.interval) {
        vals.add(Center(
          child: Text((i).toString(), style: styleConditions(i, selectedItem)),
        ));
      }

      return vals;
    } else {
      selectedItem = 0;
      List<Widget> otherVals = [];

      otherVals.add(Center(
        child: Text(
          selectedItem.toString(),
          style: textStyle_size_20_bold_color_white_66_opacity()
        )
      ));

      return otherVals;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0.w,
      height: 150.0.h,
      child: Center(
        child: ListWheelScrollView.useDelegate(
          itemExtent: 55,
          squeeze: 1.75,
          diameterRatio: 4,
          overAndUnderCenterOpacity: widget.isActive ? 1 : 0,
          physics: widget.isActive
            ? FixedExtentScrollPhysics()
            : NeverScrollableScrollPhysics(),
          controller: controller,
          onSelectedItemChanged: (int currentVal) {
            setState(() {
                if(currentVal == widget.limit - 1) {
                  if(widget.maxMinuteNotifier != null){
                  widget.maxMinuteNotifier!(true);
                  valTracker = currentVal;
                  } else {
                  valTracker = 0;
                  controller.jumpToItem(0);
                  }
                } else {
                if(widget.maxMinuteNotifier != null){
                  widget.maxMinuteNotifier!(false);
                 }
                  valTracker = currentVal;
                }
            });
            widget.timerCallback(isMinutes: widget.isMinutes, value: currentVal);
          },
          childDelegate: ListWheelChildLoopingListDelegate(
            children: generateSelectors(valTracker)
          )
        )
      )
    );
  }
}
