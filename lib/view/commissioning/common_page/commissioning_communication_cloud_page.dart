import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/resources/storage/storages.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class CommissioningCommunicationCloudPage extends StatefulWidget {
  CommissioningCommunicationCloudPage({Key? key}) : super(key: key);

  _CommissioningCommunicationCloudPage createState() => _CommissioningCommunicationCloudPage();
}

class _CommissioningCommunicationCloudPage extends State<CommissioningCommunicationCloudPage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late String _communicatingCloudString;
  late String _communicatingCloudImage;
  late String _communicatingCloudDescriptionString;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    Future.delayed(Duration.zero, () {
      final storage = RepositoryProvider.of<BleCommissioningStorage>(context);
      if (storage.savedStartByBleCommissioning == true) {
        BlocProvider.of<BleCommissioningCubit>(context).actionBleStartCommissioning();
      }
      else {
        BlocProvider.of<CommissioningCubit>(context).actionStartCommissioning();
      }
    });

    _communicatingCloudString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_1;
    _communicatingCloudImage = ImagePath.COMMUNICATION_CLOUD;
    _communicatingCloudDescriptionString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_DESCRIPTION_1;

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
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE))
              .setNavigationAppBar(context: context, actionRequired: false, leadingRequired: false),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      LinearProgressIndicator(
                        backgroundColor: colorLightSilver().withOpacity(0.14),
                        minHeight: 3.h,
                        valueColor: new AlwaysStoppedAnimation<Color>(colorDeepPurple()),
                      ),
                      BaseComponent.heightSpace(21.h),
                      Component.componentMainImage(
                          context, _communicatingCloudImage),
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
                            Component.componentInformationText(text: LocaleUtil.getString(context, _communicatingCloudString) ?? LocaleUtil.PAGE_COMMUNICATING_CLOUD_1)
                            ),
                          ],
                        ),
                      ),
                      BaseComponent.heightSpace(23.h),
                      Component.componentDescriptionText(text: LocaleUtil.getString(context, _communicatingCloudDescriptionString) ?? LocaleUtil.PAGE_COMMUNICATING_CLOUD_DESCRIPTION_1, marginInsets: EdgeInsets.symmetric(horizontal: 29.w)),
                    ],
                  ),
                ),
                BlocListener<CommissioningCubit, CommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType == CommissioningStateType.PROGRESS
                        && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    if (state.progressStep != null) {
                      geaLog.debug("cloud CommissioningCubit my step: ${state.progressStep!['step']}, ${(state.progressStep!['isSuccess'] == true) ? "success" : "failed" }");
                      if (state.progressStep!['step'] == 1 && state.progressStep!['isSuccess'] == true) {
                        setState(() {
                          _communicatingCloudString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_2;
                          _communicatingCloudImage = ImagePath.COMMUNICATION_CLOUD_2;
                          _communicatingCloudDescriptionString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_DESCRIPTION_2;

                          BlocProvider.of<BleCommissioningCubit>(context).actionSendUpdatedWifiLockerToCloud();
                        });
                      }
                      else if (state.progressStep!['step'] == 2 && state.progressStep!['isSuccess'] == true) {
                        setState(() {
                          _communicatingCloudString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_3;
                          _communicatingCloudImage = ImagePath.COMMUNICATION_CLOUD_3;
                          _communicatingCloudDescriptionString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_DESCRIPTION_3;
                        });
                      }
                      else if (state.progressStep!['step'] == 3 && state.progressStep!['isSuccess'] == true) {
                        DialogManager().close(context, FlutterDialogType.checkModuleStatus);
                        Navigator.of(context).pushNamed(Routes.COMMON_MAIN_SUCCESS_PAGE);
                      }
                      else {
                        DialogManager().close(context, FlutterDialogType.checkModuleStatus);
                        Navigator.of(context).pushNamed(Routes.COMMON_MAIN_WRONG_PAGE);
                      }
                    }
                  },
                  child: Container(),
                ),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType == BleCommissioningStateType.PROGRESS
                        && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    if (state.progressStep != null) {
                      geaLog.debug("cloud BleCommissioningCubit my step: ${state.progressStep!['step']}, ${(state.progressStep!['isSuccess'] == true) ? "success" : "failed" }");
                      if (state.progressStep!['step'] == 1 && state.progressStep!['isSuccess'] == true) {
                        setState(() {
                          _communicatingCloudString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_2;
                          _communicatingCloudImage = ImagePath.COMMUNICATION_CLOUD_2;
                          _communicatingCloudDescriptionString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_DESCRIPTION_2;

                        });
                      }
                      else if (state.progressStep!['step'] == 2 && state.progressStep!['isSuccess'] == true) {
                        setState(() {
                          _communicatingCloudString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_3;
                          _communicatingCloudImage = ImagePath.COMMUNICATION_CLOUD_3;
                          _communicatingCloudDescriptionString = LocaleUtil.PAGE_COMMUNICATING_CLOUD_DESCRIPTION_3;

                          BlocProvider.of<BleCommissioningCubit>(context).actionSendUpdatedWifiLockerToCloud();
                        });
                      }
                      else if (state.progressStep!['step'] == 3 && state.progressStep!['isSuccess'] == true) {
                        Navigator.of(context).pushNamed(Routes.COMMON_MAIN_SUCCESS_PAGE);
                      }
                      else {
                        Navigator.of(context).pushNamed(Routes.COMMON_MAIN_WRONG_PAGE);
                      }
                    }
                  },
                  child: Container(),
                ),
                BlocListener<BleCommissioningCubit, BleCommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType == BleCommissioningStateType.NETWORK_JOIN_STATUS_FAIL
                        && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    Navigator.of(context).pushNamed(Routes.COMMON_WRONG_NETWORK_PASSWORD_PAGE);
                  },
                  child: Container(),
                ),
                BlocListener<CommissioningCubit, CommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType == CommissioningStateType.NETWORK_JOIN_STATUS_FAIL
                        && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    Navigator.of(context).pushNamed(Routes.COMMON_WRONG_NETWORK_PASSWORD_PAGE);
                  },
                  child: Container(),
                ),
                BlocListener<CommissioningCubit, CommissioningState>(
                  listenWhen: (previous, current) {
                    return (current.stateType == CommissioningStateType.CHECK_MODULE_STATUS_FROM_USER
                        && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
                  },
                  listener: (context, state) {
                    DialogManager().showCheckModuleStatusDialog(
                        context: context,
                        onNoPressed: () {
                          BlocProvider.of<CommissioningCubit>(context).actionCancelCommissioning();
                          Navigator.of(context).pushNamed(Routes.COMMON_WRONG_NETWORK_PASSWORD_PAGE);
                        });
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        )
    );
  }
}
