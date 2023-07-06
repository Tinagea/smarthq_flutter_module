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
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/dishwasher_getting_started_slider.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/connect_plus_navigator.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class DishwasherHome extends StatefulWidget {
  const DishwasherHome({Key? key}) : super(key: key);
  @override
  _DishwasherHomeState createState() => _DishwasherHomeState();
}

class _DishwasherHomeState extends State<DishwasherHome>
    with WidgetsBindingObserver {
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
      if (_currentPage < 6) {
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

  List<TextSpan> _getDescriptionText() {
    var textList = <TextSpan>[];
    textList.add(
      TextSpan(
          text: LocaleUtil.getString(
              context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_1),
          style: textStyle_size_18_color_white()),
    );
    if (_currentPage == 0) {
      textList.add(
        TextSpan(
            text: LocaleUtil.getString(context, LocaleUtil.CONNECT_PLUS_2),
            style: textStyle_size_18_color_yellow()),
      );
    } else if (_currentPage == 1) {
      textList.add(
        TextSpan(
            text: LocaleUtil.getString(context, LocaleUtil.HI_TEMP_WASH),
            style: textStyle_size_18_color_yellow()),
      );
    } else {
      textList.addAll([
        TextSpan(
            text: LocaleUtil.getString(
                context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_2),
            style: textStyle_size_18_color_yellow()),
        TextSpan(
            text: LocaleUtil.getString(
                context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_3),
            style: textStyle_size_18_color_white()),
        TextSpan(
            text: LocaleUtil.getString(
                context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_4),
            style: textStyle_size_18_color_yellow()),
      ]);
    }
    textList.addAll([
      TextSpan(
        text: LocaleUtil.getString(
            context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_5),
        style: textStyle_size_18_color_white()),
      TextSpan(
        text: LocaleUtil.getString(
            context, LocaleUtil.DISHWASHER_DESCRIPTION_TEXT_6),
        style: textStyle_size_18_color_white_50_opacity()),
    ]);

    return textList;
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
                    return (current.stateType ==
                            BleCommissioningStateType.SHOW_PAIRING_LOADING &&
                        (ModalRoute.of(context) != null &&
                            ModalRoute.of(context)!.isCurrent));
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
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: _pageController,
                              onPageChanged: _onPageChanged,
                              itemCount: 6,
                              itemBuilder: (context, index) =>
                                  DishwasherSlider(index)),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (int i = 0; i < 6; i++)
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
                  textSpanList: _getDescriptionText(),
                ),
                BaseComponent.heightSpace(16.h),
                Component.componentDescriptionTextWithLinkActionLabel(
                  contents: LocaleUtil.getString(
                      context, LocaleUtil.IT_DOESNT_WORK_YOU_MIGHT_NEED)!,
                  contentsForLink:
                      LocaleUtil.getString(context, LocaleUtil.CONNECT_PLUS)!,
                  onTapButton: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                        Routes.CONNECT_PLUS_MAIN_NAVIGATOR,
                        arguments: ScreenArgs(ApplianceType.DISHWASHER));
                  },
                  marginInsets: EdgeInsets.symmetric(horizontal: 29),
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
                      title:
                          LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                      isEnabled:
                          state.isReceiveApplianceProvisioningToken == null
                              ? false
                              : state.isReceiveApplianceProvisioningToken!,
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
