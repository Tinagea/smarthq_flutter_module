import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/ble_commissioning_cubit.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/bloc_listeners/ble_block_listener.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/pin_code_text_field.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class WallOvenEnterPasswordHaierPage extends StatefulWidget {
  WallOvenEnterPasswordHaierPage({Key? key}) : super(key: key);

  _WallOvenEnterPasswordHaierPageState createState() =>
      _WallOvenEnterPasswordHaierPageState();
}

class _WallOvenEnterPasswordHaierPageState
    extends State<WallOvenEnterPasswordHaierPage> {
  var onTapRecognizer;

  bool _buttonEnable = false;

  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    Future.delayed(Duration(milliseconds: 400), () async {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
            leftBtnFunction: () {
              CommissioningUtil.navigateBackAndStopBlescan(context: context);
            }).setNavigationAppBar(context: context),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Component.componentMainImage(context,
                          ImagePath.COOKING_WALL_OVEN_FNP_MODEL1_PASSWORD),
                      BaseComponent.heightSpace(36.h),
                      CustomRichText.customSpanListTextBox(
                          textSpanList: <TextSpan>[
                            TextSpan(
                                text: LocaleUtil.getString(context,
                                    LocaleUtil.ENTER_PASSWORD_WALL_OVEN_TFT),
                                style: textStyle_size_18_color_white()),
                          ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BleBlockListener.handleBlePairing(context: context),
                          BaseComponent.heightSpace(17.h),
                          Center(
                            child: Component.componentQuestionText(
                              context: context,
                              marginInsets:
                                  EdgeInsets.symmetric(horizontal: 33.w),
                              text: LocaleUtil.getString(
                                  context, LocaleUtil.CAN_NOT_FIND_PASSWORD)!,
                              onTap: () {
                                BlocProvider.of<BleCommissioningCubit>(context)
                                    .actionDirectBleDeviceState()
                                    .then(
                                  (bleState) {
                                    if (bleState == 'on') {
                                      // Stop BLE scan before going back
                                      BlocProvider.of<BleCommissioningCubit>(
                                              context)
                                          .stopAndCancelContinuousBleScan();
                                      Navigator.of(context).pop();
                                    } else {
                                      DialogManager()
                                          .showBleBluetoothEnableAlertDialog(
                                              context: context);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          BaseComponent.heightSpace(80.h),
                        ],
                      ),
                      BaseComponent.heightSpace(16.h),
                      Component.componentDescriptionText(
                        text: LocaleUtil.getString(
                            context, LocaleUtil.ENTER_PASSWORD)!,
                        marginInsets: EdgeInsets.symmetric(horizontal: 28.w),
                      ),
                      CommissioningPassword().getPinCodeTextField(
                          context: context,
                          focusNode: _focusNode,
                          textEditingController: _textEditingController,
                          onChanged: (value) {
                            setState(() {
                              _buttonEnable = (value.length == 8);
                            });
                          },
                          onCompleted: (value) {
                            BlocProvider.of<CommissioningCubit>(context)
                                .keepACMPassword(value);
                          }),
                    ],
                  ),
                ),
                Component.componentBottomButton(
                  isEnabled: _buttonEnable,
                  title: LocaleUtil.getString(context, LocaleUtil.CONNECT)!,
                  onTapButton: () {
                    BlocProvider.of<BleCommissioningCubit>(context)
                        .stopAndCancelContinuousBleScan();
                    BlocProvider.of<CommissioningCubit>(context)
                        .actionSaveAcmPassword();
                    globals.subRouteName =
                        Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Routes.COMMON_MAIN_NAVIGATOR)
                        .then((_) =>
                            BlocProvider.of<BleCommissioningCubit>(context)
                                .restartContinuousScanForAppliance());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
