import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphone_page_1.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphone_page_2.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphone_page_3.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphone_page_4.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphone_page_5.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/show_me_how/iphone/show_me_how_iphone_page_6.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';

class ShowMeHowIphoneMain extends StatefulWidget {
  ShowMeHowIphoneMain({Key? key}) : super(key: key);

  _ShowMeHowIphoneMain createState() => _ShowMeHowIphoneMain();
}

class _ShowMeHowIphoneMain extends State<ShowMeHowIphoneMain> with WidgetsBindingObserver {
  final _showMeHowIphonePages = [
    new ShowMeHowIphonePage1(),
    new ShowMeHowIphonePage2(),
    new ShowMeHowIphonePage3(),
    new ShowMeHowIphonePage4(),
    new ShowMeHowIphonePage5(),
    new ShowMeHowIphonePage6()
  ];

  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController();
    List<Widget> pageList = <Widget>[
      new Center(child: _showMeHowIphonePages[0]),
      new Center(child: _showMeHowIphonePages[1]),
      new Center(child: _showMeHowIphonePages[2]),
      new Center(child: _showMeHowIphonePages[3]),
      new Center(child: _showMeHowIphonePages[4]),
      new Center(child: _showMeHowIphonePages[5])
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.SHOW_ME_HOW),
        rightBtnFunction: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ).setNavigationAppBar(context: context, leadingRequired: false),
      body: PageView(
        children: pageList,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (index){
          setState(() {
            _currentPageNotifier.value = index;
          });
        },
      ),
      bottomNavigationBar: Component.componentNavigationPageControl(_showMeHowIphonePages, _currentPageNotifier)
    );
  }
}