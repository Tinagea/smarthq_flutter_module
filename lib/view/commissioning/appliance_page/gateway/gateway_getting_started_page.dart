import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GatewayGettingStartedPage extends StatefulWidget {
  GatewayGettingStartedPage();

  @override
  State createState() {
    geaLog.debug('GatewayGettingStartedPage.createState');
    return _GatewayGettingStartedPage();
  }
}

class _GatewayGettingStartedPage extends State<GatewayGettingStartedPage>
    with WidgetsBindingObserver {

  _GatewayGettingStartedPage();

  @override
  Widget build(BuildContext context) {
    geaLog.debug('GatewayGettingStartedPage.build');
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
            leftBtnFunction: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ).setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Component.componentMainImage(
                            context, ImagePath.GATEWAY_IMAGE1),
                        BaseComponent.heightSpace(16.h),
                        Component.componentTitleText(
                            title: LocaleUtil.getString(
                                context, LocaleUtil.LETS_GET_STARTED)!.toUpperCase(),
                            marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                        BaseComponent.heightSpace(45.h),
                        Component.componentInformationText(
                          text: LocaleUtil.getString(
                              context, LocaleUtil.GATEWAY_DESCRIPTION_1)!,
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                        ),
                        // BaseComponent.heightSpace(16.h),
                        // Component.ComponentDescriptionTextWithLinkLabel(
                        //     contents: LocaleUtil.getString(context,
                        //         LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_3),
                        //     contentsForLink: LocaleUtil.getString(
                        //         context, LocaleUtil.CONNECT_PLUS),
                        //     link: LocaleUtil.getString(
                        //         context, LocaleUtil.CONNECT_PLUS_HOW_TO_URL),
                        //     marginInsets: EdgeInsets.symmetric(horizontal: 29.w)),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      onTapButton: () {
                        Navigator.of(context)
                            .pushNamed(Routes.GATEWAY_DESCRIPTION_PAGE);
                      })
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    geaLog.debug('GatewayGettingStartedPage.initState');
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void deactivate() {
    geaLog.debug('GatewayGettingStartedPage.deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    geaLog.debug('GatewayGettingStartedPage.dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    geaLog.debug('GatewayGettingStartedPage.didChangeAppLifecycleState');
    super.didChangeAppLifecycleState(state);

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent))
      return;

    geaLog.debug('AppLifecycleState: $state}');
  }
}
