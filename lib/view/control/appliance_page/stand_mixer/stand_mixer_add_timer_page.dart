import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/control/stand_mixer_control_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/services/erd_model.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/common_widget/stand_mixer_time_picker.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/common_widget/stand_mixer_page_header.dart';

void showAddTimerPage(BuildContext context,Function callback, int maxSeconds, StandMixerContentModel model) {

  BlocProvider.of<StandMixerControlCubit>(context).showBottomBar(false);
  BlocProvider.of<StandMixerControlCubit>(context).showTopBar(false);

  int _minutes = 0;
  int _seconds = 0;
  // ContextUtil.instance.setRoutingContext = context;
  void updateMinutes(int min) {
    _minutes = min;
  }

  void updateSeconds(int sec) {
    _seconds = sec;
  }

  updateTimerData({bool isMinutes = false, int value = 0}) {
    if (isMinutes) {
      updateMinutes(value);
    }
    else {
      updateSeconds(value * 10);
    }
  }

  void _leftArrowCallback() {
    BlocProvider.of<StandMixerControlCubit>(context).showBottomBar(true);
    BlocProvider.of<StandMixerControlCubit>(context).showTopBar(true);
  }

  showDialog(
      context: context,
      builder: (context) {
        return Container(
            width: double.infinity,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                StandMixerPageHeader(LocaleUtil.getString(context, LocaleUtil.MIX_TIMER)!.toUpperCase(), true, false, leftArrowCallback: _leftArrowCallback),
                Spacer(flex: 2),
                Card(
                  color: colorDarkCharcoal(),
                  margin: EdgeInsets.all(8.0.w),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 8.0.h)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Spacer(flex: 1),
                            Icon(
                                Icons.timer,
                                color: Colors.grey
                            ),
                            Spacer(flex: 1),
                            Text(
                                LocaleUtil.getString(context, LocaleUtil.MIX_TIME)!,
                                style: textStyle_size_14_bold_color_white()
                            ),
                            Spacer(flex: 20)
                          ]
                      ),
                      Divider(
                          color: colorSpanishGray(),
                          thickness: 0.2
                      ),
                      StandMixerTimePicker(
                          updateTimerData: updateTimerData,
                          maxTime: _minutes == maxSeconds / 60,
                          maxSeconds: maxSeconds,
                          standMixerContentModel: model,
                          )
                    ],
                  ),
                ),
                Spacer(flex: 6),
                Container(
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(colorDeepPurple())),
                      onPressed: () {
                        int totalSec = (_minutes * 60) + _seconds;
                        callback(model, totalSec);
                        Navigator.pop(context);
                      },
                      child: Text(
                          LocaleUtil.getString(context, LocaleUtil.SET)!.toUpperCase(),
                          style: textStyle_size_18_bold_color_white()
                      ),
                    )
                ),
                Spacer(flex: 1)
              ],
            )
        );
      });
}

