import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/utils/measure_size_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class CustomAlertDialog extends StatefulWidget {
  ///Title for the alert, will be displayed at the top of the dialog.
  final String title;

  ///Text that will be included in the body of the dialog.
  final String bodyText;

  ///Image that will be shown above the body text.
  final String? imageUri;

  ///Image Size.
  final Size imageSize;
  
  ///Toggles the direction of buttons
  final bool verticalButtons;

  //Multiplies the size of the card
  final double? fractionMultiplier;

  final EdgeInsets titlePadding;

  ///List of [AlertPopupAction] items that will populate the buttons at the bottom of the dialog.
  ///Buttons will be presented from top to bottom in the order they are initialized here.
  final List<AlertPopupAction> buttonActions;
  const CustomAlertDialog({
      required this.title,
      required this.buttonActions,
      required this.bodyText,
      required this.imageSize,
      this.verticalButtons = true, 
      this.imageUri,
      this.fractionMultiplier = 1.0,
      this.titlePadding =  const EdgeInsets.only(left: 20, right: 20, top: 10),
      Key? key
      }) : super(key: key);
  @override
  State<CustomAlertDialog> createState() => _AlertDialogState();
}

class _AlertDialogState extends State<CustomAlertDialog> {
  int dialogHeight = 61;
  double determineDialogSizeFraction() {
    return dialogHeight / MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    determineDialogSize();
    super.initState();
  }

  void determineDialogSize() {
    if (widget.bodyText.isNotEmpty) {
      dialogHeight += 80;
    }
    if (widget.imageUri!.isNotEmpty) {
      dialogHeight += (widget.imageSize.height * 1.34).toInt();
    }
    dialogHeight += (widget.buttonActions.length * 30);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textStyle_size_18_color_black(),
      child: FractionallySizedBox(
        heightFactor: determineDialogSizeFraction() * widget.fractionMultiplier!,
        widthFactor: 0.8,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.w)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MeasureSize(
                  onChange: (size) => (){
                    dialogHeight += size.height.toInt();
                    setState(() {
                      determineDialogSize();
                    });
                  },
                  child: Padding(
                    padding: widget.titlePadding,
                    child: Text(widget.title,
                        textAlign: TextAlign.center,
                        style: textStyle_size_18_bold_color_black()
                          ),
                  ),
                ),
                Visibility(
                    visible: widget.imageUri != null,
                    child: Container(
                      height: widget.imageSize.height,
                      width: widget.imageSize.width,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: (widget.imageUri!.endsWith('.svg'))
                        ? SvgPicture.asset(widget.imageUri!)
                        : Image.asset(widget.imageUri ?? ""),
                      ),
                    )),
                Visibility(
                  visible: widget.bodyText.isNotEmpty,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                        child: Text(widget.bodyText,
                          textAlign: TextAlign.center,
                          style: textStyle_size_16_semi_bold_color_black()
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.buttonActions.length > 1 ? widget.buttonActions.length * 50 : 60.h,
                  child: ListView.builder(
                    scrollDirection: widget.verticalButtons ? Axis.vertical : Axis.horizontal,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.buttonActions.length,
                      itemBuilder: (context, index) {
                        return widget.verticalButtons ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60.h,
                              child: GestureDetector(
                                onTapCancel: (() => setState(() {
                                  widget.buttonActions[index].backgroundColor =Colors.transparent;
                                  })),
                                onTapDown: ((_) => setState(() {
                                  widget.buttonActions[index].backgroundColor = colorOuterSpace().withOpacity(0.4);
                                  })),
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  widget.buttonActions[index].action();
                                  Navigator.pop(context);
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 150),
                                  color: widget.buttonActions[index].backgroundColor,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                    Divider(
                                      height: 1.h,
                                      color: colorOuterSpace(),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Center(
                                      child: Text(
                                          widget.buttonActions[index].title.toUpperCase(),
                                          style: textStyle_size_16_bold_color_deep_purple(),
                                        ),
                                    ),
                                    
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ):
                        Row(
                          children: [
                            GestureDetector(
                              onTapCancel: (() => setState(() {
                                widget.buttonActions[index].backgroundColor = Colors.transparent;
                              })),
                              onTapDown: ((_) => setState(() {
                                widget.buttonActions[index].backgroundColor = colorOuterSpace().withOpacity(0.4);
                              })),
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                widget.buttonActions[index].action();
                                Navigator.pop(context);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 150),
                                color: widget.buttonActions[index].backgroundColor,
                                child: Row(
                                    children: [
                                      Divider(
                                        height: 1,
                                        color: colorOuterSpace(),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 17.h, bottom: 17.h),
                                        child: Text(
                                          widget.buttonActions[index].title.toUpperCase(),
                                          style: textStyle_size_16_bold_color_deep_purple()
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        );
                      }),
                )
              ],
            )),
      ),
    );
  }
}

class AlertPopupAction {
  final String title;
  final Function action;
  Color backgroundColor = Colors.transparent;
  AlertPopupAction({required this.title, required this.action});
}
