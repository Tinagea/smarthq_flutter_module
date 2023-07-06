import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class FridgeInsideLeftGettingStartedHaierPage extends StatefulWidget {
  @override
  State createState() => _FridgeInsideLeftGettingStartedHaierPageState();
}

class _FridgeInsideLeftGettingStartedHaierPageState
    extends State<FridgeInsideLeftGettingStartedHaierPage>
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
            Navigator.of(context, rootNavigator: true).pop();
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
                      Component.componentMainImage(
                        context,
                        ImagePath.LEFT_ON_WALL_GETTING_STARTED,
                      ),
                      BaseComponent.heightSpace(16.h),
                      Component.componentTitleText(
                        title: LocaleUtil.getString(
                            context, LocaleUtil.LETS_GET_STARTED)!
                            .toUpperCase(),
                        marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                      ),
                      BaseComponent.heightSpace(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.w),
                        child: Text(
                          LocaleUtil.getString(
                            context,
                            LocaleUtil.CONNECTED_PLUS_DESCRIPTION_1_TEXT_1,
                          )!,
                          textAlign: TextAlign.left,
                          style: textStyle_size_15_color_old_silver(),
                        ),
                      ),
                      BaseComponent.heightSpace(58.h),
                      CustomRichText.addWifiTextBox(
                        spanStringList: [
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_1,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: SvgPicture.asset(ImagePath.LEFT_ON_WALL_LOCK_ICON, height: 20,),
                          ),
                          TextSpan(
                            style: textStyle_size_18_color_yellow(),
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_2,
                            ),
                          ),
                          TextSpan(
                            text: LocaleUtil.getString(
                              context,
                              LocaleUtil.LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_3,
                            ),
                          )
                        ],
                        marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                      BaseComponent.heightSpace(16.h),
                    ],
                  ),
                ),
                BlocBuilder<CommissioningCubit, CommissioningState>(
                  bloc: BlocProvider.of<CommissioningCubit>(context),
                  buildWhen: (previous, current) {
                    return (current.stateType == CommissioningStateType.APT ||
                        current.stateType == CommissioningStateType.INITIAL);
                  },
                  builder: (context, state) {
                    return Component.componentBottomButton(
                      isEnabled:
                          state.isReceiveApplianceProvisioningToken == null
                              ? false
                              : state.isReceiveApplianceProvisioningToken!,
                      title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                      onTapButton: () {
                        Navigator.of(context)
                            .pushNamed(Routes.LEFT_ON_WALL_DESCRIPTION3_MODEL1);
                      },
                    );
                  },
                )
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
