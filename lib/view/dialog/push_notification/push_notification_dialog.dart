import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/dialog/push_notification/push_notification_cubit.dart';
import 'package:smarthq_flutter_module/models/dialog/push_notification/alert/details/push_notification_alert_details_model.dart';
import 'package:smarthq_flutter_module/models/dialog/push_notification/push_notification_model.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter_body.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/push_notification_dialog_components.dart';
import 'package:url_launcher/url_launcher.dart';

class PushNotificationAlertDetailsArgs {
  final String title;
  final List<ContentItem> contentItems;
  PushNotificationAlertDetailsArgs({
    required this.title,
    required this.contentItems,
  });
}

class PushNotificationDialog extends StatefulWidget {
  const PushNotificationDialog({Key? key, required this.parameter})
      : super(key: key);

  final DialogParameterBodyPushNotification parameter;

  _PushNotificationDialog createState() => _PushNotificationDialog();
}

class _PushNotificationDialog extends State<PushNotificationDialog> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<PushNotificationCubit>(context)
          .onInitializedScreen(
              widget.parameter.deviceType,
              widget.parameter.alertType);
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  bool hasAlertType() {
    return widget.parameter.alertType != null;
  }

  bool hasDeviceType() {
    return widget.parameter.deviceType != null;
  }

  // v1 dialog, only ok button to dismiss
  void onTapOk() {
    Navigator.of(context).pop();
  }

  // v1 dialog, go to link
  Future<bool> onTapGoToLink(String url) {
    final uri = Uri.parse(url);
    return launchUrl(uri);
  }

  // v2 dialog, dismiss dialog button
  void onTapDismiss() {
    Navigator.of(context).pop();
  }

  // v2 dialog, go to more details
  void onTapMoreDetails(PushNotificationState state) {
    if (state is PushNotificationSuccess) {
      Navigator.pushNamed(
          context, Routes.PUSH_NOTIFICATION_ALERT_DETAILS_PAGE,
          arguments: PushNotificationAlertDetailsArgs(
              title: state.title ?? '',
              contentItems: state.contentItems ?? []));
    }
    // It is used when the app shows the details page in Flutter Main Engine.
    // BlocProvider.of<PushNotificationCubit>(context)
    //     .onPressedDetailsButton(
    //     routingType: RoutingType.notificationAlertDetailsPage,
    //     routingParameter: RoutingParameter(
    //         kind: RoutingParameterKind.pushNotificationAlertDetails,
    //         body: RoutingParameterBodyPushNotificationAlertDetails(
    //             title: state.title,
    //             contentItems: state.contentItems
    //         )
    //     ));
  }

  bool isStringNotEmpty(String? str) {
    return str != null && str.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // width dialog
    var widthDialog = screenWidth * 0.75;
    // width dialog - adjust for squarish screens
    final screenRatio = screenWidth / screenHeight;
    final isSquarishScreen = screenRatio > 0.8;
    if (isSquarishScreen) widthDialog = screenWidth * 0.6;

    // body text vertical padding
    final bodyTextTopPadding = widthDialog * 0.125;
    final bodyTextBottomPadding = widthDialog * 0.05;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Container(
                width: widthDialog,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.parameter.title ?? "",
                        style: textStyle_size_18_color_black(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: bodyTextTopPadding,
                          bottom: bodyTextBottomPadding,
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.parameter.msg ?? "",
                            style: textStyle_size_14_color_black(),
                          ),
                        ),
                      ),
                      BlocBuilder<PushNotificationCubit, PushNotificationState>(
                        bloc: BlocProvider.of<PushNotificationCubit>(context),
                        builder: (BuildContext context, state) {
                          if (state is PushNotificationLoading || state is PushNotificationInitial) {
                            return Container(
                              height: 45.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3.w,
                                      valueColor: AlwaysStoppedAnimation<Color>(colorDeepPurple()),
                                    ),
                                    height: 12.h,
                                    width: 12.w,
                                  ),
                                  SizedBox(width: 20.w,)
                                ],
                              ),
                            );
                          } else {
                            return PushNotificationDialogComponents.createActionButtons(
                              context,
                              // conditions v1 - to enable "go to link"
                              url: widget.parameter.url,
                              // conditions v2 - to enable "go to alert details"
                              hasAlertType:
                              isStringNotEmpty(widget.parameter.alertType),
                              hasDeviceType:
                              isStringNotEmpty(widget.parameter.deviceType),
                              isAlertDetailsJsonAvailable: (state is PushNotificationSuccess),
                              onTapDismiss: onTapDismiss,
                              onTapGoToLink: onTapGoToLink,
                              onTapMoreDetails: () {
                                onTapMoreDetails(state);
                              },
                            );
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
