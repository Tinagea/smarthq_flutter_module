import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter_body.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_history_item.dart';
import 'package:smarthq_flutter_module/utils/common_util.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/cubits/notification_history_cubit.dart';
import 'package:smarthq_flutter_module/models/common/notification/notification_history_model.dart';
import 'package:smarthq_flutter_module/view/control/common/notification/history/notification_history_components.dart';

class NotificationHistoryPage extends StatefulWidget {
  NotificationHistoryPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final RoutingParameterBodyNotificationHistory? arguments;

  @override
  _NotificationHistoryPage createState() => _NotificationHistoryPage();
}

class _NotificationHistoryPage extends State<NotificationHistoryPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<NotificationHistoryCubit>(context)
          .onInitializedScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<NotificationHistoryCubit, NotificationHistoryState>(
                    bloc: BlocProvider.of<NotificationHistoryCubit>(context),
                    builder: (context, state) {
                      if (state.stateType == NotificationHistoryStateType.loading ||
                          state.stateType == NotificationHistoryStateType.initial) {
                        // initial or loading
                        return NotificationHistoryComponents
                            .createLoadingIndicator();
                      } else if (state.stateType == NotificationHistoryStateType.success ||
                          state.stateType == NotificationHistoryStateType.update) {
                        // success
                        return CommonUtil.isEmptyList(state.notificationHistoryItems)
                            ? Center(
                                child: Text(LocaleUtil.getString(context, LocaleUtil.NO_HISTORY)!,
                                style: textStyle_size_17_color_white(),))
                            : ListView.separated(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                          itemCount: state.notificationHistoryItems?.length ?? 0,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(height: 24.0);
                          },
                          itemBuilder: (context, index) {
                            final item = state.notificationHistoryItems![index];
                            if (item.detailsState == NotificationHistoryDetailsButtonStatus.initial) {
                              Future.delayed(Duration.zero, (){
                                BlocProvider.of<NotificationHistoryCubit>(context)
                                    .beSeenNotificationHistoryItem(index, item.deviceType!, item.alertType!);
                              });
                            }
                            return NotificationHistoryComponents.createCard(
                              item: item,
                              onTapMoreDetails: () {
                                geaLog.debug("NotificationHistoryPage - onTapMoreDetails()");
                                Navigator.pushNamed(context,
                                    Routes.PUSH_NOTIFICATION_ALERT_DETAILS_PAGE,
                                    arguments: state.alertDetailsArguments?[index]);
                              },
                            );
                          },
                        );
                      } else {
                        // default
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
