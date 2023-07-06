import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class ShortcutAppBar {
  final String? title;
  final String leftImagePath;
  final bool isLeftButtonShown;
  final VoidCallback? leftBtnFunction;
  final String rightImagePath;
  final bool isRightButtonShown;
  final VoidCallback? rightBtnFunction;
  final Color? backgroundColor;

  ShortcutAppBar(
      {required this.title,
        this.leftImagePath = ImagePath.NAVIGATE_BACK_ICON,
        this.leftBtnFunction,
        this.isLeftButtonShown = true,
        this.rightImagePath = ImagePath.NAVIGATE_CLOSE_ICON,
        this.rightBtnFunction,
        this.isRightButtonShown = true,
        this.backgroundColor});

  PreferredSizeWidget setNavigationAppBar(
      {required BuildContext context,
        bool leadingRequired = true,
        bool actionRequired = true}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: (backgroundColor == null)? colorRaisinBlack() : backgroundColor,
      leading: Visibility(
        visible: isLeftButtonShown,
        child: leadingRequired
            ? IconButton(
            icon: (leftImagePath.endsWith(".png")) ?
            Image.asset(
              leftImagePath,
              width: 20.w,
              height: 20.h,) :
            SvgPicture.asset(
              leftImagePath,
              width: 30.w,
              height: 30.h,
            ),
            onPressed: leftBtnFunction != null
                ? leftBtnFunction
                : () {
              if (Navigator.canPop(context))
                Navigator.pop(context);
              else
                Navigator.of(context, rootNavigator: true).pop();
            })
            : Container(),
      ),
      title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (this.title != null)
              AutoSizeText(
                title!.toUpperCase(),
                style: textStyle_size_16_bold_color_white(),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
          ]),
      actions: <Widget>[
        actionRequired
            ? Visibility(
          visible: isRightButtonShown,
          child: IconButton(
              icon:
              (rightImagePath.endsWith(".png")) ?
              Image.asset(
                rightImagePath,
                width: 20.w,
                height: 20.h,) :
              SvgPicture.asset(
                rightImagePath,
                width: 30.w,
                height: 30.h,
              ),
              onPressed: rightBtnFunction != null
                  ? rightBtnFunction
                  : () {
                SystemNavigator.pop(animated: true);
              }),
        )
            : Container(),
      ],
    );
  }
}
