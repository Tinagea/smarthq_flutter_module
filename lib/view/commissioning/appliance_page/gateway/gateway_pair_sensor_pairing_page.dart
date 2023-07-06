import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';

class GatewayPairSensorPairingPage extends StatefulWidget {
  GatewayPairSensorPairingPage({Key? key}) : super(key: key);

  _GatewayPairSensorPairingPage createState() => _GatewayPairSensorPairingPage();
}

class _GatewayPairSensorPairingPage extends State<GatewayPairSensorPairingPage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 300), () async {
      BlocProvider.of<BleCommissioningCubit>(context)
          .startToCheckParingSensorWithCloud();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat();

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.PAIR_SENSORS))
              .setNavigationAppBar(context: context, actionRequired: false, leadingRequired: false),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      BlocListener<BleCommissioningCubit, BleCommissioningState>(
                        listenWhen: (previous, current) {
                          return (current.stateType == BleCommissioningStateType.PAIRING_SENSOR_COMPLETE_RESULT
                              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                        },
                        listener: (context, state) {
                          if (state.isSuccessToCompleteParingSensor != null && state.isSuccessToCompleteParingSensor!)
                            Navigator.of(context).pushNamed(Routes.GATEWAY_PAIR_SENSOR_SUCCESS_PAGE);
                          else
                            Navigator.of(context).pushNamed(Routes.GATEWAY_PAIR_SENSOR_FAILURE_PAGE);
                        },
                        child: Container(),
                      ),
                      LinearProgressIndicator(
                        backgroundColor: colorLightSilver().withOpacity(0.14),
                        minHeight: 3.h,
                        valueColor: new AlwaysStoppedAnimation<Color>(colorDeepPurple()),
                      ),
                      BaseComponent.heightSpace(21.h),
                      Component.componentMainImage(
                          context, ImagePath.COMMUNICATION_CLOUD_3),
                      BaseComponent.heightSpace(61.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 29.w),
                        child: Row(
                          children: [
                            RotationTransition(
                              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                              child:
                              Image.asset(ImagePath.OVAL, width: 30.w, height: 30.h),
                            ),
                            BaseComponent.widthSpace(12.w),
                            new Flexible(child:
                            Component.componentInformationText(
                                text: LocaleUtil.getString(context, LocaleUtil.GATEWAY_PAIR_COMMUNICATING_CLOUD_1)!)
                            ),
                          ],
                        ),
                      ),
                      BaseComponent.heightSpace(23.h),
                      Component.componentDescriptionText(text: LocaleUtil.getString(context,
                          LocaleUtil.GATEWAY_PAIR_COMMUNICATING_DESCRIPTION_1)!, marginInsets: EdgeInsets.symmetric(horizontal: 29.w)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}