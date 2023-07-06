import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoDialog extends StatefulWidget {
  final List<String> title;
  final List<String> imageURIs;
  final bool canSwipe;
  final int cardCount;
  final List<String> subText;
  final String finalButtonText;
  final TextStyle? titleStyle;
  final TextStyle? subTextStyle;
  final EdgeInsets? titlePadding;
  final List<Size> imageSizes;
  final String? buttonText;
  final Function? onTap;
  final bool? hasSecondButton;
  final String? secondButtonText;
  final Function? onSecondButtonTap;
  final List<EdgeInsets>? imagePadding;
  final List<BoxFit>? imageFit;
  final List<Offset>? offsets;
  final bool shouldFitTextInBox;
  InfoDialog({
    Key? key,
    required this.title,
    required this.imageURIs,
    this.cardCount = 3,
    this.titleStyle,
    this.titlePadding,
    this.subText = const [LocaleUtil.SMARTSENSE_IS_A_SMART_HOME_APPLIANCE],
    this.subTextStyle,
    this.finalButtonText = LocaleUtil.LETS_START, 
    this.buttonText,
    required this.imageSizes,
    this.onTap,
    this.hasSecondButton,
    this.secondButtonText,
    this.onSecondButtonTap,
    this.imagePadding,
    this.canSwipe = false, this.imageFit,
    this.offsets,
    this.shouldFitTextInBox = true,
  }) : super(key: key);

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int currentPage = 0;

  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentPage = _pageController.page!.round() + 1;
    });
  }

  _InfoDialogState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 15.h,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
        height: isActive ? 10.h : 8.0.h,
        width: isActive ? 10.w : 8.0.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? colorSpanishGray() : Colors.white,
          border: Border.all(
            color: colorSpanishGray(),
            width:1.0.w
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildPageIndicator() {
      List<Widget> list = [];
      for (int i = 0; i < widget.cardCount; i++) {
        list.add(i == currentPage ? _indicator(true) : _indicator(false));
      }
      return list;
    }

    return AlertDialog(
      title: Text(widget.title[currentPage],
        textAlign: TextAlign.center,
        style: widget.titleStyle ?? textStyle_size_20_bold_color_deep_purple()),
      titlePadding: widget.titlePadding ?? EdgeInsets.only(top: 30.h, left: 30.w, right: 10.w, bottom: 20.h),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      content: Container(
        height: 330.h,
        width: 175.w,
        child: PageView(
          physics: widget.canSwipe? null: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: List.generate(widget.cardCount, (index) {
            return Stack(
              children: [
                Center(
                  child: Padding(
                    padding: widget.imagePadding != null?  widget.imagePadding![index] : EdgeInsets.only(bottom:40.0),
                    child: Transform.translate(
                      offset: (widget.offsets != null ) ? widget.offsets![index]: Offset(0, -5.5),
                      child: Container(
                        height: widget.imageSizes[index].height,
                        width: widget.imageSizes[index].height,
                        decoration:
                        (!widget.imageURIs[index].toString().contains('.svg'))
                        ? BoxDecoration(
                          image: DecorationImage(
                          fit: (widget.imageFit != null)? widget.imageFit![index]: BoxFit.contain,
                          image:AssetImage(widget.imageURIs[index]))) 
                        : BoxDecoration(
                          color: Colors.white,
                        ),
                        child:(widget.imageURIs[index].toString().contains('.svg'))
                        ? SvgPicture.asset(
                          widget.imageURIs[index],
                          height: widget.imageSizes[index].height,
                          width: widget.imageSizes[index].height,
                        )
                        : Container(),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 120.h,
                    width: 240.w,
                    child: widget.shouldFitTextInBox
                    ? FittedBox(
                      child: Text(
                          widget.subText[index],
                          textAlign: TextAlign.center,
                          style: widget.subTextStyle ?? textStyle_size_18_color_black(),
                        ),
                    ) 
                    : Text(
                      widget.subText[index],
                      textAlign: TextAlign.center,
                      style: widget.subTextStyle ?? textStyle_size_18_color_black(),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      actionsPadding: EdgeInsets.zero,
      actions: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(0, -10.0.h),
                child: SizedBox(
                  height: 30.h,
                  child: Padding(
                    padding: EdgeInsets.all(4.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ),
                ),
              ),
              Component.componentHorizontalDivider(),
              InkWell(
                  onTap: () {
                    if (currentPage == widget.cardCount - 1) {
                      Navigator.pop(context);
                    } else {
                      nextPage();
                    }
                    widget.onTap?.call();
                  },
                  child: Container(
                    width: 250.w,
                    height: 70.h,
                    child: Center(
                      child: Text(widget.buttonText 
                      ?? LocaleUtil.getString(context, widget.cardCount - 1 != currentPage ? LocaleUtil.NEXT : widget.finalButtonText)!.toUpperCase(),
                        style: textStyle_size_16_bold_color_deep_purple(),
                      ),
                    ),
                  )),
              if (widget.hasSecondButton == true)
               Component.componentHorizontalDivider(),
              if (widget.hasSecondButton == true)
                InkWell(
                  onTap: () {
                    widget.onSecondButtonTap?.call();
                  },
                  child: Container(
                    width: 250.w,
                    height: 70.h,
                    child: Center(
                      child: Text(
                        widget.secondButtonText ?? LocaleUtil.getString(context, LocaleUtil.CANCEL)!,
                        style: textStyle_size_16_bold_color_deep_purple(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
