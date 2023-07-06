import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class DishDrawerOnFrontGettingStartedFnpPage extends StatefulWidget {
  @override
  State<DishDrawerOnFrontGettingStartedFnpPage> createState() => _DishDrawerOnFrontGettingStartedFnpPageState();
}

class _DishDrawerOnFrontGettingStartedFnpPageState extends State<DishDrawerOnFrontGettingStartedFnpPage> with WidgetsBindingObserver {
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

    if (!(ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent)) return;

    if (state == AppLifecycleState.resumed) {
      var cubit = BlocProvider.of<CommissioningCubit>(context);
      cubit.initState();
      cubit.actionRequestApplicationProvisioningToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Component.componentBaseContent(
      context: context,
      title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
      innerContent: _InnerContent(),
      footerContent: _FooterContent(),
    );
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleUtil.getString(context, LocaleUtil.THIS_IS_YOUR_CONTROL_PANEL)! + "\n", // To always show 2 lines
          style: textStyle_size_12_white_50_opacity(),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Component.componentMainImage(context, ImagePath.DISHDRAWER_COMMISSIONING_INFO_1_SVG),
        ),
        BaseComponent.heightSpace(16.h),
        Component.pageIndicator(3, 0),
        BaseComponent.heightSpace(16.h),
        Divider(
          height: 1,
          color: colorDeepDarkCharcoal(),
        ),
        BaseComponent.heightSpace(16.h),
        Component.componentTitleText(
          title: LocaleUtil.getString(context, LocaleUtil.LETS_GET_STARTED)!.toUpperCase(),
          marginInsets: EdgeInsets.symmetric(horizontal: 15.w),
        ),
        BaseComponent.heightSpace(16.h),
        CustomRichText.addWifiTextBox(
          spanStringList: [
            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_1_PART_1), style: textStyle_size_18_color_white()),
            TextSpan(text: LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_1_PART_2), style: textStyle_size_18_color_white()),
          ],
        ),
      ],
    );
  }
}

class _FooterContent extends StatelessWidget {
  const _FooterContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommissioningCubit, CommissioningState>(
      bloc: BlocProvider.of<CommissioningCubit>(context),
      buildWhen: (previous, current) {
        return (current.stateType == CommissioningStateType.APT);
      },
      builder: (context, state) {
        return Component.componentBottomButton(
          isEnabled: state.isReceiveApplianceProvisioningToken == true,
          title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
          onTapButton: () {
            Navigator.of(context).pushNamed(Routes.DISH_DRAWER_ON_FRONT_OF_DOOR_STEP2_PATH);
          },
        );
      },
    );
  }
}
