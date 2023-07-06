
class NotificationVersionItem {
  final int? applianceTypeDec;
  final int? apiVersion;

  const NotificationVersionItem({
    this.applianceTypeDec,
    this.apiVersion
  });

  NotificationVersionItem copyWith({
    int? applianceTypeDec,
    int? apiVersion
  }) {
    return NotificationVersionItem(
        applianceTypeDec: applianceTypeDec ?? this.applianceTypeDec,
        apiVersion: apiVersion ?? this.apiVersion
    );
  }
}