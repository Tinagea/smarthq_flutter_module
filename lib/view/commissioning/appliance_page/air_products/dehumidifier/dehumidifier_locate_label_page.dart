import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/models/commissioning_model.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DehumidifierStep2 extends StatefulWidget {

  @override
  State createState() => _DehumidifierStep2();

}


class _DehumidifierStep2 extends State<DehumidifierStep2> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!.toUpperCase(),
              leftBtnFunction: () {
                CommissioningUtil.navigateBackAndStopBlescan(context: context);
              }).setNavigationAppBar(context: context),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        BleBlockListener.handleBlePairing(context: context),
                        Component.componentMainImage(context,
                            ImagePath.DEHUMIDIFIER_INFO),
                        BaseComponent.heightSpace(25.h),
                        CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(
                                    context, LocaleUtil.DEHUMIDIFIER_LABEL_EXPLAIN),
                                style: textStyle_size_18_color_white()),
                          ],
                        ),
                        BaseComponent.heightSpace(16.h),
                      ],
                    ),
                  ),
                  BlocBuilder<CommissioningCubit, CommissioningState>(
                      bloc: BlocProvider.of<CommissioningCubit>(context),
                      builder: (context, state) {
                        return Component.componentBottomButton(
                            title:
                            LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                            isEnabled: true,
                            onTapButton: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.DEHUMIDIFIER_COMMISSIONING_ENTER_PASSWORD);
                            });
                      })
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

    }
  }
}
