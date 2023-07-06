import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DishwasherCompactPage extends StatefulWidget {
  const DishwasherCompactPage({Key? key}) : super(key: key);
  @override
  _DishwasherCompactPageState createState() => _DishwasherCompactPageState();
}

class _DishwasherCompactPageState extends State<DishwasherCompactPage>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController(initialPage: 0);
  late LoadingDialog _loadingDialog;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero, () {
      final commissioningCubit = BlocProvider.of<CommissioningCubit>(context);
      commissioningCubit.initState();
      commissioningCubit.actionRequestApplicationProvisioningToken();

      final bleCommissioningCubit = BlocProvider.of<BleCommissioningCubit>(context);
      bleCommissioningCubit.stopAndCancelContinuousBleScan();
    });
    _loadingDialog = LoadingDialog();
  }

  @override
  void deactivate() {
    super.deactivate();
    _loadingDialog.close(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    }
  }

  List<TextSpan> _getDescriptionText() {
    return [
      TextSpan(
        text: LocaleUtil.getString(context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_1),
        style: textStyle_size_18_color_white()),
      TextSpan(
          text: LocaleUtil.getString(context, LocaleUtil.HI_TEMP_WASH),
          style: textStyle_size_18_color_yellow()),
      TextSpan(
          text: LocaleUtil.getString(
              context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_5),
          style: textStyle_size_18_color_white()),
      TextSpan(
          text: LocaleUtil.getString(
              context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_6),
          style: textStyle_size_18_color_white_50_opacity())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          leftBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          }).setNavigationAppBar(context: context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView(
              children: [
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current) {
                    final isModalRouteCurrent = ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent;
                    final isShowPairingLoading = current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING;
                    return isModalRouteCurrent && isShowPairingLoading;
                  },
                  listener: (context, state) {
                    _loadingDialog.show(
                        context,
                        LocaleUtil.getString(context,
                            LocaleUtil.TRYING_TO_CONNECT_THE_APPLIANCE));
                  },
                  child: Container(),
                ),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType ==
                        BleCommissioningStateType.HIDE_PAIRING_LOADING);
                  },
                  listener: (context, state) {
                    _loadingDialog.close(context);
                  },
                  child: Container(),
                ),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType ==
                            BleCommissioningStateType.FAIL_TO_CONNECT &&
                        (ModalRoute.of(context) != null &&
                            ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    DialogManager()
                        .showBleFailToConnectDialog(context: context);
                  },
                  child: Container(),
                ),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType ==
                            BleCommissioningStateType
                                .START_PAIRING_ACTION2_RESULT &&
                        (ModalRoute.of(context) != null &&
                            ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    geaLog.debug(
                        'state.isSuccess: ${state.isSuccess}, state.applianceType: ${state.applianceType}');

                    if (state.isSuccess == true) {
                      globals.subRouteName =
                          Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                    } else {
                      globals.routeNameToBack =
                          Routes.DISHWASHER_DESCRIPTION1_MODEL1;
                      Navigator.of(context)
                          .pushNamed(Routes.DISHWASHER_DESCRIPTION2_MODEL2);
                    }
                  },
                  child: Container(),
                ),
                Container(
                    height: 240.h,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: SvgPicture.asset(ImagePath.DISHWASHER_COMPCAT),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                        )
                      ],
                    )),
                BaseComponent.heightSpace(16.h),
                Component.componentTitleText(
                    title: LocaleUtil.getString(
                            context, LocaleUtil.LETS_GET_STARTED)!
                        .toUpperCase(),
                    marginInsets: EdgeInsets.symmetric(horizontal: 28.h)),
                BaseComponent.heightSpace(16.h),
                CustomRichText.customSpanListTextBox(
                  textSpanList: _getDescriptionText(),
                ),
                BaseComponent.heightSpace(16.h),
              ],
            )),
            BlocBuilder<CommissioningCubit, CommissioningState>(
                bloc: BlocProvider.of<CommissioningCubit>(context),
                buildWhen: (previous, current) {
                  return (current.stateType == CommissioningStateType.APT ||
                      current.stateType == CommissioningStateType.INITIAL);
                },
                builder: (context, state) {
                  return Component.componentBottomButton(
                      title:
                          LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled: state.isReceiveApplianceProvisioningToken ?? false,
                      onTapButton: () {
                        BlocProvider.of<BleCommissioningCubit>(context)
                            .actionBleStartPairingAction2(
                            ApplianceType.DISHWASHER, () {
                          globals.routeNameToBack =
                              Routes.DISHWASHER_DESCRIPTION1_MODEL1;
                          Navigator.of(context)
                              .pushNamed(Routes.DISHWASHER_DESCRIPTION2_MODEL2);
                        }, startContinuousScan: true);
                      });
                })
          ],
        ),
      ),
    );
  }
}
