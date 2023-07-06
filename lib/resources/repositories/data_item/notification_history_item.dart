
enum NotificationHistoryDetailsButtonStatus {
  initial, loading, shouldShow, shouldNotShow
}

class NotificationHistoryItem {
  final String? pushText;
  final String? pushTitle;
  final String? commandDateTime;
  final String? deviceType;
  final String? alertType;
  final NotificationHistoryDetailsButtonStatus? detailsState;

  const NotificationHistoryItem({
    this.pushText,
    this.pushTitle,
    this.commandDateTime,
    this.deviceType,
    this.alertType,
    this.detailsState
  });

  NotificationHistoryItem copyWith({
    String? pushText,
    String? pushTitle,
    String? commandDateTime,
    String? deviceType,
    String? alertType,
    NotificationHistoryDetailsButtonStatus? detailsState
  }) {
    return NotificationHistoryItem(
      pushText: pushText ?? this.pushText,
      pushTitle: pushTitle ?? this.pushTitle,
      commandDateTime: commandDateTime ?? this.commandDateTime,
      deviceType: deviceType ?? this.deviceType,
      alertType: alertType ?? this.alertType,
      detailsState: detailsState ?? this.detailsState,
    );
  }
}