import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';


class FullWidthButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  FullWidthButton({required this.text, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:24.0.h),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.zero),
        height: 65.h,
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              colorDeepPurple(),
            ),
          ),
          onPressed: callback,
          child: Text(
            text,
            style: textStyle_size_18_bold_color_white(),
          ),
        ),
      ),
    );
  }
}
