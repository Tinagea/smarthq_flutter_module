import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';

class PagePortableACSelectType extends StatefulWidget {
  PagePortableACSelectType({Key? key}) : super(key: key);

  _PagePortableACSelectType createState() => _PagePortableACSelectType();
}

class _PagePortableACSelectType extends State<PagePortableACSelectType>
    with WidgetsBindingObserver {
  var cont = 0;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

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
    super.didUpdateWidget(oldWidget as PagePortableACSelectType);
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
            title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE),
            leftBtnFunction: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20.h,
              children: <Widget>[
                Component.componentApplianceSelectTypeTitle(
                    title: LocaleUtil.getString(context, LocaleUtil.PORTABLE_AC_SETUP_DESC_1)!),
                Component.componentMainSelectVerticalImageButton(
                    context: context,
                    imageName: ImagePath.PORTABLE_AC_TIMER,
                    text: LocaleUtil.getString(context, LocaleUtil.TIMER_HOLD_FOR_3_SEC)!,
                    pushName: Routes.PORTABLE_AC_TIMER_DESCRIPTION),
                Component.componentMainSelectVerticalImageButton(
                    context: context,
                    imageName: ImagePath.PORTABLE_AC_WIFI,
                    text: LocaleUtil.getString(context, LocaleUtil.WIFI_BUTTON)!,
                    pushName: Routes.PORTABLE_AC_WIFI_DESCRIPTION),
              ],
            ),
          )),
    );
  }

  // Widget _getPortableAcTypeCard(
  //     {String image = '',
  //       required String title,
  //       required String replacementNamed}) {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 182.h,
  //     child: Card(
  //       color: Colors.grey[900],
  //       child: InkWell(
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
  //           child: Column(
  //             children: [
  //               if (image != '') SvgPicture.asset(image),
  //               Expanded(
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   child: Text(title,
  //                       style: textStyle_size_14_bold_color_white()),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         onTap: () {
  //           Navigator.of(context).pushNamed(replacementNamed);
  //         },
  //       ),
  //     ),
  //   );
  // }
}
