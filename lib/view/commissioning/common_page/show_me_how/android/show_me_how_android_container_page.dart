import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/android/show_me_how_android_page_1.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/android/show_me_how_android_page_2.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/android/show_me_how_android_page_3.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/android/show_me_how_android_page_4.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/android/show_me_how_android_page_5.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/android/show_me_how_android_page_6.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';

class ShowMeHowAndroidMain extends StatefulWidget {
  ShowMeHowAndroidMain({Key? key}) : super(key: key);

  _ShowMeHowAndroidMain createState() => _ShowMeHowAndroidMain();
}

class _ShowMeHowAndroidMain extends State<ShowMeHowAndroidMain>
    with WidgetsBindingObserver {
  final _showMeHowAndroidPages = [
    new ShowMeHowAndroidPage1(),
    new ShowMeHowAndroidPage2(),
    new ShowMeHowAndroidPage3(),
    new ShowMeHowAndroidPage4(),
    new ShowMeHowAndroidPage5(),
    new ShowMeHowAndroidPage6()
  ];

  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    List<Widget> pageList = <Widget>[
      new Center(child: _showMeHowAndroidPages[0]),
      new Center(child: _showMeHowAndroidPages[1]),
      new Center(child: _showMeHowAndroidPages[2]),
      new Center(child: _showMeHowAndroidPages[3]),
      new Center(child: _showMeHowAndroidPages[4]),
      new Center(child: _showMeHowAndroidPages[5])
    ];

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SHOW_ME_HOW),
          rightBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ).setNavigationAppBar(context: context, leadingRequired: false),
        body: PageView(
          children: pageList,
          scrollDirection: Axis.horizontal,
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPageNotifier.value = index;
            });
          },
        ),
        bottomNavigationBar: Component.componentNavigationPageControl(
            _showMeHowAndroidPages, _currentPageNotifier));
  }
}
