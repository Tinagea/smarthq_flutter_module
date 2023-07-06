import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class WasherFrontLoadGettingStartedHaierPage extends StatefulWidget {
  @override
  State createState() => _WasherFrontLoadGettingStartedHaierPageState();
}

class _WasherFrontLoadGettingStartedHaierPageState
    extends State<WasherFrontLoadGettingStartedHaierPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          leftBtnFunction: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context, rootNavigator: true).pop();
            }
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
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Component.componentMainImage(context,
                            ImagePath.LAUNDRY_FRONT_1_HAIER),
                      ),
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
                      BaseComponent.heightSpace(22.h),
                      CustomRichText.richTextDescriptionWithCard(
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: LocaleUtil.getString(
                                      context,
                                      LocaleUtil
                                          .LAUNDRY_WASHER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_1),
                                  style: textStyle_size_18_color_white(),
                                ),
                                TextSpan(
                                  text: LocaleUtil.getString(
                                      context,
                                      LocaleUtil
                                          .LAUNDRY_WASHER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_2),
                                  style: textStyle_size_18_color_yellow(),
                                ),
                                TextSpan(
                                  text: LocaleUtil.getString(
                                      context,
                                      LocaleUtil
                                          .LAUNDRY_WASHER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_3),
                                  style: textStyle_size_18_color_white(),
                                ),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.wifi,
                                    size: 24,
                                    color: Color(0xFFf2a900),
                                  ),
                                ),
                                TextSpan(
                                  text: LocaleUtil.getString(
                                      context,
                                      LocaleUtil
                                          .LAUNDRY_WASHER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_4),
                                  style: textStyle_size_18_color_white(),
                                ),
                              ],
                            ),
                          ),
                          EdgeInsets.symmetric(horizontal: 16.w)),
                      BaseComponent.heightSpace(16.h),
                      BlocBuilder<CommissioningCubit, CommissioningState>(
                          bloc: BlocProvider.of<CommissioningCubit>(context),
                          buildWhen: (previous, current) {
                            return (current.stateType ==
                                    CommissioningStateType.APT ||
                                current.stateType ==
                                    CommissioningStateType.INITIAL);
                          },
                          builder: (context, state) {
                            return Component.componentBottomButton(
                                isEnabled:
                                    state.isReceiveApplianceProvisioningToken ==
                                            null
                                        ? false
                                        : state
                                            .isReceiveApplianceProvisioningToken!,
                                title: LocaleUtil.getString(
                                    context, LocaleUtil.NEXT)!,
                                onTapButton: () {
                                  _navigateToNextPage(context);
                                });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.WASHER_FRONT_LOAD_PASSWORD_HAIER);
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
