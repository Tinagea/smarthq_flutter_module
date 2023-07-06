import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class AcWifiAdapterGettingStartedHaierPage extends StatefulWidget {
  const AcWifiAdapterGettingStartedHaierPage({Key? key}) : super(key: key);

  @override
  State createState() => _AcWifiAdapterGettingStartedHaierPageState();
}

class _AcWifiAdapterGettingStartedHaierPageState extends State<AcWifiAdapterGettingStartedHaierPage> with WidgetsBindingObserver {
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
                  SvgPicture.asset(
                    ImagePath.HAIER_NON_WIFI_AC,
                    fit: BoxFit.fill,
                  ),
                  Component.componentTitleText(
                    title: LocaleUtil.getString(
                      context,
                      LocaleUtil.LETS_GET_STARTED,
                    )!
                        .toUpperCase(),
                    marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                  ),
                  BaseComponent.heightSpace(16.h),
                  Component.componentDescriptionText(
                    text: LocaleUtil.getString(
                      context,
                      LocaleUtil.SETUP_WILL_TAKE_ABOUT_10_MIN_TEXT_HAIER_AC,
                    )!,
                    marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                  ),
                  BaseComponent.heightSpace(16.h),
                  CustomRichText.customSpanListTextBox(
                    textSpanList: <TextSpan>[
                      TextSpan(
                        text: LocaleUtil.getString(
                          context,
                          LocaleUtil.AC_WIFI_ADAPTER_GETTING_STARTED_DESCRIPTION_1,
                        ),
                        style: textStyle_size_18_color_white(),
                      ),
                    ],
                  ),
                  Component.componentCenterDescriptionText(
                    text: LocaleUtil.getString(
                      context,
                      LocaleUtil.AC_WIFI_ADAPTER_GETTING_STARTED_DESCRIPTION_2,
                    )!,
                    marginInsets: EdgeInsets.symmetric(horizontal: 24, vertical: 16.h),
                  ),
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
                    Navigator.of(context).pushNamed(Routes.HAIER_AC_APPLIANCE_USB_WIFI_DESCRIPTION_PAGE_TWO);
                  },
                );
              },
            )
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
