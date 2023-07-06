import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class RecipeUpNextCard extends StatelessWidget {
  final String nextStep;
  Function cheatSheetCallback;
  RecipeUpNextCard({required this.nextStep, required this.cheatSheetCallback});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.w),
          gradient: gradientDarkGreyCharcoalGrey(),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 24.0.w),
                  Text(LocaleUtil.getString(context, LocaleUtil.UP_NEXT)!,
                    style: textStyle_size_14_bold_color_deep_purple()
                  ),
                  GestureDetector(
                    child: Container(
                      width: 24.w,
                      height: 24.h,
                      child: SvgPicture.asset(ImagePath.STEPS_ICON),
                    ),
                    onTap: () => cheatSheetCallback(),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade800,
              height: 1.5.h,
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0.h),
              child: Text(nextStep,
                style: textStyle_size_14_light_color_white(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
