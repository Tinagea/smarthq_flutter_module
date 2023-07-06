import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_history_item.dart';

import 'package:smarthq_flutter_module/view/dialog/push_notification/push_notification_dialog.dart';

enum NotificationHistoryStateType {
  initial,
  loading,
  success,
  failure,
  update
}

class NotificationHistoryState extends Equatable {
  const NotificationHistoryState({
    this.seedValue,
    this.stateType,
    this.notificationHistoryItems,
    this.alertDetailsArguments,
  });

  static int originalSeedValue = 0;
  final int? seedValue;
  final NotificationHistoryStateType? stateType;
  final List<NotificationHistoryItem>? notificationHistoryItems;
  final Map<int,PushNotificationAlertDetailsArgs>? alertDetailsArguments;

  @override
  List<Object?> get props => [
    seedValue,
    stateType,
    notificationHistoryItems,
    alertDetailsArguments,
  ];

  @override
  String toString() => "NotificationHistoryState {"
      "seedValue: $seedValue\n"
      "stateType: $stateType\n"
      "notificationHistoryItems: $notificationHistoryItems\n"
      "alertDetailsArguments: $alertDetailsArguments\n"
      "}";

  NotificationHistoryState copyWith({
    NotificationHistoryStateType? stateType,
    List<NotificationHistoryItem>? notificationHistoryItems,
    Map<int,PushNotificationAlertDetailsArgs>? alertDetailsArguments,
  }) {
    originalSeedValue++;
    return NotificationHistoryState(
      seedValue: originalSeedValue,
      stateType: stateType ?? this.stateType,
      notificationHistoryItems: notificationHistoryItems ?? this.notificationHistoryItems,
      alertDetailsArguments: alertDetailsArguments ?? this.alertDetailsArguments,
    );
  }
}