import 'package:smarthq_flutter_module/view/flavourly/common/color.dart';
import 'package:smarthq_flutter_module/view/flavourly/common/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Utils {
  static Widget componentMainImage(BuildContext context, String imagePath) {
    if (imagePath.endsWith(".svg")) {
      return SvgPicture.asset(
        imagePath,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 375.w * 232.h,
      );
    } else {
      return Container(
        child: Image.asset(imagePath, height: MediaQuery.of(context).size.width / 375.w * 232.h, width: MediaQuery.of(context).size.width),
      );
    }
  }

  static Widget componentFullScreenImage(BuildContext context, String imagePath) {
    if (imagePath.endsWith(".svg")) {
      return SvgPicture.asset(
        imagePath,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
    } else {
      return Container(
        child: Image.asset(imagePath, height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width),
      );
    }
  }

  static Widget componentFullScreenNetworkImageWithOverlay(BuildContext context,String imagePath) {
      return Container(
        width: 200,
        height: 600,
        decoration: BoxDecoration(image:DecorationImage(
            image: NetworkImage(imagePath)
        ,fit: BoxFit.fill
        ,colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.srcATop))),
      );

  }

  static Widget componentSmallImage(BuildContext context, String imagePath) {
    if (imagePath.endsWith(".svg")) {
      return SvgPicture.asset(
        imagePath,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 3750.w * 232.h,
      );
    } else {
      return Container(
        child: Image.asset(imagePath, height: MediaQuery.of(context).size.width / 3750.w * 232.h, width: MediaQuery.of(context).size.width),
      );
    }
  }

  static Widget componentBottomButton({required String title, VoidCallback? onTapButton, bool isEnabled = true}) {
    return Container(
      height: 115.h,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 32, horizontal: 60),
        child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: ElevatedButton(
              child: Text(
                title.toUpperCase(),
                style: textStyle_size_18_bold_color_white(),
              ),
              onPressed: isEnabled
                  ? () {
                      onTapButton!();
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (isEnabled) {
                    return colorDeepPurple();
                  }
                  return colorDarkLiver();
                }),
              ),
            )),
      ),
    );
  }

  static Widget componentButton({required String title, VoidCallback? onTapButton, bool isEnabled = false, bool toggleEnabled = true}) {
    return Container(
      height: 65.h,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: ElevatedButton(
              child: Text(
                title,
                style: textStyle_size_custom_color_white_bold(fontSize: 22),
              ),
              onPressed: () {
                //  onTapButton!();
                if (toggleEnabled) {
                  isEnabled = !isEnabled;
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (isEnabled) {
                    return colorDeepPurple();
                  }
                  return colorDarkLiver();
                }),
              ),
            )),
      ),
    );
  }

  static Widget componentScreenBody(BuildContext context, List<Widget> widgets, Widget bottomButton, {ScrollController? scrollController, bool isScrollEnabled = true}) {
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                physics: isScrollEnabled ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                controller: scrollController ?? ScrollController(),
                children: widgets,
              )),
              bottomButton,
            ],
          ),
        ));
  }

  static Widget componentScreenBodyWithOutButton(BuildContext context, List<Widget> widgets, {ScrollController? scrollController, bool isScrollEnabled = true}) {
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                physics: !isScrollEnabled ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                controller: scrollController ?? ScrollController(),
                children: widgets,
              )),
            ],
          ),
        ));
  }

  static Widget heightSpace(double _height) {
    return SizedBox(width: double.infinity, height: _height);
  }

  static Widget widthSpace(double _width) {
    return SizedBox(width: _width);
  }

  static String durationToString(int minutes) {
    var d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    if(int.parse(parts[1])>0){
      return '${parts[0]}:${parts[1].padLeft(2, '0')}';
    }else{
      return parts[0];
    }

  }
}
