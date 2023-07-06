import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class CommissioningSavedNetworkList extends StatefulWidget {
  @override
  _CommissioningSavedNetworkList createState() => _CommissioningSavedNetworkList();
}

class _CommissioningSavedNetworkList extends State<CommissioningSavedNetworkList> with WidgetsBindingObserver {

  late LoadingDialog _loadingDialog;

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;

    return FocusDetector(
    onFocusGained: () {
      _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.SEARCH_FOR_AVAILABLE_WIFI_NETWORK));
      BlocProvider.of<BleCommissioningCubit>(context).actionSendUpdatedWifiLockerToCloud();
    },
    child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.SAVED_NETWORKS)!.toUpperCase(),
              leftBtnFunction: () {
                BlocProvider.of<CommissioningCubit>(context).initState();
                BlocProvider.of<BleCommissioningCubit>(context).initState();

                Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);

                SystemNavigator.pop(animated: true);
                BlocProvider.of<CommissioningCubit>(context).actionMoveToNativeBackPage();
              },
              isRightButtonShown: false
          ).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BaseComponent.heightSpace(13.h),
                getSavedNetworkBody(context),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current){
                    return (current.stateType == BleCommissioningStateType.UPDATES_FINISHED
                        && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state){
                    Future.delayed(Duration.zero, () async {
                      BlocProvider.of<BleCommissioningCubit>(context).actionRequestSavedWifiNetworks();
                    });
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  Widget getSavedNetworkBody(BuildContext context) {
    return BlocConsumer<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current){
          return (current.stateType == BleCommissioningStateType.WIFI_LOCKER_NETWORKS
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state){
          _loadingDialog.close(context);
        },
        buildWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.WIFI_LOCKER_NETWORKS);
        },
        builder: (context, state) {
          return Stack(
            children: [
              Visibility(
                visible: (state.savedWifiNetworks?.networks == null) ? true :
                ((state.savedWifiNetworks?.networks?.length ?? 0) > 0) ? false : true,
                  child: Column(
                    children: [
                      Component.componentMainImage(
                          context,
                          ImagePath.WIFI_ROUTER),
                      BaseComponent.heightSpace(10.h),
                      Center(
                        child: Text(
                          LocaleUtil.getString(context, LocaleUtil.NO_NETWORK_SAVED)!,
                          style: textStyle_size_24_color_white(),
                        ),
                      ),
                      BaseComponent.heightSpace(16.h),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: Text(
                        LocaleUtil.getString(context, LocaleUtil.SAVE_A_NETWORK_WHEN_YOU_CONNECT)!,
                        style: textStyle_size_18_color_white(),
                      ))
                    ],
                  )),
              Visibility(
                visible: (state.savedWifiNetworks?.networks == null) ? false :
                ((state.savedWifiNetworks?.networks?.length ?? 0) > 0) ? true : false,
                child: Column(
                  children: [
                    BaseComponent.heightSpace(5.h),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (state.savedWifiNetworks?.networks == null) ? 0 :
                        (state.savedWifiNetworks?.networks?.length ?? 0),
                        itemBuilder: (context, index) {
                          return new GestureDetector(
                            onTap: () {
                              //TODO: if you want to add the action for the list item
                            },
                            child: Column(
                              children: [
                                CustomRichText.customSpanListTextBoxWithDetail(context: context,
                                    title: state.savedWifiNetworks?.networks?[index].ssid,
                                    detail: LocaleUtil.getString(context, LocaleUtil.EDIT),
                                    onTapPencil: (){
                                      BlocProvider.of<BleCommissioningCubit>(context).actionStoreNetworkForEditing(state.savedWifiNetworks?.networks?[index]);
                                      Navigator.of(context).pushNamed(Routes.COMMON_EDIT_SAVED_NETWORK_PAGE);
                                    }),
                                BaseComponent.heightSpace(16.h)
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _loadingDialog = LoadingDialog();

    Future.delayed(Duration.zero, () async {
      _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.SEARCH_FOR_AVAILABLE_WIFI_NETWORK));
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _loadingDialog.close(context);
    super.dispose();
  }
}
