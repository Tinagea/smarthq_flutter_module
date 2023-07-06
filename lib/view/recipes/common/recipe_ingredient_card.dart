import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/recipes/common/cloud_action_button.dart';
import 'package:smarthq_flutter_module/view/recipes/common/unsupported_character_handler.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class RecipeIngredientCard extends StatelessWidget {
  final String label;
  final String? mediaURL;
  final Size? mediaSize;
  final String? direction;
  final String? alternateDirection;
  final int stepIndex;
  final String userId;
  final String stepType;
  final List<bool> indexTracker;
  String buttonText;
  String? altText;
  final bool isAuto;
  String applianceString;

  RecipeIngredientCard(
      {required this.label, 
        required this.mediaURL, 
        required this.direction, 
        required this.alternateDirection, 
        required this.stepIndex, 
        required this.userId,
        required this.buttonText,
        required this.indexTracker,
        this.altText,
        required this.isAuto,
        required this.stepType,
        this.mediaSize,
        required this.applianceString
      });



 bool isMediaAVideo(String? mediaURL){
    if(mediaURL != null){
      if(mediaURL.contains(".mp4")){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    bool hasButton = stepType != "manual" && stepType != "manualMeasure";
    return SizedBox(
      height: hasButton ? 410.h : 310.h,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: gradientDarkGreyCharcoalGrey(),
        ),
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0.h),
            child: AutoSizeText(
              label.toUpperCase(),
              style: textStyle_size_16_bold_color_deep_purple(),
              maxLines: 1,
            ),
          ),
          Divider(
            color: Colors.grey.shade800,
            height: 1.5,
            thickness: 1,
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  height: 100.h,
                  child: Center(
                    child: !isMediaAVideo(mediaURL)? Image(
                        height: 96.h,
                        width: 96.w,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Container(width: 96.w, height: 96.h, child: SvgPicture.asset(ImagePath.TIME_ICON),);
                        },
                        image: NetworkImage(mediaURL ?? ""),
                        fit: BoxFit.contain):
                        Container(
                          height: mediaSize?.height ?? 96.h,
                          width: mediaSize?.width ?? 96.w,
                          color: Colors.grey,
                          child: Center(
                            child: Icon(Icons.play_arrow, color: Colors.white, size: 40.sp,),
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: unsupportedCharacterHandlerAutoSized(
                    direction != null ? direction! : " ",
                    maxLines: 1,
                    style: textStyle_bold_size_24_color_white() 
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                unsupportedCharacterHandlerAutoSized(
                  alternateDirection != null ? alternateDirection! : " ",
                  maxLines: 1,
                  style: textStyle_size_14_color_white(),
                ),
                SizedBox(
                  height: 15.h,
                ),                
                Visibility(
                  visible: hasButton,
                  child: CloudActionButton(
                    stepIndex: stepIndex,
                    userId: userId,
                    buttonText: buttonText,
                    altText: altText,
                    indexTracker: indexTracker,
                    applianceString: applianceString,
                    busyPopupCanSendSettings: false,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
