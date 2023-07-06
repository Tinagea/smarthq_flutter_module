import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class ImageCard extends StatelessWidget {
  final String imageURI;
  final String title;
  const ImageCard({required this.title, required this.imageURI, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 20.h),
      child: Container(
        width: 175.w,
        child: AspectRatio(
          aspectRatio: 17 / 10,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                image: DecorationImage(image: AssetImage(imageURI), fit: BoxFit.fitWidth)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.65)],
                      stops: [0.6, 1.0]
                      )
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
                  child: SizedBox(
                    width: 120.w,
                    child: Text(
                      title,
                      style: textStyle_size_20_bold_color_white()
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}