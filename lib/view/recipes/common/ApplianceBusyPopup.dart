/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/erd/erd.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class ApplianceBusyPopup extends StatefulWidget {
  final ApplianceType applianceType;
  final String titleTypeString;
  final String actionTypeString;
  final Function sendNewSettings;
  final Function setErd;
  final bool hasSendSettings;
  final bool mixerIsIdle;
  
  ApplianceBusyPopup({required this.applianceType, required this.titleTypeString, required this.actionTypeString, required this.sendNewSettings, required this.setErd, required this.hasSendSettings, required this.mixerIsIdle});
  
  @override
  State<StatefulWidget> createState() => _ApplianceBusyPopupState();
  
}

class _ApplianceBusyPopupState extends State<ApplianceBusyPopup> {
  
  Future<void> invokeSendSettings() async {
    Navigator.pop(context);
    widget.setErd(ERD.TOASTER_OVEN_CANCEL_OPERATION, "01", true);
    if(widget.applianceType != ApplianceType.STAND_MIXER){
      widget.sendNewSettings();
    }
  }
  
  List<Widget> buildActionButtons(){
    List<Widget> _list = [
      TextButton(onPressed: () => Navigator.pop(context), child: Text(LocaleUtil.getString(context, LocaleUtil.CLOSE)!.toUpperCase(), style: textStyle_size_16_bold_color_deep_purple())),
      Divider(),
      TextButton(onPressed: () {
        widget.setErd(ERD.TOASTER_OVEN_CANCEL_OPERATION, "01", false);
        Navigator.pop(context);
        }, 
          child: Text("${LocaleUtil.getString(context, LocaleUtil.END)!.toUpperCase()} ${widget.actionTypeString}", style: textStyle_size_16_bold_color_deep_purple())),
      Divider()
    ];
    if(widget.hasSendSettings){
      _list.add(TextButton(onPressed: () => invokeSendSettings(), child: Text(LocaleUtil.getString(context, LocaleUtil.SEND_NEW_SETTINGS)!.toUpperCase(), style: textStyle_size_16_bold_color_deep_purple())));
      _list.add(Divider());
    }
          return _list;
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Center(child: Text("${widget.titleTypeString} ${LocaleUtil.getString(context, LocaleUtil.IS_BUSY)!.toUpperCase()}")),
        titlePadding: EdgeInsets.only(top: 20.0.h),
        titleTextStyle: textStyle_size_20_bold_color_black(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        actionsOverflowDirection: VerticalDirection.up,
        actionsOverflowAlignment: OverflowBarAlignment.center,
        actions: buildActionButtons()
    );  
  }
}
