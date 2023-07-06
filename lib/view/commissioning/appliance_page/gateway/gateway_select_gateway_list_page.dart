import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GatewaySelectGatewayListPage extends StatefulWidget {
  GatewaySelectGatewayListPage();

  @override
  _GatewaySelectGatewayListPage createState() => _GatewaySelectGatewayListPage();
}

class _GatewaySelectGatewayListPage extends State<GatewaySelectGatewayListPage> {
  _GatewaySelectGatewayListPage();

  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.SELECT_GATEWAY_1)!
                .toUpperCase(),
          ).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                BaseComponent.heightSpace(13.h),
                Component.componentInformationText(
                  text: LocaleUtil.getString(
                      context,
                      LocaleUtil.GATEWAY_LIST_SELECT_PAIR_DESCRIPTION_1)!,
                  marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                ),
                BaseComponent.heightSpace(35.h),
                BlocBuilder<BleCommissioningCubit, BleCommissioningState>(
                    bloc: BlocProvider.of<BleCommissioningCubit>(context),
                    builder: (context, state) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (state.gatewayInfoList?.length ?? 0) + 1,
                          itemBuilder: (context, index) {
                            if (index == (state.gatewayInfoList?.length ?? 0)) {
                              return new GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(Routes.GATEWAY_DESCRIPTION_PAGE);
                                },
                                child: Column(
                                  children: [
                                    CustomRichText.customSpanListTextBox(
                                      textSpanList: <TextSpan>[
                                        TextSpan(
                                            text: LocaleUtil.getString(context,
                                                LocaleUtil.ADD_NEW_GATEWAY_1),
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                letterSpacing: 0.36))
                                      ],
                                    ),
                                    BaseComponent.heightSpace(16.h)
                                  ],
                                ),
                              );
                            }
                            else {
                              return new GestureDetector(
                                onTap: () {
                                  BlocProvider.of<BleCommissioningCubit>(context).startPairingSensor(index: index);
                                },
                                child: Column(
                                  children: [
                                    CustomRichText.customSpanListTextBox(
                                      textSpanList: <TextSpan>[
                                        TextSpan(
                                            text: state.gatewayInfoList?[index].nickname,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                letterSpacing: 0.36))
                                      ],
                                    ),
                                    BaseComponent.heightSpace(16.h)
                                  ],
                                ),
                              );
                            }
                          });
                    }
                ),
              ],
            ),
          ),
        )
    );
  }

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

}
