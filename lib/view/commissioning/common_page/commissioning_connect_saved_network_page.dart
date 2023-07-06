import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class CommissioningConnectSavedNetworkPage extends StatefulWidget {
  CommissioningConnectSavedNetworkPage({Key? key}) : super(key: key);

  _CommissioningConnectSavedNetworkPage createState() => _CommissioningConnectSavedNetworkPage();
}

class _CommissioningConnectSavedNetworkPage extends State<CommissioningConnectSavedNetworkPage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Timer? _screenMoveTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _screenMoveTimer = Timer(Duration(seconds: 15), (){
      geaLog.debug("Move to the connecting screen after 15 secs");
      Navigator.of(context).pushNamed(Routes.COMMON_COMMUNICATION_CLOUD_PAGE);

      _screenMoveTimer?.cancel();
      _screenMoveTimer = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat();

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
              .setNavigationAppBar(context: context, actionRequired: false, leadingRequired: false),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                LinearProgressIndicator(
                  backgroundColor: colorLightSilver().withOpacity(0.14),
                  minHeight: 3.h,
                  valueColor: new AlwaysStoppedAnimation<Color>(colorDeepPurple()),
                ),
                BaseComponent.heightSpace(50.h),
                Component.componentImageWithColor(
                    context: context,
                    imagePath: ImagePath.WIFI,
                    width: 120.w,
                    height: 120.h,
                    color: colorDeepPurple()
                ),
                BaseComponent.heightSpace(50.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 29.w),
                  child: Row(
                    children: [
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                        child:
                        Image.asset(ImagePath.OVAL, width: 30.w, height: 30.h),
                      ),
                      BaseComponent.widthSpace(12.w),
                      new Flexible(
                          child: Component.componentDescriptionTextSpan(
                              textSpan: [
                                TextSpan(text: LocaleUtil.getString(context, LocaleUtil.CONNECTING_THE_APPLIANCE_TO)),
                                TextSpan(text: BlocProvider.of<BleCommissioningCubit>(context).actionGetSelectedSavedNetworkSsid(),
                                    style: textStyle_size_18_color_yellow()),
                              ],
                              marginInsets: EdgeInsets.symmetric(horizontal: 16.w)
                          )
                      ),
                    ],
                  ),
                ),
                BaseComponent.heightSpace(30.h),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ListView(
                      children: [
                        Component.componentCenterAlignedContainer(
                          Component.componentDescriptionText(
                              text: LocaleUtil.getString(context, LocaleUtil.OR_YOU_CAN)!),),
                        BaseComponent.heightSpace(40.h),
                        Component.componentBasicOutlinedButton(LocaleUtil.getString(context, LocaleUtil.PICK_ANOTHER_WIFI)!, () {
                          geaLog.debug("Pick another wifi is Clicked");

                          BlocProvider.of<BleCommissioningCubit>(context).actionSetFromSavedConnectionFlag(true);
                          Navigator.of(context).pop();

                          _screenMoveTimer?.cancel();
                          _screenMoveTimer = null;
                        }),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
