import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/loading_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WallOvenPrimaryTypeThreePage1 extends StatefulWidget {
  @override
  _WallOvenPrimaryTypeThreePage1 createState() => _WallOvenPrimaryTypeThreePage1();
}

class _WallOvenPrimaryTypeThreePage1 extends State<WallOvenPrimaryTypeThreePage1>
    with WidgetsBindingObserver {
  late LoadingDialog _loadingDialog;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero,(){
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
          ).setNavigationAppBar(context: context),
      body: Component.componentCommissioningBody(
        context,
        <Widget>[
          Component.componentMainImage(
              context, ImagePath.WALL_OVEN_TYPE_PRIMARY_3_PAGE_1),
          BaseComponent.heightSpace(16.h),
          Component.componentTitleText(
              title: LocaleUtil.getString(context, LocaleUtil.LETS_GET_STARTED)!
                  .toUpperCase(),
              marginInsets: EdgeInsets.symmetric(horizontal: 28)),
          BaseComponent.heightSpace(16),
          Component.componentDescriptionText(
              text: LocaleUtil.getString(context, LocaleUtil.OPAL_SETUP_DESC_1)!,
              marginInsets: EdgeInsets.symmetric(horizontal: 28.w)),
          BaseComponent.heightSpace(16.h),
          CustomRichText.addWifiTextBox(
            spanStringList: [
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_1),
                  style: textStyle_size_18_color_white())
              ,TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_2),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_3),
                  style: textStyle_size_18_color_yellow()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_4),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_5),
                  style: textStyle_size_18_color_white()),
              TextSpan(
                  text: LocaleUtil.getString(
                      context, LocaleUtil.WALL_OVEN_TYPE_3_PRIMARY_DESC_6),
                  style: textStyle_size_18_color_yellow()),

            ],
            marginInsets: EdgeInsets.symmetric(horizontal: 16.w),

          ),
          BaseComponent.heightSpace(16.h)
        ],
        BlocBuilder<CommissioningCubit, CommissioningState>(
            bloc: BlocProvider.of<CommissioningCubit>(context),
            buildWhen: (previous, current) {
              return (current.stateType == CommissioningStateType.APT ||
                  current.stateType == CommissioningStateType.INITIAL);
            },
            builder: (context, state) {
              return Component.componentBottomButton(
                  title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                  isEnabled: state.isReceiveApplianceProvisioningToken == null
                      ? false
                      : state.isReceiveApplianceProvisioningToken!,
                  onTapButton: () {
                    Navigator.of(context).pushNamed(Routes.WALL_OVEN_PRIMARY_TYPE_3_PAGE_2);
                  });
            }),
      ),
    );
  }
}
