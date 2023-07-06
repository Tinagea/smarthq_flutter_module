import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class ReusableCollapsibleCard extends StatefulWidget {
  ///Whether to convert the card between expandable and compressed.
  ///
  ///If this is set to true you will also need to set the arguments for cardTopRightText, and childWidget.
  final bool isExpandableCard;

  ///Text displayed at the top left of the card, usually a title.
  final String cardTopLeftText;

  ///Text displayed at the top right of the card, usually a subtext.
  final String? cardTopRightText;

  ///Child Widget to be laid inside of cards that are expandable, required only for cards which will be expanded.
  final Widget? childWidget;

  ///Route name for compressed card, will be called onTap for the arrow on right side of card. Required for compressed cards.
  final String? routeName;

  ///Determines whether the compressed card will show the cardTopRightText as well as the forward icon.
  final bool? shouldShowRightTextAndIcon;

  ///Determines whether the info icon will show to the right of the cardTopLeftText
  final bool? shouldShowInfoIcon;

  ///Determines whether the urgent icon will show to the right of the cardTopLeftText
  final bool? shouldShowUrgentIcon;
  
  ///Passed a pop-up function to be triggered by tapping the card
  Function? popUpCallback;

  //Determines wether the card is expanded or not.
  final bool? isRemoteEnabled;

  ReusableCollapsibleCard({
    required this.isExpandableCard,
    required this.cardTopLeftText,
    required this.cardTopRightText,
    this.isRemoteEnabled,
    this.childWidget,
    this.routeName,
    this.shouldShowRightTextAndIcon,
    this.shouldShowInfoIcon,
    this.shouldShowUrgentIcon,
    this.popUpCallback,
    Key? key
  }) : super(key: key);

  @override
  ReusableCollapsibleCardState createState() => ReusableCollapsibleCardState();
}

class ReusableCollapsibleCardState extends State<ReusableCollapsibleCard> {
  late bool isCardExpanded;
  bool isFirstOpen = true;
  double expandedCardHeight = 510.h;

  @override
  void initState() {
    isCardExpanded = widget.isRemoteEnabled ?? false;
    determineAnimationSpeed();
    delayVisibilityChange();
    super.initState();
  }


    int determineAnimationSpeed() {
      var height = expandedCardHeight.toInt();
      if (height <= 200.h) {
        return (height * 2).toInt();
      }

      return expandedCardHeight.toInt();
    }
    Future<bool> delayVisibilityChange() async {
      if (!isCardExpanded) {
        await Future.delayed(Duration(milliseconds: determineAnimationSpeed() - 120));
      }

      return isCardExpanded;
    }

  void toggleCard() {
    setState(() {
      isCardExpanded = !isCardExpanded;
    });
  }

  void expandOnLoad(){
    if(widget.isRemoteEnabled == false){
      isFirstOpen = true;
      isCardExpanded = false;
    }

    if(isFirstOpen && widget.isRemoteEnabled == true){
      isFirstOpen = false;
      setState(() {
        expandedCardHeight += 25.h;
        isCardExpanded = true;
      });
    }else{
      expandedCardHeight = 550.h;
    }
  }

    @override
  void didUpdateWidget(covariant ReusableCollapsibleCard oldWidget) {
    if(!isFirstOpen && widget.isRemoteEnabled == true){
      setState(() {
        isCardExpanded = true;
      });
    }
    super.didUpdateWidget(oldWidget);
  }



  @override
  Widget build(BuildContext context) {
    expandOnLoad();
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0.h),
      child: Stack(
        children:[
          SizedBox(
            width: MediaQuery.of(context).size.width - 12.w,
            child: AnimatedContainer(
              height: isCardExpanded ? expandedCardHeight : 60.h,
              duration: Duration(milliseconds: determineAnimationSpeed()),
              decoration: BoxDecoration(
                gradient: gradientDarkGreyCharcoalGrey(),
                borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.w)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0.h),
                      child: Row(
                        children: [
                          Visibility(
                            visible: widget.isExpandableCard,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0.w),
                              child: SizedBox(
                                height: 25.h,
                                width: 25.w,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                  child: Center(
                                    child: Icon(
                                      isCardExpanded ? Icons.expand_less : Icons.expand_more,
                                      color: Colors.black,
                                      size: 25.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, top: widget.isExpandableCard ? 0.h : 4.h),
                            child: Text(widget.cardTopLeftText, style: textStyle_size_14_bold_color_white()),
                          ),
                          SizedBox(width: 12.w),
                          Visibility(
                            visible: widget.shouldShowInfoIcon ?? false,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Component.componentInfoIcon(),
                            ),
                          ),
                          Visibility(
                            visible: widget.shouldShowUrgentIcon ?? false,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 28.h,
                                width: 28.w,
                                child: Image(image: AssetImage(ImagePath.STAND_MIXER_ALERT)),
                              )
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 16.w, top: widget.isExpandableCard ? 0.h : 4.h),
                            child: widget.isExpandableCard || widget.cardTopRightText == LocaleUtil.getString(context, LocaleUtil.OFFLINE)!.toUpperCase()
                              ? Text(widget.cardTopRightText!,
                                  style: widget.cardTopRightText.toString().toLowerCase() == 'off'
                                    ? textStyle_size_14_bold_color_white_33_opacity()
                                    : textStyle_size_14_bold_color_white())
                              : (widget.shouldShowRightTextAndIcon != null && widget.shouldShowRightTextAndIcon!)
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(widget.routeName!);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 16.w),
                                          child: Text(widget.cardTopRightText!,
                                              style: textStyle_size_16_bold_color_white()
                                          ),
                                        ),
                                        Component.componentArrowForwardIcon(),
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(widget.routeName!);
                                    },
                                    child: Component.componentArrowForwardIcon(),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isExpandableCard,
                    child: FutureBuilder(
                      future: delayVisibilityChange(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return AnimatedScale(
                            duration: Duration(milliseconds: determineAnimationSpeed()),
                            alignment: Alignment.topCenter,
                            scale: isCardExpanded ? 1 : 0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 12.0.h),
                                  child: Component.componentHorizontalDivider(),
                                ),
                                Visibility(
                                  visible: snapshot.data,
                                  child: widget.childWidget!,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                ]
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (widget.cardTopRightText.toString() == 'Remote Enabled') {
                toggleCard();
              } else {
                widget.popUpCallback!();
              }
            },
            child: Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width - 26.w,
            ),
          ),
        ]
      )
    );
  }
}
