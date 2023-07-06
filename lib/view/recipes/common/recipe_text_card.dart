import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/recipes/common/common_video_player.dart';

class RecipeTextCard extends StatefulWidget {
  const RecipeTextCard({
    Key? key,
    required this.label,
    required this.direction,
    this.mediaSize,
    this.mediaURL,
    this.mimeType,
  }) : super(key: key);

  final String label;
  final String? direction;
  final Size? mediaSize;
  final String? mediaURL;
  final String? mimeType;

  @override
  State<RecipeTextCard> createState() => _RecipeTextCardState();
}

class _RecipeTextCardState extends State<RecipeTextCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.w),
        gradient: gradientDarkGreyCharcoalGrey(),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0.h),
            child: Text(
              widget.label.toUpperCase(),
              style: textStyle_size_16_bold_color_deep_purple(),
            ),
          ),
          Divider(
            color: Colors.grey.shade800,
            height: 1.5.h,
            thickness: 1,
          ),
           Visibility(
            visible: widget.mediaURL != null,
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.0.w,14.0.h,12.0.w,4.h),
              child: Container(
                height:  (widget.mediaURL != null && widget.mediaURL!.contains('/icons/')) ? 150.h : 375.h, 
                width: 300.w,
                child: Center(
                  child: (widget.mimeType != null && widget.mimeType!.contains("image")) ? Image(
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return SvgPicture.asset(ImagePath.PLACEHOLDER);
                        },
                        image: NetworkImage(widget.mediaURL ?? ""),
                        fit: BoxFit.contain)
                        :(widget.mediaURL != null)? Padding(
                          padding: EdgeInsets.only(top:14.0.h),
                          child: CommonVideoPlayer(aspectRatio: 1, mediaURL:widget.mediaURL!),
                  ): Container(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0.w, bottom: 22.0.h, right: 18.0.w, top: 8.0.h),
            child: Text(widget.direction != null ? widget.direction! : " ",
              style: textStyle_size_14_color_white_spaced(),              
            textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}