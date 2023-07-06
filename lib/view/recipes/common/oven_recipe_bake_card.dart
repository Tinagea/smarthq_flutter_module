/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/cubits/control/toaster_oven_control_cubit.dart';
import 'package:smarthq_flutter_module/resources/erd/toaster_oven/0x9209.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

import 'cloud_action_button.dart';

class RecipeOvenCard extends StatefulWidget {
  const RecipeOvenCard({
    Key? key,
    required this.label,
    required this.direction,
    this.mediaSize,
    this.mediaURL,
    this.mimeType,
    required this.stepIndex,
    required this.userId,
    required this.indexTracker,
    this.altText,
    required this.buttonText,
    required this.applianceString

  }) : super(key: key);

  final String label;
  final String? direction;
  final Size? mediaSize;
  final String? mediaURL;
  final String? mimeType;
  final int stepIndex;
  final String userId;
  final String buttonText;
  final String? altText;
  final List<bool> indexTracker;
  final String applianceString;

  @override
  State<RecipeOvenCard> createState() => _RecipeOvenCardState();
}

class _RecipeOvenCardState extends State<RecipeOvenCard> {
  
  bool executionSent = false;

  @override
  void initState() {
    if (BlocProvider.of<ToasterOvenControlCubit>(context).getToasterOvenCurrentState() != ToasterOvenCurrentState.TOASTER_OVEN_COOKING) {
      executionSent = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isMediaAVideo(String? mediaURL){
    if(mediaURL != null){
      if(mediaURL.contains(".mp4")){
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void toggleExecutionSent(){
    setState(() {
      if (!executionSent){
        executionSent = !executionSent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: gradientDarkGreyCharcoalGrey(),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
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
              padding: EdgeInsets.fromLTRB(
                  12.0.w,
                  14.0.h,
                  12.0.w,
                  22.h
              ),
              child: Container(
                height: 375.h,
                width: 300.w,
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return (widget.mimeType?.contains("image") ?? true ? Image(
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Image(image: AssetImage(ImagePath.PLACEHOLDER));
                          },
                          image: NetworkImage(widget.mediaURL ?? ""),
                          fit: BoxFit.contain)
                          : Padding(
                        padding:  EdgeInsets.only(top: 14.0.h),
                        child: Center(
                          child: !isMediaAVideo(widget.mediaURL)? Image(
                              height: 96.h,
                              width: 96.w,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Container(width: 96.w, height: 96.h, child: SvgPicture.asset(ImagePath.TIME_ICON));
                              },
                              image: NetworkImage(widget.mediaURL ?? ""),
                              fit: BoxFit.contain):
                          Container(
                            height: 96.h,
                            width: 96.w,
                            color: Colors.grey,
                            child: Center(
                              child: Icon(Icons.play_arrow, color: Colors.white, size: 40.sp),
                            ),
                          ),
                        ),
                      ));
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0.w, bottom: 22.0.h, right: 18.0.w),
            child: Text(
              widget.direction != null ? widget.direction! : " ",
              style: textStyle_size_14_color_white(),
            ),
          ),
          CloudActionButton(
            stepIndex: widget.stepIndex,
            userId: widget.userId,
            buttonText: widget.buttonText,
            altText: widget.altText,
            indexTracker: widget.indexTracker,
            toggleExecutionSent: toggleExecutionSent,
            executionSent: executionSent,
            applianceString: widget.applianceString
          )
        ],
      ),
    );
  }
}