/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/autojoin_bloc_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class ConnectPlusDishRemoveBottomPage extends StatefulWidget {
  @override
  _ConnectPlusDishRemoveBottomPageState createState() => _ConnectPlusDishRemoveBottomPageState();
}

class _ConnectPlusDishRemoveBottomPageState extends State<ConnectPlusDishRemoveBottomPage> {
  bool _isAutoJoinSupport = true;
  late Future<bool> _asyncFuncSupportAutojoin;
  late var _loadingDialog;

  @override
  void initState() {
    super.initState();
    _asyncFuncSupportAutojoin = CommissioningUtil.isSupportAutoJoin();
    _loadingDialog = LoadingDialog();
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ConnectPlus3rdPage.deactivate');

    _loadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase()).setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: FutureBuilder(
                future: _asyncFuncSupportAutojoin,
                initialData: _isAutoJoinSupport,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      _isAutoJoinSupport = snapshot.data as bool;
                    }
                  }
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            BaseComponent.heightSpace(66.h),
                            Padding(
                              padding: EdgeInsets.only(left: 28.0.w, right: 28.0.w, top: 0, bottom: 0),
                              child: Component.componentMainImage(context, ImagePath.CONNECT_PLUS_DISH_REMOVE_BOTTOM),
                            ),
                            BaseComponent.heightSpace(16.h),
                            BaseComponent.heightSpace(16.h),
                            BaseComponent.heightSpace(48.h),
                            CustomRichText.customSpanListTextBox(
                              textSpanList: <TextSpan>[
                                TextSpan(text: LocaleUtil.getString(context, LocaleUtil.CONNECT_PLUS_DISH_REMOVE_BOTTOM_TEXT), style: textStyle_size_18_color_white()),
                              ],
                            ),
                            BaseComponent.heightSpace(16),
                          ],
                        ),
                      ),
                      AutoJoinBlocListener.handleAutoJoinResponse(_loadingDialog),
                      Component.componentBottomButton(
                          title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                          isEnabled: true,
                          onTapButton: () {
                            if (_isAutoJoinSupport) {
                              _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.CONNECTING_TO_YOUR_APPLIANCE));
                              var commissioningCubit = BlocProvider.of<CommissioningCubit>(context);
                              commissioningCubit.startProcessing(
                                  'GE_MODULE_${commissioningCubit.actionGetKeptAcmSSID()}', commissioningCubit.actionGetKeptAcmPassword()!);
                            } else {
                              globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                              Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                            }
                          })
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
