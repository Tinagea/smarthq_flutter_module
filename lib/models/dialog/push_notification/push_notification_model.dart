
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/models/dialog/push_notification/alert/details/push_notification_alert_details_model.dart';

/// State: Alert Details
@immutable
abstract class PushNotificationState extends Equatable {}

class PushNotificationInitial
    extends PushNotificationState {
  @override
  List<Object?> get props => [];
}

class PushNotificationLoading
    extends PushNotificationState {
  @override
  List<Object?> get props => [];
}

class PushNotificationSuccess
    extends PushNotificationState {

  final String? title;
  final List<ContentItem>? contentItems;

  PushNotificationSuccess({
    required this.title,
    required this.contentItems,
  });

  @override
  List<Object?> get props => [
    title,
    contentItems,
  ];

  @override
  String toString() => "PushNotificationAlertDetailsSuccess {"
      "title: $title\n"
      "contentItems: $contentItems\n"
      "}";
}

class PushNotificationFailure
    extends PushNotificationState {
  @override
  List<Object?> get props => [];
}