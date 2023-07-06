import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_picker.dart';

class ShortcutComponent{
  static EdgeInsets componentDefaultPadding() {
    return EdgeInsets.symmetric(horizontal: 10.w);
  }

  static SingleChildScrollView componentScrollView({
      required List<Widget> widgets }) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 10.h,
          children: widgets
        ),
      ),
    );
  }

  static Widget componentGridListTile( {
    required BuildContext context,
    required String? title,
    required String? imagePath,
    required Function(bool isOffline) onClickedFunction,
    bool isOffline = false}) {

    return GridTile(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Card(
          color: Colors.transparent,
          child: Container(
            decoration: componentApplianceSelectBoxDecorate(),
            child: Stack(
              children: [
                Visibility(
                  visible: isOffline,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImagePath.SHORTCUT_APPLIANCE_STATUS_OFFLINE,
                            width: 20.w),
                        Text(
                          LocaleUtil.getString(context, LocaleUtil.OFFLINE) ?? "",
                          style: textStyle_size_16_color_white(),
                        ),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: isOffline? 0.25: 1,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(imagePath ?? "" , height: 65.h, color: Colors.white),
                        Text(
                          title ?? "",
                          style: textStyle_size_16_color_white(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          onClickedFunction(isOffline);
        },
      ),
    );
  }

  static Widget componentInfoWithContent( {
    required BuildContext context,
    required String title}) {
    return Padding(
      padding:  componentDefaultPadding(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h, right: 10.w),
            child: SvgPicture.asset(
                ImagePath.REMEMBER_NETWORK_INFO_ICON,
                width: 15.w,
                height: 15.h
            )
          ),
          Expanded(
            child: Text(
                title,
                style: textStyle_size_14_color_white_50_opacity()),
          )
        ],
      ),
    );
  }

  static Widget componentListTile({
    required BuildContext context,
    required String? imagePath,
    required String? title,
    required VoidCallback clickedFunction}) {

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Card(
        color: Colors.transparent,
        child: Container(
          margin: componentDefaultPadding(),
          height: 160.h,
          decoration: componentApplianceSelectBoxDecorate(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(imagePath ?? "" , height: 65.h),
                Text(
                  title ?? "",
                  style: textStyle_size_16_color_white(),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        clickedFunction();
      },
    );
  }

  static Widget componentSelectSectionTitle(String? title) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: componentDefaultPadding(),
        child: Text(
          title ?? "",
          style: textStyle_size_16_color_white(),
        ),
      ),
    );
  }


  static BoxDecoration componentApplianceSelectBoxDecorate() {
    return BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        )
    );
  }

  static Widget componentBottomButton({
    required String? title,
    required VoidCallback clickedFunction,
    bool isEnabled = true}) {
    return Container(
      height: 68.h,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: ElevatedButton(
              child: Text(
                (title ?? "").toUpperCase(),
                style: textStyle_size_18_bold_color_white(),
              ),
              onPressed: isEnabled ? () {
                clickedFunction();
              } : null,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                ),
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

  static Widget componentSettingsPicker({
    String? iconImagePath,
    required String? title,
    required List<String>? items,
    String? selected,
    String? tempUnit,
    bool visible = false,
    required Function(String value) onValueChanged
    }) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: componentDefaultPadding(),
        child: Container(
          width: double.infinity,
          height: 205,
          decoration: BoxDecoration(
            color: colorDeepDarkCharcoal(),
              borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Row(
                  children: [
                    if (iconImagePath != null) SvgPicture.asset(iconImagePath, width: 20.w),
                    BaseComponent.widthSpace(10.w),
                    Text(
                      title ?? "",
                      style: textStyle_size_15_bold_color_white(),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white.withOpacity(0.1)),
              Stack(
                  children: [
                    Center(
                      child: ShortcutPicker(
                          items: items,
                          selectedItem: selected,
                          onValueSelected: (value){
                            onValueChanged(value);
                          }),
                    ),
                    if(tempUnit != null)
                      Positioned(
                        top: 55,
                        left: 230,
                        child: Text(
                          '°${tempUnit.substring(0, 1).toUpperCase()}',
                          style: textStyle_size_14_bold_color_white(),
                        ),
                      ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget componentCenterDescriptionText(
      { required String? text,
        EdgeInsets marginInsets = const EdgeInsets.symmetric(horizontal: 20.0)}) {

    return Container(
      margin: marginInsets,
      child: Center(
        child: Text(
          text ?? "",
          style: textStyle_size_24_bold_color_white(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static Widget componentShortDetails({
    required BuildContext context,
    required String? title,
    String? subTitle,
    required String? iconPath,
    required String? setText,
    required String? nickname,
    required List<List<String?>>? items
  }) {
    return Padding(
      padding: componentDefaultPadding(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: gradientDarkGreyCharcoalGrey(),
            borderRadius: BorderRadius.circular(10.r)),
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 20.h,
          children: [
            BaseComponent.heightSpace(10.h),
            Column(
              children: [
                Center(
                  child: Text(
                      title ?? '',
                      style: textStyle_size_18_bold_color_white()),
                ),
                if(subTitle != null)
                  if (subTitle.length > 0)
                    Center(
                      child: Text(
                          subTitle.toUpperCase(),
                          style: textStyle_size_12_color_old_silver()),
                    ),
              ],
            ),
            Center(
              child: Container(
                width: 90, // fixed size. no device relevant
                height: 145, // fixed size. no device relevant
                decoration: BoxDecoration(
                    gradient: gradientRaisinBlackDarkCharcoal(),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.white.withOpacity(0.25))),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Stack(
                    children: [
                      if(iconPath != null)
                        SvgPicture.asset(
                          iconPath,
                          height: 35, // no device relevant
                        ),
                      if (setText != null)
                        Positioned(
                            top: 40, // under the icon. no device relevant
                            left: 0,
                            child: Text(
                                setText,
                                textAlign: TextAlign.start,
                                style: textStyle_size_14_color_white())
                        ),
                      if (nickname != null)
                        Positioned(
                            bottom: 5, // no device relevant
                            left: 0,
                            child: Container(
                              margin: EdgeInsets.only(top: 10.h),
                              width: (90 - (2 * 10.w)),
                              child: Text(
                                  nickname,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.start,
                                  style: (nickname.length > 10) ? textStyle_size_13_bold_color_white() : textStyle_size_15_bold_color_white()),
                            )
                        )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 3,
                  children:[
                    Text(
                        LocaleUtil.getString(context, LocaleUtil.SHORTCUT_SETTINGS)!,
                        textAlign: TextAlign.start,
                        style: textStyle_size_14_color_white()),
                    Divider(color: Colors.white.withOpacity(0.5)),
                    if (items != null)
                      for (var item in items)
                        if (item[1] != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                item[0] ?? '',
                                textAlign: TextAlign.start,
                                style: textStyle_size_14_color_white()),
                            Text(
                                item[1] ?? '',
                                textAlign: TextAlign.start,
                                style: textStyle_size_14_color_white()),
                          ],
                        )
                  ]
                ),
              ),
            BaseComponent.heightSpace(10.h)
          ],
        ),
      ),
    );
  }
}