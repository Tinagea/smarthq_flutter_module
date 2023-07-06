import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class DryerFrontModel2Step1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DryerFrontModel2Step1();
}

class _DryerFrontModel2Step1 extends State<DryerFrontModel2Step1>
    with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          leftBtnFunction: () {
            Navigator.of(context).pop();
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
                      Component.componentMainImage(context,
                          ImagePath.DRYER_FRONT_2_COLOR),
                      BaseComponent.heightSpace(16.h),
                      Component.componentTitleText(
                          title: LocaleUtil.getString(
                              context, LocaleUtil.LETS_GET_STARTED)!
                              .toUpperCase(),
                          marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
                      BaseComponent.heightSpace(16.h),
                      Component.componentDescriptionText(
                        text: LocaleUtil.getString(context,
                            LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_1)!,
                        marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                      ),
                      BaseComponent.heightSpace(48.h),
                      CustomRichText.addWifiTextBox(
                          spanStringList: [
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_FRONT_2_P1_WIFI),
                                style: textStyle_size_18_color_white()),
                            WidgetSpan(
                              child: SvgPicture.asset(
                                ImagePath.SETTINGS,
                                width: 22.w,
                                height: 22.h,
                              ),
                            ),
                            TextSpan(text: LocaleUtil.getString(
                                context, LocaleUtil.LAUNDRY_FRONT_2_P2_WIFI),
                                style: textStyle_size_18_color_white()),
                          ],
                          marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
                      BaseComponent.heightSpace(16.h),
                      Component.componentDescriptionTextWithLinkLabel(
                        contents: LocaleUtil.getString(
                            context, LocaleUtil.WIFI_NOT_SELECTABLE)!,
                        contentsForLink: LocaleUtil.getString(
                            context, LocaleUtil.CONNECT_PLUS)!,
                        link: LocaleUtil.getString(
                            context, LocaleUtil.CONNECT_PLUS_HOW_TO_URL)!,
                        marginInsets: EdgeInsets.symmetric(horizontal: 29.w),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<CommissioningCubit, CommissioningState>(
                    bloc: BlocProvider.of<CommissioningCubit>(context),
                    buildWhen: (previous, current) {
                      return (current.stateType == CommissioningStateType.APT);
                    },
                    builder: (context, state) {
                      return Component.componentBottomButton(
                          title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                          isEnabled: state.isReceiveApplianceProvisioningToken == null
                              ? false : state.isReceiveApplianceProvisioningToken!,
                          onTapButton: () {
                            Navigator.of(context)
                                .pushNamed(Routes.DRYER_FRONT_MODEL2_STEP2);
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration.zero, () {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent))
      return;
    geaLog.debug('AppLifecycleState: $state}');
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    }
  }
}