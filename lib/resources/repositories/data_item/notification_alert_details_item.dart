
import 'package:smarthq_flutter_module/models/dialog/push_notification/alert/details/push_notification_alert_details_model.dart';

class NotificationAlertDetailsItem {
  final String? title;
  final List<ContentItem>? contentItems;

  const NotificationAlertDetailsItem({
    this.title,
    this.contentItems
  });

  NotificationAlertDetailsItem copyWith({
    String? title,
    List<ContentItem>? contentItems,
  }) {
    return NotificationAlertDetailsItem(
        title: title ?? this.title,
        contentItems: contentItems ?? this.contentItems,
    );
  }
}

