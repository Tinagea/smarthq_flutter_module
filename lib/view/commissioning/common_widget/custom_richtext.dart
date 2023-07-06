import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

import 'component.dart';

class CustomRichText {
  static Widget addWifiTextBox(
      {required List<InlineSpan> spanStringList,
      EdgeInsets marginInsets = EdgeInsets.zero, TextAlign alignText = TextAlign.left}) {
    return richTextDescriptionWithCard(
        RichText(
          text: TextSpan(
            style: textStyle_size_18_color_white(),
            children: spanStringList,

          ),
          textAlign: alignText,
        ),
        marginInsets);
  }

  static Widget addWifiTextBoxCentered(
      {required List<InlineSpan> spanStringList,
        EdgeInsets marginInsets = EdgeInsets.zero}) {
    return richTextDescriptionWithCard(
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 18),
            children: spanStringList,
          ),
          textAlign: TextAlign.center,
        ),
        marginInsets);
  }

  static Widget customSpanListTextBox(
      {required List<TextSpan> textSpanList,
      EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical:16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text.rich(
              TextSpan(children: textSpanList),
            ),
          ),
        ],
      ),
    );
  }

  static Widget customSpanListTextBoxWithButton(
      {required List<TextSpan> textSpanList, required String buttonTitle, required VoidCallback btnFunction,
        EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: marginInsets,
      decoration: BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Flexible(
                child: Text.rich(
                  TextSpan(children: textSpanList),
                ),
              ),
              Component.componentBasicCustomButton(buttonTitle, btnFunction)
            ],
          ),
        ],
      ),
    );
  }

  static Widget customSpanListTextBoxWithDetail(
      { required BuildContext context,
        required String? title,
        required String? detail,
        required VoidCallback onTapPencil,
        EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical:16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: textStyle_size_18_color_white()
            ),
            flex: 4
          ),
          Spacer(),
          GestureDetector(
            child: Text(detail ?? "", style: textStyle_size_18_color_yellow()),
            onTap: () {
              onTapPencil(); },
          )
        ],
      )
    );
  }

  static Widget customApplianceListCell({
    required List<TextSpan> textSpanList,
    required String imagePath,
    required String buttonTitle,
    required VoidCallback btnFunction,
    EdgeInsets marginInsets = EdgeInsets.zero}) {

    return Container(
      height: 92.h,
      margin: marginInsets,
      decoration: Component.componentApplianceSelectBoxDecorate(),
      child: Row (
        children: <Widget>[
          BaseComponent.widthSpace(15.w),
          if (imagePath.endsWith(".png"))
            Image.asset(imagePath,
              height: 50.h,
              width: 50.w),
          if (imagePath.endsWith(".svg"))
            SvgPicture.asset(imagePath,
                height: 50.h,
                width: 50.w),
          BaseComponent.widthSpace(14.w),
          Expanded(
            child: Text.rich(
              TextSpan(children: textSpanList),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: false,
            ),
          ),
          SizedBox(width: 10.w,),
          Padding(
            padding: EdgeInsets.only(right: 25.w),
            child: Component.componentBasicCustomButton(buttonTitle, btnFunction),
          ),
        ],
      ),
    );
  }

  static Widget richTextDescriptionWithCard(
      RichText description, EdgeInsets marginInsets) {
    return Wrap(
      children: [
        Container(
          margin: marginInsets,
          decoration: BoxDecoration(
            gradient: gradientRaisinBlackDarkCharcoal(),
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          child: Center(
            child:
                Padding(padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w), child: description),
          ),
        ),
      ],
    );
  }

  static Widget customSpanListTextBoxCenter(
      {required List<TextSpan> textSpanList,
        EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical:16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text.rich(
              TextSpan(children: textSpanList),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
