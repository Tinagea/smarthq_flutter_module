import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class AcBuildInWifiGettingStartedHaierPage extends StatefulWidget {
  const AcBuildInWifiGettingStartedHaierPage({Key? key}) : super(key: key);

  @override
  State createState() => _AcBuildInWifiGettingStartedHaierPageState();
}

class _AcBuildInWifiGettingStartedHaierPageState extends State<AcBuildInWifiGettingStartedHaierPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)).setNavigationAppBar(context: context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Component.componentMainImage(context, ImagePath.HAIER_AC),
                  BaseComponent.heightSpace(16.h),
                  Component.componentTitleText(
                    title: LocaleUtil.getString(context, LocaleUtil.LETS_GET_STARTED)!.toUpperCase(),
                    marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                  ),
                  BaseComponent.heightSpace(16.h),
                  Component.componentDescriptionText(
                    text: LocaleUtil.getString(context, LocaleUtil.SETUP_WILL_TAKE_ABOUT_10_MIN_TEXT_HAIER_AC)!,
                    marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                  ),
                  BaseComponent.heightSpace(48.h),
                  CustomRichText.customSpanListTextBox(
                    textSpanList: <TextSpan>[
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_1),
                        style: textStyle_size_18_color_white(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_2),
                        style: textStyle_size_18_color_yellow(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_3),
                        style: textStyle_size_18_color_white(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_4),
                        style: textStyle_size_18_color_yellow(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_5),
                        style: textStyle_size_18_color_white(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_6),
                        style: textStyle_size_18_color_yellow(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_7),
                        style: textStyle_size_18_color_white(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_8),
                        style: textStyle_size_18_color_yellow(),
                      ),
                      TextSpan(
                        text: LocaleUtil.getString(context, LocaleUtil.AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_9),
                        style: textStyle_size_18_color_white(),
                      ),
                    ],
                  ),
                  BaseComponent.heightSpace(16),
                ],
              ),
            ),
            BlocBuilder<CommissioningCubit, CommissioningState>(
              bloc: BlocProvider.of<CommissioningCubit>(context),
              buildWhen: (previous, current) {
                return (current.stateType == CommissioningStateType.APT || current.stateType == CommissioningStateType.INITIAL);
              },
              builder: (context, state) {
                return Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                  isEnabled: state.isReceiveApplianceProvisioningToken == null ? false : state.isReceiveApplianceProvisioningToken!,
                  onTapButton: () {
                    Navigator.of(context).pushNamed(Routes.HAIER_AC_APPLIANCE_INFO_PAGE);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    var cubit = BlocProvider.of<CommissioningCubit>(context);
    cubit.initState();
    cubit.actionRequestApplicationProvisioningToken();
  }

  @override
  void dispose() {
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
}
