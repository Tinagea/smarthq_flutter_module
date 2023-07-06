/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

class LongImageCard extends StatefulWidget {
  final bool isAuto;
  final bool isArthur;
  final String? imageURI;
  final String title;
  final String subtitle;
  final String estTime;
  final String recipeId;
  final String userId;
  const LongImageCard(
      {
      required this.isAuto,
      required this.isArthur,
      required this.title,
      required this.subtitle,
      required this.estTime,
      required this.imageURI,
      required this.recipeId,
      required this.userId,
      Key? key})
      : super(key: key);

  @override
  State<LongImageCard> createState() => _LongImageCardState();
}

class _LongImageCardState extends State<LongImageCard> {
  late ImageProvider heroImage = NetworkImage(widget.imageURI ?? 'https://www.geographicexperiences.com/wp-content/uploads/revslider/home5/placeholder-1200x500.png');
  bool imageFailed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.h, right: 6.h, bottom: 20.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {Navigator.of(context).pushNamed(Routes.RECIPE_DETAILS_PAGE, arguments: RecipeArguments(widget.recipeId, widget.userId, widget.isAuto, widget.isArthur));},
        behavior: HitTestBehavior.translucent,
        child: Container(
          child: Hero(
            tag: widget.recipeId,
            child: AspectRatio(
              aspectRatio: 17 / 5,
              child: !imageFailed ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    image: DecorationImage( 
                        image: heroImage,
                        fit: BoxFit.fitWidth, 
                        onError: (error, _) {
                          setState(() {
                            imageFailed = true;
                          });
                        }
                    )),
                    
                child: cardContent(),
              ):
              Stack(
               children: [
                 Container(
                   decoration: BoxDecoration(
                    color: colorLightSilver(),
                       borderRadius: BorderRadius.circular(10.w),
                   ),
                   child: SvgPicture.asset(ImagePath.PLACEHOLDER, fit: BoxFit.cover),
                 ),
                 cardContent()
               ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget cardContent() {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 2),
              Text(
                widget.title,
                style: textStyle_size_20_bold_color_white(),
              ),
              Spacer(flex: 3),
              Text(
                widget.subtitle,
                style: textStyle_size_14_color_white(),
              ),
              Text(
                "${widget.estTime} min",
                style: textStyle_size_14_bold_color_white(),
              ),
              Spacer(flex: 3)
            ],
          ),
        ),
      ),
    );
  }


}