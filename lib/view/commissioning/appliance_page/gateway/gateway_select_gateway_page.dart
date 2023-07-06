import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GatewaySelectGatewayPage extends StatefulWidget {
  GatewaySelectGatewayPage();

  @override
  _GatewaySelectGatewayPage createState() => _GatewaySelectGatewayPage();
}

class _GatewaySelectGatewayPage extends State<GatewaySelectGatewayPage> {
  _GatewaySelectGatewayPage();

  late LoadingDialog _loadingDialog;

  @override
  void initState() {
    super.initState();
    _loadingDialog = LoadingDialog();
  }

  @override
  void deactivate() {
    super.deactivate();
    _loadingDialog.close(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.SELECT_GATEWAY_1))
              .setNavigationAppBar(context: context),
          body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Component.componentCommissioningBody(
                context,
                <Widget>[
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.TRYING_TO_START_PAIRING));
                    },
                    child: Container(),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.HIDE_PAIRING_LOADING);
                    },
                    listener: (context, state) {
                      _loadingDialog.close(context);
                    },
                    child: Container(),
                  ),
                  BlocListener<BleCommissioningCubit, BleCommissioningState>(
                    listenWhen: (previous, current) {
                      return (current.stateType == BleCommissioningStateType.START_PAIRING_SENSOR_RESULT
                          && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                    },
                    listener: (context, state) {
                      if (state.isSuccessToStartParingSensor != null) {
                        if (state.isSuccessToStartParingSensor!) {
                          Navigator.of(context).pushNamed(Routes.GATEWAY_PAIR_SENSOR_DESCRIPTION_PAGE);
                        }
                        else {
                          DialogManager().showFailToStartPairingDialog(context: context);
                        }
                      }
                    },
                    child: Container(),
                  ),
                  Component.componentMainImage(
                      context,
                      ImagePath.WIFI_ROUTER),
                  BaseComponent.heightSpace(16.h),
                  BlocBuilder<BleCommissioningCubit, BleCommissioningState>(
                    bloc: BlocProvider.of<BleCommissioningCubit>(context),
                    builder: (context, state) {
                      return Component.componentDescriptionTextSpanWithBox(
                        textSpan: [
                          TextSpan(text: LocaleUtil.getString(
                              context,
                              LocaleUtil.GATEWAY_SELECT_PAIR_DESCRIPTION_1)),
                          TextSpan(
                              text: ' ${state.gatewayInfoList?.first.nickname}',
                              style: textStyle_size_18_color_yellow()),
                          TextSpan(text: '?'),
                        ],
                        marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                      );
                    }
                  ),
                  BaseComponent.heightSpace(86.h),
                ],
                Container(
                    margin: EdgeInsets.symmetric(vertical: 32.h, horizontal: 60.w),
                    child: Component.componentTwoBottomButton(
                        LocaleUtil.getString(context,
                            LocaleUtil.PAIR_TO_GATEWAY_1)!.toUpperCase(),
                            () {
                              BlocProvider.of<BleCommissioningCubit>(context).startPairingSensor(index: 0);
                            },
                        LocaleUtil.getString(context,
                            LocaleUtil.ADD_A_NEW_GATEWAY_1)!.toUpperCase(),
                            () {
                              Navigator.of(context).pushNamed(Routes.GATEWAY_DESCRIPTION_PAGE);
                            })
                ),
              )
          ),
        )
    );
  }
}
