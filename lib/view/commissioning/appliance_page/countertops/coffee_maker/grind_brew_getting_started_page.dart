import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/ble_commissioning_model.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/coffee_maker/grind_brew_slider.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class GrindBrewCommissioningHome extends StatefulWidget {
  const GrindBrewCommissioningHome({Key? key}) : super(key: key);
  @override
  _GrindBrewCommissioningHomeState createState() => _GrindBrewCommissioningHomeState();
}

class _GrindBrewCommissioningHomeState extends State<GrindBrewCommissioningHome> with WidgetsBindingObserver{
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late LoadingDialog _loadingDialog;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero, () {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
      BlocProvider.of<BleCommissioningCubit>(context).stopAndCancelContinuousBleScan();
    });
    _loadingDialog = LoadingDialog();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }

    });
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

    print('AppLifecycleState: $state}');
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    }
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
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
                    return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.TRYING_TO_CONNECT_THE_APPLIANCE));
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
                    return (current.stateType == BleCommissioningStateType.FAIL_TO_CONNECT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    DialogManager().showBleFailToConnectDialog(context: context);
                  },
                  child: Container(),
                ),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType == BleCommissioningStateType.START_PAIRING_ACTION2_RESULT && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    geaLog.debug('state.isSuccess: ${state.isSuccess}, state.applianceType: ${state.applianceType}');

                    if (state.isSuccess == true) {
                      globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
                      Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                    } else {
                      DialogManager().showPairingFailedDialog(context);
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
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            itemCount: 2,
                            itemBuilder: (context, index) =>
                                GrindBrewSlider(index)),
                          ),
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (int i = 0; i < 2; i++)
                                    if (i == _currentPage)
                                      SliderDots(true)
                                    else
                                      SliderDots(false)
                                ],
                              ),
                            )
                          ],
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
                  textSpanList: <TextSpan>[
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_ON_THE),
                        style: textStyle_size_18_color_white()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_SETTINGS_BUTTON),
                        style: textStyle_size_18_color_yellow()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_USE_THE),
                        style: textStyle_size_18_color_white()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_ARROW_BUTTON),
                        style: textStyle_size_18_color_yellow()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_TO_NAVIGATE),
                        style: textStyle_size_18_color_white()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.SELECT),
                        style: textStyle_size_18_color_yellow()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_CHANGE_TO),
                        style: textStyle_size_18_color_white()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.SELECT),
                        style: textStyle_size_18_color_yellow()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_THE_SCREEN),
                        style: textStyle_size_18_color_white()),
                    TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.GRIND_BREW_BUTTON_NAMES),
                        style: textStyle_size_18_color_white_50_opacity())
                  ],
                ),
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
                      title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                      isEnabled: state.isReceiveApplianceProvisioningToken == null
                          ? false : state.isReceiveApplianceProvisioningToken!,
                      onTapButton: () {
                        BlocProvider.of<BleCommissioningCubit>(context)
                            .actionBleStartPairingAction2(ApplianceType.COFFEE_BREWER,
                                () {
                                  DialogManager().showPairingFailedDialog(context);
                            });
                      }
                      );
                })
          ],
        ),
      ),
    );
  }
}

class SliderDots extends StatelessWidget {
  final bool isActive;
  SliderDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
