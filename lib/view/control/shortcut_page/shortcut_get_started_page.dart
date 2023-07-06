import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_get_started_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/animation_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_app_bar.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_component.dart';

class ShortcutGetStartedPage extends StatefulWidget {
  @override
  _ShortcutGetStartedPage createState() => _ShortcutGetStartedPage();
}

class _ShortcutGetStartedPage extends State<ShortcutGetStartedPage> {
  final PageController _pageController = PageController(initialPage: 0);//, keepPage: false);
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ShortcutGetStartedPage:deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: ShortcutAppBar(
                title: "",
                isRightButtonShown: false,
                backgroundColor: Colors.black,
                leftBtnFunction: (){
                  SystemNavigator.pop(animated: true);
                }
            ).setNavigationAppBar(context: context),
            body: Column(
                children:[
                  Expanded(
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: 3,
                        itemBuilder: (context, index) => GuidanceSlider(index)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < 3; i++) GuidancePager(i == _currentPage)
                    ],
                  ),
                  Visibility(
                    visible: (_currentPage != 2),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          ElevatedButton(
                            child: Text(
                                LocaleUtil.getString(context, LocaleUtil.SKIP)!,
                                style: textStyle_size_15_color_grey()),
                            onPressed: (){
                              _pageController.jumpToPage(2);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            child: Text(
                                LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                                style: textStyle_size_15_color_grey()),
                            onPressed: (){
                              int currentIndex = (_pageController.page?.toInt() ?? 0) + 1;
                              geaLog.debug("_pageController: $currentIndex");
                              _pageController.jumpToPage(currentIndex++);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (_currentPage == 2),
                    child: Container(
                      height: 53.h,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 0),
                        child: ConstrainedBox(
                            constraints: BoxConstraints.expand(),
                            child: ElevatedButton(
                              child: Text(
                                LocaleUtil.getString(context, LocaleUtil.CREATE_A_NEW_SHORTCUT)!,
                                style: textStyle_size_18_bold_color_white(),
                              ),
                              onPressed: () {
                                SystemNavigator.pop(animated: true);
                                BlocProvider.of<ShortcutGetStartedCubit>(context).finishGuidance();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                                ),
                                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                  return colorDeepPurple();
                                }),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: (_currentPage == 2),
                      child:
                      ElevatedButton(
                        child: Text(
                            LocaleUtil.getString(context, LocaleUtil.LATER)!,
                            style: textStyle_underline_size_15_color_grey()),
                        onPressed: (){
                          SystemNavigator.pop(animated: true);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black
                        ),
                      ),
                  )
                ]
            )
        )
    );
  }

  _onPageChanged(int index) {
    setState(() {
      geaLog.debug("ShortcutGetStartedPage:_onPageChanged - $index");
      _currentPage = index;
    });
  }
}

class GuidanceSlider extends StatefulWidget {
  final int index;
  const GuidanceSlider(this.index);

  @override
  _GuidanceSlider createState() => _GuidanceSlider();
}

class _GuidanceSlider extends State<GuidanceSlider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return FittedBox(
          child: Column(
            children: [
              Lottie.asset(
                  getAnimationPath(widget.index),
                  width: MediaQuery.of(context).size.width,
                  height: null),
              ShortcutComponent.componentCenterDescriptionText(
                  text: getInformationContext(ContextUtil.instance.routingContext!, widget.index),
                  marginInsets: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
              )],
          ),
          fit: BoxFit.scaleDown,
        );
      }
    );
  }

  String getAnimationPath(int index) {
    switch (index) {
      case 0:
        return AnimationPath.SHORTCUT_GUIDANCE_STEP1;
      case 1:
        return AnimationPath.SHORTCUT_GUIDANCE_STEP2;
      case 2:
        return AnimationPath.SHORTCUT_GUIDANCE_STEP3;
      default:
        return AnimationPath.SHORTCUT_GUIDANCE_STEP1;
    }
  }

  String? getInformationContext(BuildContext context, int index) {
    switch (index) {
      case 0:
        return LocaleUtil.getString(context, LocaleUtil.SHORTCUT_GUIDANCE_STEP1);
      case 1:
        return LocaleUtil.getString(context, LocaleUtil.SHORTCUT_GUIDANCE_STEP2);
      case 2:
        return LocaleUtil.getString(context, LocaleUtil.SHORTCUT_GUIDANCE_STEP3);
      default:
        return LocaleUtil.getString(context, LocaleUtil.SHORTCUT_GUIDANCE_STEP1);
    }
  }
}

class GuidancePager extends StatelessWidget {
  final bool isActive;
  GuidancePager(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 10 : 10,
      width: isActive ? 20 : 10,
      decoration: BoxDecoration(
        color: isActive ? colorDeepPurple() : colorGrey(),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}