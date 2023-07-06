import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:load_switch/load_switch.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/utils/screen_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smarthq_flutter_module/view/common/formatter/upper_case_text_formatter.dart';


enum TextFieldStatus {
  empty,
  notEmpty,
  equalToMaxLength,
}

class Component {
  static Widget componentMainImage(BuildContext context, String imagePath) {
    if (imagePath.endsWith(".svg")) {
      return SvgPicture.asset(
          imagePath,
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .width / 375.w * 232.h,
      );
    }
    else {
      return Container(
        child: Image.asset(
            imagePath,
            height: MediaQuery
                .of(context)
                .size
                .width / 375.w * 232.h,
            width: MediaQuery
                .of(context)
                .size
                .width
        ),
      );
    }
  }

  static Widget componentMainImageWithPadding(BuildContext context, String imagePath, EdgeInsets margin) {
    return Container(
      child: SvgPicture.asset(imagePath,
          height: MediaQuery
              .of(context)
              .size
              .width / 375.w * 232.h,
          width: MediaQuery
              .of(context)
              .size
              .width),
      margin: margin,
    );
  }

  static Widget componentMainImageDynamicSize(
      {required BuildContext context,
        required String imagePath,
        EdgeInsets? padding}) {
    return Center(
      child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: SvgPicture.asset(
              imagePath,
              width: MediaQuery.of(context).size.width
          )),
    );
  }

  static Widget componentMainSmallImage(BuildContext context, String imagePath) {
    return Container(
      child: SvgPicture.asset(imagePath,
          height: 100.h,
          width: 100.w),
    );
  }

  static Widget componentImageWithColor(
      { required BuildContext context,
        required String imagePath,
        required double width, required double height,
        Color? color = Colors.white } ) {
    return Container(
      child: SvgPicture.asset(imagePath,
          height: height,
          width: width,
          color: color
      ),
    );
  }

  static Widget componentMainPngImage(BuildContext context, String imagePath) {
    return Container(
      child: Image.asset(imagePath,
          height: MediaQuery
              .of(context)
              .size
              .width / 375.w * 232.h,
          width: MediaQuery
              .of(context)
              .size
              .width),
    );
  }

  static Widget componentPngImage(
      {double? width, double? height, Color? color, BoxFit? fit, required BuildContext context, required String imagePath}) {
    var imageWidth = width ?? ScreenUtils.screenWidth(context);
    var imageHeight = height ?? imageWidth;
    var boxFit = fit ?? BoxFit.contain;

    if (imageHeight > ScreenUtils.screenHeight(context)) {
      imageHeight = ScreenUtils.screenHeight(context);
    }

    return Container(
        child: Image.asset(imagePath,
            fit: boxFit,
            color: color,
            height: imageHeight,
            width: imageWidth));
  }

  static Widget componentTitleText(
      {required String title, EdgeInsets marginInsets = EdgeInsets.zero, TextAlign alignText = TextAlign.left}) {
    return Container(
      margin: marginInsets,
      child: Text(title, style: textStyle_bold_size_24_color_white(),
      textAlign: alignText,),
    );
  }

  static Widget componentInformationText(
      {required String text, EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: marginInsets,
      child: Text(
        text,
        style: textStyle_size_18_color_white(),
      ),
    );
  }

  static Widget componentDescriptionText(
      {required String text, EdgeInsets marginInsets = EdgeInsets.zero, TextAlign textAlignment = TextAlign.left}) {
    return Container(
      margin: marginInsets,
      child: Text(
        text,
        style: textStyle_size_15_color_old_silver(),
        textAlign: textAlignment,
      ),
    );
  }

  static Widget componentCenterDescriptionText(
      { required String text,
        EdgeInsets marginInsets = const EdgeInsets.symmetric(horizontal: 20.0)}) {

    return Container(
      margin: marginInsets,
      child: Center(
        child: Text(
          text,
          style: textStyle_size_15_color_old_silver(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static Widget componentDescriptionTextWithBox({required BuildContext context,
    required String contents,
    EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 20.h),
      decoration: componentApplianceSelectBoxDecorate(),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          contents,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  static Widget componentDescriptionTextSpanWithBox(
      {required List<InlineSpan> textSpan,
        EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      width: double.infinity,
      margin: marginInsets,
      decoration: componentApplianceSelectBoxDecorate(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: RichText(
          text: TextSpan(
            style: textStyle_size_18_color_white(),
            children: textSpan,
          ),
        ),
      ),
    );
  }

  static Widget componentDescriptionTextSpan(
      {required List<InlineSpan> textSpan,
        EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      width: double.infinity,
      margin: marginInsets,
      child: RichText(
        text: TextSpan(
          style: textStyle_size_18_color_white(),
          children: textSpan,
        ),
      ),
    );
  }

  static Widget componentDescriptionTextWithLinkAction(
      {required String contents,
        required String contentsForLink,
        required VoidCallback btnFunction}) {
    return Container(
      margin: EdgeInsets.zero,
      child: Center(
          child: RichText(
            text: TextSpan(
                style: textStyle_size_15_color_old_silver(),
                children: [
                  TextSpan(
                      text: contentsForLink,
                      style: TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          btnFunction();
                        }),
                ]),
          )),
    );
  }

  static Widget componentDescriptionTextWithLinkLabel(
      {required String contents,
        required String contentsForLink,
        required String link,
        EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: marginInsets,
      child: SizedBox(
          width: double.infinity,
          child: RichText(
            text: TextSpan(
                style: textStyle_size_15_color_old_silver(),
                children: [
                  TextSpan(text: contents + ' '),
                  TextSpan(
                      text: contentsForLink,
                      style: TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchURL(link);
                        }),
                ]),
          )),
    );
  }
  static Widget componentDescriptionTextWithLinkActionLabel(
      {required String contents,
        required String contentsForLink,
        VoidCallback? onTapButton,
        EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: marginInsets,
      child: SizedBox(
          width: double.infinity,
          child: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: colorOldSilver(), fontSize: 15),
                children: [
                  TextSpan(text: contents + ' '),
                  TextSpan(
                      text: contentsForLink,
                      style: TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          onTapButton!();
                        }),
                ]),
          )),
    );
  }

  static void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      geaLog.debug('Could not launch $url');
    }
  }

  static Widget componentUpperDescriptionText(String title) {
    return Container(
      height: 69.h,
      child: Center(
        child: Text(
          title,
          style: textStyle_size_18_bold_color_white(),
        ),
      ),
    );
  }

  static Widget componentBasicCustomButton(
      String text, VoidCallback btnFunction) {
    return ButtonTheme(
      minWidth: 80.w,
      height: 32.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
          backgroundColor: colorDeepPurple(),
        ),
        onPressed: btnFunction,
        child: Text(
          text,
          style: textStyle_size_14_bold_color_white(),
        ),
      ),
    );
  }

  static Widget componentBottomButton(
      {required String title, VoidCallback? onTapButton, bool isEnabled = true}) {
    return Container(
      height: 115.h,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 60.w),
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

  static Widget componentTwoBottomButtonWithWifi(String title1,
      VoidCallback onTapButton1, String title2, VoidCallback onTapButton2) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 48.h,
          child: Container(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImagePath.WIFI,
                      width: 20.w,
                      height: 16.h,
                    ),
                    BaseComponent.widthSpace(5.w),
                    Text(
                      title1.toUpperCase(),
                      style: textStyle_size_18_bold_color_white()
                    ),
                  ],
                ),
                onPressed: () {
                  onTapButton1();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorDeepPurple()
                ),
              ),
            ),
          ),
        ),
        BaseComponent.heightSpace(30.h),
        Container(
          height: 48.h,
          child: Container(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImagePath.WIFI,
                      width: 20.w,
                      height: 16.h,
                    ),
                    BaseComponent.widthSpace(5.w),
                    Text(
                      title2.toUpperCase(),
                      style: textStyle_size_18_bold_color_white(),
                    ),
                  ],
                ),
                onPressed: () {
                  onTapButton2();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorDeepPurple()
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget componentTwoBottomButton(
      String title1,
      VoidCallback onTapButton1,
      String title2,
      VoidCallback onTapButton2,
      {bool showButton2 = true}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 48.h,
          child: Container(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title1.toUpperCase(),
                      style: textStyle_size_18_bold_color_white(),
                    ),
                  ],
                ),
                onPressed: () {
                  onTapButton1();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorDeepPurple()
                ),
              ),
            ),
          ),
        ),
        showButton2 ? BaseComponent.heightSpace(30.h) : SizedBox(),
        showButton2 ? Container(
          height: 48.h,
          child: Container(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title2.toUpperCase(),
                      style: textStyle_size_18_bold_color_white(),
                    ),
                  ],
                ),
                onPressed: () {
                  onTapButton2();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorDeepPurple()
                ),
              ),
            ),
          ),
        ) : SizedBox(),
      ],
    );
  }

  static Widget componentMainSelectImageButton({
    required BuildContext context,
    required String pushName,
    required String imageName,
    String text = "",
    EdgeInsets marginInsets = const  EdgeInsets.symmetric(horizontal: 20.0),
    EdgeInsets paddingInsets = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0)}) {

    Widget image = text != "" ? SvgPicture.asset(imageName)
        : Expanded(child: SvgPicture.asset(imageName));

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(pushName);
      },
      child: Padding(
        padding: marginInsets,
        child: Container(
            width: double.infinity,
            height: 182.h,
            decoration: componentApplianceSelectBoxDecorate(),
            child: Padding(
                padding: paddingInsets,
                child: Row(
                  children: [
                    image,
                    if (text != "") Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(text, style: textStyle_size_18_bold_color_white(), textAlign: TextAlign.center)
                      ),
                    )
                  ],
                )
            )
        ),
      ),
    );
  }

  static Widget componentMainSelectVerticalImageButton({
    required BuildContext context,
    required String pushName,
    required String imageName,
    String text = "",
    EdgeInsets marginInsets = const  EdgeInsets.symmetric(horizontal: 20.0),
    EdgeInsets paddingInsets = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0)}) {

    Widget image = text != "" ? SvgPicture.asset(imageName)
        : Expanded(child: SvgPicture.asset(imageName));

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(pushName);
      },
      child: Padding(
        padding: marginInsets,
        child: Container(
            width: double.infinity,
            height: 182.h,
            decoration: componentApplianceSelectBoxDecorate(),
            child: Padding(
                padding: paddingInsets,
                child: Column(
                  children: [
                    image,
                    if (text != "") Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(text, style: textStyle_size_14_bold_color_white())
                      ),
                    )
                  ],
                )
            )
        ),
      ),
    );
  }

  static Widget componentBasicOutlinedButton(
      String text, VoidCallback btnFunction) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      height: 50.h,
      child: ButtonTheme(
        minWidth: 120.w,
        child: OutlinedButton(
            onPressed: btnFunction,
            child: Text(
                text.toUpperCase(),
                style: textStyle_size_18_bold_color_white()
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 2.0, color: colorDeepPurple()),
            )
        ),
      )
    );
  }

  static Widget componentCenterAlignedContainer(Widget widget) {
    return Container(
      child: Center(
        child: widget,
      ),
    );
  }

  static Widget componentCheckIcon(bool isOn) {
    return SvgPicture.asset(
        (isOn) ? ImagePath.CHECKBOX_CHECKED_ICON : ImagePath.CHECKBOX_UNCHECKED_ICON,
        width: 30.w,
        height: 30.h,
    );
  }

  static Widget componentInfoIcon() {
    return SvgPicture.asset(
      ImagePath.REMEMBER_NETWORK_INFO_ICON,
      width: 15.w,
      height: 15.h
    );
  }

  static Widget componentMainSelectVerticalTypeImageButton({
    required BuildContext context,
    required String pushName,
    required String imageName,
    double height = 182.0,
    String text = "",
    EdgeInsets? imageEdgeInsets}) {
    Widget image = text != "" ? SvgPicture.asset(imageName)
        : Expanded(child: SvgPicture.asset(imageName));

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(pushName);
      },
      child: Padding(
        padding: componentApplianceSelectBoxInsets(),
        child: Container(
            width: double.infinity,
            height: height,
            decoration: componentApplianceSelectBoxDecorate(),
            child: Padding(
                padding: imageEdgeInsets ?? EdgeInsets.zero,
                child: Column(
                  children: [
                    image,
                    if (text != "") Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(text, style: textStyle_size_15_bold_color_white())
                      ),
                    )
                  ],
                )
            )
        ),
      ),
    );
  }
  static Widget componentMainSelectImageButtonWithoutBox({
    required BuildContext context,
    required String pushName,
    required String imageName,
    String text = "",
    EdgeInsets marginInsets = const  EdgeInsets.symmetric(horizontal: 20.0),
    EdgeInsets paddingInsets = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0)}) {
    Widget image = text != "" ? SvgPicture.asset(imageName)
        : Expanded(child: SvgPicture.asset(imageName));

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(pushName);
      },
      child: Padding(
        padding: marginInsets,
        child: Container(
            width: double.infinity,
            height: 282.h,
            child: Padding(
                padding: paddingInsets,
                child: Row(
                  children: [
                    image,
                    if (text != "") Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(text, style: textStyle_size_18_bold_color_white())
                      ),
                    )
                  ],
                )
            )
        ),
      ),
    );
  }

  static Widget componentMainSelectImageButtonDynamicSize(
      {required BuildContext context,
      required String pushName,
      required String imageName,
      String text = "",
      double? imageWidth,
      double? imageHeight,
      EdgeInsets marginInsets = EdgeInsets.zero,
      EdgeInsets paddingInsets =
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0)}) {
    Widget image = text != ""
        ? SvgPicture.asset(imageName, width: imageWidth, height: imageHeight)
        : Expanded(child: SvgPicture.asset(imageName, width: imageWidth, height: imageHeight));

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(pushName);
      },
      child: Padding(
        padding: marginInsets,
        child: Container(
            width: double.infinity,
            height: 182.h,
            decoration: componentApplianceSelectBoxDecorate(),
            child: Padding(
                padding: paddingInsets,
                child: Row(
                  children: [
                    image,
                    if (text != "")
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(text,
                                style: textStyle_size_18_bold_color_white(),
                                textAlign: TextAlign.center)),
                      )
                  ],
                ))),
      ),
    );
  }

  static Widget componentNavigationPageControl(List pages,
      ValueNotifier<int> pageNotifier) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 28.w),
      child: CirclePageIndicator(
        size: 8.w,
        selectedSize: 8.w,
        dotSpacing: 16.w,
        dotColor: Colors.white.withOpacity(0.2),
        selectedDotColor: Colors.white,
        itemCount: pages.length,
        currentPageNotifier: pageNotifier,
      ),
    );
  }

  static Widget componentCenterTextBox(String string) {
    return Text(
      string,
      style: textStyle_size_18_bold_color_white(),
      textAlign: TextAlign.center,
    );
  }

  static Widget componentQuestionText({required BuildContext context,
    required String text,
    String? pushName,
    bool useRootNavigator = false,
    EdgeInsets marginInsets = EdgeInsets.zero,
    TextAlign alignText = TextAlign.left,
    Function? onTap}) {
    return GestureDetector(
      onTap: (onTap != null)
          ? onTap as void Function()?
          : () {
        if (pushName != null) {
          if (useRootNavigator)
            Navigator.of(context, rootNavigator: true).pushNamed(pushName);
          else
            Navigator.of(context).pushNamed(pushName);
        }
      },
      child: Padding(
        padding: marginInsets,
        child: Text(
          text,
          style: textStyle_underline_size_15_color_grey(),
          textAlign: alignText,
        ),
      ),
    );
  }

  static Widget componentListSectionTitle(String? title) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          title ?? "",
          style: textStyle_size_15_color_old_silver(),
        ),
      ),
    );
  }

  static Widget componentCommissioningBody(BuildContext context,
      List<Widget> widgets, Widget bottomButton,
      {ScrollController? scrollController}) {
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                    controller: scrollController ?? ScrollController(),
                    children: widgets,
                  )),
              bottomButton,
            ],
          ),
        ));
  }

  static Widget componentCommissioningBodyWithBottomItem(BuildContext context,
      List<Widget> widgets, Widget bottomButton, Widget bottomItem,
      {ScrollController? scrollController}) {
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView(
                    controller: scrollController ?? ScrollController(),
                    children: widgets,
                  )),
              bottomButton,
              BaseComponent.heightSpace(15.h),
              bottomItem,
            ],
          ),
        ));
  }

  static Widget componentCommissioningBottomButton(BuildContext context,
      String title, VoidCallback onTapButton) {
    return Container(
      height: 115.h,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 60.w),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: ElevatedButton(
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              onTapButton();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorDeepPurple()
            ),
          ),
        ),
      ),
    );
  }

  static Widget componentGrayRoundTextBox(BuildContext context,
      String contents) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 20.h),
      decoration: componentApplianceSelectBoxDecorate(),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          contents,
          style: textStyle_size_18_color_white(),
        ),
      ),
    );
  }

  static Widget componentNotificationSettingItem(
      BuildContext context,
      String title,
      String description,
      bool enable,
      { required Future<bool> future(),
        required void onChange(bool value),
        required void onTap(bool value) }) {
    return Column(
      children: [
        BaseComponent.heightSpace(13.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 12.h),
          decoration: componentApplianceSelectBoxDecorate(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Flexible(
                    child: Text(title.toUpperCase(),
                        style: textStyle_size_15_bold_color_white()),
                  ),
                  LoadSwitch(
                    falseColor: colorOldSilver(),
                    trueColor: colorDeepPurple(),
                    spinColor: colorDeepPurple(),
                    thumbPadding: 1.0,
                    width: 50,
                    height: 30,
                    value: enable,
                    future: future,
                    onChange: onChange,
                    onTap: onTap)
                ],
              ),
              BaseComponent.heightSpace(5.h),
              Text(description, style: textStyle_size_13_color_old_silver(),),
            ],
          ),
        ),
        BaseComponent.heightSpace(12.h),
      ],
    );
  }

  static Widget componentNotice({
    required String title,
    required String buttonTitle,
    EdgeInsets marginInsets = EdgeInsets.zero,
    required bool showButton,
    required VoidCallback btnFunction}) {
    return Container(
      margin: marginInsets,
      child: Column(
        children: <Widget>[
          BaseComponent.heightSpace(40.h),
          Text(title,
              style: textStyle_size_16_bold_color_white(),
              textAlign: TextAlign.center),
          BaseComponent.heightSpace(18.h),
          Visibility(
            visible: showButton,
            child: Component.componentBasicCustomButton(buttonTitle, btnFunction),
          ),
          BaseComponent.heightSpace(38.h),
        ],
      ),
    );
  }

  static Widget componentMainScanLoading({required String title}) {
    return Container(
      child: Column(
        children: <Widget>[
          BaseComponent.heightSpace(13.h),
          Image.asset(
            ImagePath.BLE_SCAN_IMAGE_PATH,
            height: 96.h,
            width: 96.w,
          ),
          BaseComponent.heightSpace(13.h),
          Text(title, style: textStyle_size_16_bold_color_white()),
          BaseComponent.heightSpace(46.h)
        ],
      ),
    );
  }

  static Widget pageIndicator(int numberOfPages, int activePage, {double size = 10, double spacing = 3}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        numberOfPages,
        (index) {
          return Container(
            margin: EdgeInsets.all(spacing),
            width: size,
            height: size,
            decoration: BoxDecoration(
                color: activePage == index ? Colors.white : Colors.white24,
                shape: BoxShape.circle),
          );
        },
      ),
    );
  }

  static Decoration commonCardBackgroundDecoration() {
    return BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.all(Radius.circular(8.r),
        ),
    );
  }

  static Widget greyCardBackground(
      {EdgeInsets? margin, EdgeInsets? padding, required Widget child}) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: child,
    );
  }

  static Widget greyCardText({EdgeInsets? padding, required String text}) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: textStyle_size_18_color_white(),
        textAlign: TextAlign.left,
      ),
    );
  }

  static Widget componentGeModuleNameTextfield(
      BuildContext context,
      String title,
      FocusNode focusNode,
      ValueSetter<TextFieldStatus> textFieldStatus,
      ValueSetter<String> textValue) {

    var paddingWith = 20.0;

    if (ScreenUtils.screenWidth(context) < 400) {
      if (ScreenUtils.screenWidth(context) < 300) {
        paddingWith = 0;
      }
      else {
        paddingWith = 28.0;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingWith, vertical: 20.h),
      child: Row(
        children: [
          componentDescriptionText(text: title),
          Expanded(
            child: Form(
              child: PinCodeTextField(
                appContext: context,
                textStyle:textStyle_size_18_bold_color_white(),
                length: 4,
                textCapitalization: TextCapitalization.characters,
                obscureText: false,
                animationType: AnimationType.fade,
                focusNode: focusNode,
                autoDisposeControllers: false,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5.r),
                    fieldHeight: 35.h,
                    fieldWidth: 30.w,
                    activeColor: Colors.white),
                animationDuration: Duration(milliseconds: 300),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.allow(RegExp('[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0]')),
                  FilteringTextInputFormatter.deny(RegExp(' '))
                ],
                backgroundColor: Colors.transparent,
                enableActiveFill: false,
                onCompleted: (value) {
                  textValue(value);
                },
                onChanged: (value) {
                  textValue(value);
                  if (value.length == 4) {
                    textFieldStatus(TextFieldStatus.equalToMaxLength);
                  }
                  else {
                    textFieldStatus(TextFieldStatus.empty);
                  }
                },
                beforeTextPaste: (text) {
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget componentPincodeTextfield(
      BuildContext context,
      FocusNode focusNode,
      ValueSetter<TextFieldStatus> textFieldStatus,
      ValueSetter<String> textValue) {

    var paddingWith = 20.w;

    if (ScreenUtils.screenWidth(context) < 400.w) {
      if (ScreenUtils.screenWidth(context) < 300.w) {
        paddingWith = 0.w;
      }
      else {
        paddingWith = 28.w;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingWith, vertical: 20.h),
      child: Form(
        child: PinCodeTextField(
          appContext: context,
          textStyle:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          length: 8,
          textCapitalization: TextCapitalization.characters,
          obscureText: false,
          animationType: AnimationType.fade,
          focusNode: focusNode,
          autoDisposeControllers: false,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(5.r),
              fieldHeight: 35.h,
              fieldWidth: 30.w,
              activeColor: Colors.white),
          animationDuration: Duration(milliseconds: 300),
          inputFormatters: [
            UpperCaseTextFormatter(),
            FilteringTextInputFormatter.allow(RegExp('[B C D F G H J K L M N P Q R S T V W X Y Z b c d f g h j k l m n p q r s t v w x y z]')),
            FilteringTextInputFormatter.deny(RegExp(' '))
          ],
          backgroundColor: Colors.transparent,
          enableActiveFill: false,
          onCompleted: (value) {
            textValue(value);
          },
          onChanged: (value) {
            textValue(value);
            if (value.length == 8) {
              textFieldStatus(TextFieldStatus.equalToMaxLength);
            }
            else {
              textFieldStatus(TextFieldStatus.empty);
            }
          },
          beforeTextPaste: (text) {
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    );
  }

  static Widget greyCardImageAndText(
      {EdgeInsets? padding, required String imagePath, required String text}) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(children: [
        SizedBox(
          width: 30.w,
          child: SvgPicture.asset(
            imagePath,
            height: 56.h,
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: Text(
            text,
            style: textStyle_size_18_color_white(),
          ),
        ),
      ]),
    );
  }

  // Temporal
  static Widget componentGrayRoundedBoxButton( {
    required BuildContext context,
    required String title,
    required VoidCallback btnFunction}) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 20.h),
        decoration: componentApplianceSelectBoxDecorate(),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: btnFunction,
              style: ElevatedButton.styleFrom(
                  backgroundColor: colorRaisinBlack(),
                  foregroundColor: colorRaisinBlack(),
              ),
              child: Text(title,
                  style: textStyle_size_18_color_white()
              )
          ),
        ),
      );
  }

  static Widget componentInfoIcon30Opacity() {
    return Icon(
      Icons.info,
      color: Colors.white.withOpacity(0.3),
      size: 27.w,
    );
  }

  static Widget componentArrowForwardIcon() {
    return Icon(
      Icons.arrow_forward_ios,
      color: Colors.white,
      size: 12.w,
    );
  }

  static Widget componentHorizontalDivider() {
    return Divider(
      height: 1.h,
      color: Colors.grey
    );
  }

  static Widget componentApplianceGridListTile( {
    required BuildContext context,
    required String? title,
    required String? imagePath,
    required VoidCallback clickedFunction}) {

    return new GridTile(
      child: Container(
        decoration: componentApplianceSelectBoxDecorate(),
        child: new Card(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
            elevation: 0,
            color: Colors.transparent,
            child: new InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment(0, 0.25),
                        child: FractionallySizedBox(
                            child: SvgPicture.asset(
                              imagePath ?? "",
                              height: 65.h
                            )
                        ),
                      ),
                    ),
                    Text(
                      title ?? "",
                      style: textStyle_size_15_bold_color_white(),
                      textAlign: TextAlign.center,
                    ),
                    BaseComponent.heightSpace(19.h)
                  ],
                ),
              ),
              onTap: () {
                clickedFunction();
              },
            )),
      ),
    );
  }

  static Widget componentApplianceVerticalListTile ({
    required BuildContext context,
    required String? title,
    String? imagePath,
    required VoidCallback clickedFunction,
    double height = 170,
    double iconWidth = 70.0,
    bool isLongIcon = false,
    Alignment alignment = Alignment.centerLeft,
    bool isVisible = true}) {
    return (isVisible) ? Padding(
      padding: componentApplianceSelectBoxInsets(),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Container(
          decoration: componentApplianceSelectBoxDecorate(),
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            color: Colors.transparent,
            elevation: 0,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    (imagePath != null) ? Container(
                      width: (iconWidth + 10.w),
                      height: ((isLongIcon)? (height - 40.h) : 70.h),
                      child: SvgPicture.asset(
                        imagePath),
                    ) : Container(),
                    (imagePath != null) ? BaseComponent.widthSpace(30.w) : Container(),
                    Expanded(
                      child: Container(
                        alignment: alignment,
                        child: Text(title ?? "",
                            style: textStyle_size_18_bold_color_white()),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                clickedFunction();
              },
            ),
          ),
        ),
      ),
    ) : Container();
  }

  static Widget componentApplianceSelectTypeTitle({
    required String? title,
    TextAlign textAlign = TextAlign.center,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 20.0)}) {
    return Container(
      margin: margin,
      child: Center(
        child: Text(
          title ?? "",
          style: textStyle_size_18_bold_color_white(),
          textAlign: textAlign,
        ),
      ),
    );
  }

  static EdgeInsets componentApplianceSelectBoxInsets() {
    return EdgeInsets.symmetric(horizontal: 20.w);
  }

  static BoxDecoration componentApplianceSelectBoxDecorate() {
    return BoxDecoration(
        gradient: gradientRaisinBlackDarkCharcoal(),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        )
    );
  }

  static Widget componentMainPngImageDynamic(BuildContext context, String imagePath) {
    return Container(
      child: Image.asset(imagePath,
          height: MediaQuery
              .of(context)
              .size
              .width,
          width: MediaQuery
              .of(context)
              .size
              .width),
    );
  }

  static Widget componentCenterDescriptionTextCenterAlign(
      {required String text, EdgeInsets marginInsets = EdgeInsets.zero}) {
    return Container(
      margin: marginInsets,
      child: Text(
        text,
        style: textStyle_size_15_color_old_silver(),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget componentBaseContent({
    required BuildContext context,
    required String title,
    required Widget innerContent,
    Widget? footerContent,
    EdgeInsets? padding,
  }) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: title,
        leftBtnFunction: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
      ).setNavigationAppBar(context: context),
      body: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(child: innerContent),
      ),
      bottomNavigationBar: footerContent,
    );
  }

  static Widget componentWhiteOutlinedButton(
      String text, VoidCallback onTapButton) {
    return Container(
        height: 48.h,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 60.w),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: OutlinedButton(
                  onPressed: onTapButton,
                  child: Text(text.toUpperCase(),
                      style: textStyle_size_18_bold_color_white()),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: Colors.white),
                  )),
            )));
  }
}
