
class NotificationSettingItem {
  final String? ruleId;
  final String? title;
  final String? description;
  final bool? ruleEnabled;

  const NotificationSettingItem({
    this.ruleId,
    this.title,
    this.description,
    this.ruleEnabled
  });

  NotificationSettingItem copyWith({
    String? ruleId,
    String? title,
    String? description,
    bool? ruleEnabled,
  }) {
    return NotificationSettingItem(
        ruleId: ruleId ?? this.ruleId,
        title: title ?? this.title,
        description: description ?? this.description,
        ruleEnabled: ruleEnabled ?? this.ruleEnabled
    );
  }
}