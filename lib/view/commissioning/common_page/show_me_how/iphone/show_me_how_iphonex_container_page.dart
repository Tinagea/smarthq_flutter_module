import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphonex_page_1.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphonex_page_2.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphonex_page_3.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphonex_page_4.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphonex_page_5.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphonex_page_6.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';

class ShowMeHowIphoneXMain extends StatefulWidget {
  ShowMeHowIphoneXMain({Key? key}) : super(key: key);

  _ShowMeHowIphoneXMain createState() => _ShowMeHowIphoneXMain();
}

class _ShowMeHowIphoneXMain extends State<ShowMeHowIphoneXMain>
    with WidgetsBindingObserver {
  final _showMeHowIphoneXPages = [
    new ShowMeHowIphoneXPage1(),
    new ShowMeHowIphoneXPage2(),
    new ShowMeHowIphoneXPage3(),
    new ShowMeHowIphoneXPage4(),
    new ShowMeHowIphoneXPage5(),
    new ShowMeHowIphoneXPage6()
  ];

  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    List<Widget> pageList = <Widget>[
      new Center(child: _showMeHowIphoneXPages[0]),
      new Center(child: _showMeHowIphoneXPages[1]),
      new Center(child: _showMeHowIphoneXPages[2]),
      new Center(child: _showMeHowIphoneXPages[3]),
      new Center(child: _showMeHowIphoneXPages[4]),
      new Center(child: _showMeHowIphoneXPages[5])
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
            _showMeHowIphoneXPages, _currentPageNotifier));
  }
}
