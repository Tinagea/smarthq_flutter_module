import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class PageEspressoSelectType extends StatefulWidget {
  PageEspressoSelectType({Key? key}) : super(key: key);

  _PageEspressoSelectType createState() => _PageEspressoSelectType();
}

class _PageEspressoSelectType extends State<PageEspressoSelectType>
    with WidgetsBindingObserver {
  var cont = 0;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent))
      return;

    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget as PageEspressoSelectType);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: true).pop();
              }).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: <Widget>[
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.MANUAL_ESPRESSO)!,
                    imagePath: ImagePath.ESPRESSO_MANUAL,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.ESPRESSO_MANUAL_NAVIGATOR,
                      );
                    }),
                Component.componentApplianceVerticalListTile(
                    context: context,
                    title: LocaleUtil.getString(context, LocaleUtil.AUTO_ESPRESSO)!,
                    imagePath: ImagePath.ESPRESSO_AUTO,
                    clickedFunction: () {
                      Navigator.pushNamed(
                        context, Routes.ESPRESSO_AUTO_NAVIGATOR,
                      );
                    }),
              ],
            ),
          )),
    );
  }

/* unused codes
  Widget _getFridgeTypeTextCard(String title, String replacementNamed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        color: Colors.grey[900],
        alignment: Alignment.center,
        width: double.infinity,
        height: 48.h,
        child: Card(
          color: Colors.grey[900],
          child: InkWell(
            child: Text(title, style: textStyle_size_18_bold_color_white()),
            onTap: () {
              geaLog.debug("Click $replacementNamed");
              Navigator.pushNamed(
                context,
                replacementNamed,
              );
            },
          ),
        ),
      ),
    );
  }
*/
  // Widget _getEspressoTypeCard(
  //     {String image = '',
  //     required String title,
  //     required String replacementNamed}) {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 182.h,
  //     child: Card(
  //       color: Colors.grey[900],
  //       child: InkWell(
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
  //           child: Row(
  //             children: [
  //               if (image != '') SvgPicture.asset(image),
  //               Expanded(
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   child: Text(title,
  //                       style: textStyle_size_18_bold_color_white()),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         onTap: () {
  //           geaLog.debug("Click $replacementNamed");
  //           Navigator.pushNamed(
  //             context,
  //             replacementNamed,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
