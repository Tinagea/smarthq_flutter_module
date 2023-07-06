import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_setting_item.dart';

enum LoadingStatus {
  loading,
  updated
}

class NotificationSettingState extends Equatable {
  const NotificationSettingState({
    this.seedValue,
    this.notificationSettingList,
    this.loadingStatus
  });

  final int? seedValue;
  final List<NotificationSettingItem>? notificationSettingList;
  final LoadingStatus? loadingStatus;

  @override
  List<Object?> get props => [
    seedValue,
    notificationSettingList
  ];

  @override
  String toString() => "NotificationSettingState {"
      "seedValue: $seedValue\n"
      "notificationSettingList: $notificationSettingList\n"
      "loadingStatus: $loadingStatus\n"
      "}";

  NotificationSettingState copyWith({
    int? seedValue,
    List<NotificationSettingItem>? notificationSettingList,
    LoadingStatus? loadingStatus
  }) {
    return NotificationSettingState(
        seedValue: seedValue ?? this.seedValue,
        notificationSettingList: notificationSettingList ?? this.notificationSettingList,
        loadingStatus: loadingStatus ?? this.loadingStatus
    );
  }
}