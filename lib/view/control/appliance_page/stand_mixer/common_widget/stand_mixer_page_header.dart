import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class StandMixerPageHeader extends StatelessWidget {
  final String pageTitle;
  final bool hasLeftArrow;
  final bool hasRightX;
  final Function? leftArrowCallback;
  StandMixerPageHeader(this.pageTitle, this.hasLeftArrow, this.hasRightX,{ this.leftArrowCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 36.w,
            child: Visibility(
              visible: hasLeftArrow,
              child: GestureDetector(
                onTap: () {
                  if (leftArrowCallback != null) {
                    leftArrowCallback!();
                    Navigator.pop(context);
                  }
                  else {
                    Navigator.pop(context);
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white
                ),
              ),
            ),
          ),
          Spacer(flex: 9),
          Text(
            pageTitle,
            style: textStyle_size_16_bold_color_white_wide(),
          ),
          Spacer(flex: 9),
          SizedBox(
            width: 36.w,
            child: Visibility(
              visible: hasRightX,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 28.w
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
