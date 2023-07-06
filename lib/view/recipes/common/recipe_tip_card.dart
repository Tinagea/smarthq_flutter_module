import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class RecipeTipCard extends StatelessWidget {
  const RecipeTipCard({
    Key? key,
    this.tip,
  }) : super(key: key);

  final String? tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradientDarkGreyCharcoalGrey(),
        borderRadius: BorderRadius.circular(8.0.w),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
              child: SvgPicture.asset(ImagePath.LIGHT_BULB),
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                child: Text("Tip: ${this.tip}",
                  style: textStyle_size_14_color_white(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
