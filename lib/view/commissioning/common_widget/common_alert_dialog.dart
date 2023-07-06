import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class CommonBaseAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  final Color color = Colors.white;

  final String? title;
  final String? content;
  final String? yesString;
  final String? noString;
  final Function? yesOnPressed;
  final Function? noOnPressed;
  final BuildContext context;

  CommonBaseAlertDialog(
      {required this.context,
      required this.title,
      required this.content,
      required this.yesOnPressed, this.noOnPressed,
      required this.yesString, this.noString});

  CommonBaseAlertDialog.fromCommonBaseAlertDialog({required this.context,this.title, this.content, this.yesString, this.noString, this.yesOnPressed, this.noOnPressed});


  List<Widget> makeButtonSet() {

    List<Widget> _buttonWidget = [];

    if (this.yesString != null) {
      TextButton yesButton = new TextButton(
        child: new Text(this.yesString!),
        style: TextButton.styleFrom(
            foregroundColor: Colors.blue
        ),
        onPressed: () {
          Navigator.of(this.context, rootNavigator: true).pop();
          this.yesOnPressed!();
        },
      );

      _buttonWidget.add(yesButton);
    }

    if (this.noString != null) {
      TextButton noButton = new TextButton(
          child: Text(this.noString!),
          style: TextButton.styleFrom(
              foregroundColor: Colors.red
          ),
          onPressed: () {
            Navigator.of(this.context, rootNavigator: true).pop();
            if (this.noOnPressed != null) {
              this.noOnPressed!();
            }
          });

      _buttonWidget.add(noButton);
    }
    return _buttonWidget;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(this.title ?? '', style: textStyle_size_20_bold_color_black()),
      content: new Text(this.content ?? '', style: textStyle_size_18_color_black()),
      backgroundColor: this.color,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.r)),
      actions: this.makeButtonSet(),
    );
  }
}

class CommonBaseAlertWithImageDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  final String imagePath;
  final String? content;
  final String? yes;
  final Function yesOnPressed;
  final BuildContext context;
  final Color color = Colors.white;

  CommonBaseAlertWithImageDialog(
      {required this.context,
      required this.content,
      required this.imagePath,
      required this.yesOnPressed,
      required this.yes});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: this.color,
      insetAnimationDuration: const Duration(milliseconds: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BaseComponent.heightSpace(20.h),
          Image.asset(
            this.imagePath,
            height: 200.h,
          ), // Show your Image
          BaseComponent.heightSpace(10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(this.content ?? '',
                style: textStyle_size_18_color_black(),
                textAlign: TextAlign.center),
          ),
          BaseComponent.heightSpace(5.h),
          Container(
            color: colorDeepDarkCharcoal().withAlpha(70),
            height: 1.h,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          ),
          new TextButton(
            child: new Text(this.yes ?? LocaleUtil.getString(context, LocaleUtil.OK)!, style: textStyle_size_15_color_deep_purple()),
              onPressed: () {
                yesOnPressed();
              }),
        ],
      ),
    );
  }
}

class CommonBleAlertDialog extends CommonBaseAlertDialog {
  CommonBleAlertDialog.fromCommonBaseAlertDialog({required super.context}) : super.fromCommonBaseAlertDialog();


  void showCommonBleAlertDialog() {
    var bleAlertDialog = CommonBaseAlertDialog(
        context: context,
        title: LocaleUtil.getString(context, LocaleUtil.CONNECT),
        content: LocaleUtil.getString(context, LocaleUtil.BLE_SCAN_TEXT_1),
        yesOnPressed: () {
          globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
          Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
        },
        yesString: LocaleUtil.getString(context, LocaleUtil.OK));
    showDialog(context: context, builder: (context) => bleAlertDialog);
  }
}
