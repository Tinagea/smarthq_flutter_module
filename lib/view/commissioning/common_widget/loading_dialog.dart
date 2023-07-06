import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_component.dart';

class LoadingDialog {
  late bool _isDialogPopup;

  bool? _isCancelable;

  LoadingDialog({bool isCancelable = false}) {
    _isDialogPopup = false;
    _isCancelable = isCancelable;
  }

  void show(BuildContext context, String? title) {
    if (_isDialogPopup == false) {
      _isDialogPopup = true;

      showDialog(
          context: context,
          barrierDismissible: _isCancelable!,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                backgroundColor: colorEerieBlack(),
                child: Container(
                  width: 268.w,
                  height: 140.h,
                  child: Column(
                    children: [
                      BaseComponent.heightSpace(19.h),
                      new Text(
                        title ?? '',
                        style: textStyle_size_17_color_white(),
                        textAlign: TextAlign.center,
                      ),
                      BaseComponent.heightSpace(12.h),
                      new CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(colorDeepPurple()),
                      )
                    ],
                  ),
                ),
              )
            );
          }
      );
    }
  }

  void close(BuildContext context) {
    if (_isDialogPopup) {
      _isDialogPopup = false;

      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
