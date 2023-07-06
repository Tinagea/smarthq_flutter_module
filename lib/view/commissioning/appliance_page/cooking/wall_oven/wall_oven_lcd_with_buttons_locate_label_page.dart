import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';

import 'package:smarthq_flutter_module/globals.dart' as globals;

class WallOvenPrimaryTypeTwoPage2 extends StatefulWidget {
  @override
  _WallOvenPrimaryTypeTwoPage2 createState() => _WallOvenPrimaryTypeTwoPage2();
}

class _WallOvenPrimaryTypeTwoPage2 extends State<WallOvenPrimaryTypeTwoPage2> {
  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
              leftBtnFunction: () {
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        BleBlockListener.handleBlePairing(context: context),
                        Component.componentMainImage(context, ImagePath.WALL_OVEN_TYPE_PRIMARY_2_PAGE_TWO_MAIN_IMAGE),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(16.h),
                        BaseComponent.heightSpace(48.h),
                        CustomRichText.addWifiTextBox(
                          spanStringList:[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context,
                                    LocaleUtil
                                        .WALL_OVEN_TYPE_3_PRIMARY_DESC_13),
                                style: textStyle_size_18_color_white()),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w)
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled: true,
                      onTapButton: () {
                        if (globals.routeNameToBack == Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_ONE) {
                          RepositoryProvider.of<WifiCommissioningStorage>(context).setUsiType = true;
                          globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                        }else{
                          Navigator.of(context)
                              .pushNamed(Routes.WALL_OVEN_PRIMARY_TYPE_2_PAGE_PASSWORD);
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
