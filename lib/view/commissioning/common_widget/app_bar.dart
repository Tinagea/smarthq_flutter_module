import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CommonAppBar {
  final String? title;
  final String? subTitle;
  final String leftImagePath;
  final VoidCallback? leftBtnFunction;
  final String rightImagePath;
  final bool isRightButtonShown;
  final VoidCallback? rightBtnFunction;

  CommonAppBar(
      {required this.title,
        this.subTitle,
        this.leftImagePath = ImagePath.NAVIGATE_BACK_ICON,
        this.leftBtnFunction,
        this.rightImagePath = ImagePath.NAVIGATE_CLOSE_ICON,
        this.rightBtnFunction,
        this.isRightButtonShown = true});

  PreferredSizeWidget setNavigationAppBar(
      {required BuildContext context,
        bool leadingRequired = true,
        bool actionRequired = true}) {
    return AppBar(
      centerTitle: true,
      leading: leadingRequired
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
            if (this.subTitle != null)
              Text(
                subTitle!,
                style: textStyle_size_10_color_spanish_gray(),
              ),
          ]),
      // title: Text(title.toUpperCase(),
      //     style: textStyle_size_16_bold_color_white()),
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
                final baseDialog = CommonBaseAlertDialog(
                  context: context,
                  title: '',
                  content: LocaleUtil.getString(context, LocaleUtil.COMMISSIONING_STOP_MESSAGE),
                  yesOnPressed: () {
                    BlocProvider.of<CommissioningCubit>(context).initState();
                    BlocProvider.of<CommissioningCubit>(context).actionRequestGeModuleReachability(false);

                    BlocProvider.of<BleCommissioningCubit>(context).initState();
                    BlocProvider.of<BleCommissioningCubit>(context).actionBleStopScanning();

                    Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);

                    SystemNavigator.pop(animated: true);
                    BlocProvider.of<CommissioningCubit>(context).actionRequestRelaunch();
                  },
                  yesString: LocaleUtil.getString(context, LocaleUtil.YES),
                  noString: LocaleUtil.getString(context, LocaleUtil.NO),);

                showDialog(
                    context: context,
                    builder: (BuildContext context) => baseDialog,
                    barrierDismissible: false
                );
              }),
        )
            : Container(),
      ],
    );
  }
}
