/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/models/dialog/push_notification/push_notification_model.dart';
import 'package:smarthq_flutter_module/models/routing_model.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter.dart';
import 'package:smarthq_flutter_module/resources/repositories/dialog_repository.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class PushNotificationCubit
    extends Cubit<PushNotificationState> {
  static const String tag = "PushNotificationCubit";

  late DialogRepository _dialogRepository;

  PushNotificationCubit(
      this._dialogRepository)
      : super(PushNotificationInitial()) {
    _init();
  }

  void _init() {
    geaLog.debug("$tag:_init()");
  }

  void onInitializedScreen(String? deviceType, String? alertType) async {
    geaLog.debug("$tag:onInitializedScreen()");

    if (deviceType == null || alertType == null) {
      emit(PushNotificationFailure());
    }
    else {
      emit(PushNotificationLoading());

      final countryCode = await _getCountryCode();
      final languageCode = await _getLanguagePreference();
      final contentItem = await _dialogRepository.getAlertContent(
          countryCode, languageCode, deviceType, alertType);

      if (contentItem != null) {
        emit(PushNotificationSuccess(
            title: contentItem.title,
            contentItems: contentItem.contentItems
        ));
      }
      else {
        emit(PushNotificationFailure());
      }
    }
  }

  void onPressedDetailsButton({
    required RoutingType routingType,
    RoutingParameter? routingParameter}) {
    geaLog.debug("$tag:onPressedDetailsButton()");

    _dialogRepository.moveToFlutterViewScreen(
        routingType: routingType,
        routingParameter: routingParameter);
  }

  Future<String> _getLanguagePreference() async {
    geaLog.debug('$tag:getLanguagePreference()');
    final language = await _dialogRepository.getLanguagePreference();
    return language;
  }

  Future<String> _getCountryCode() async {
    geaLog.debug('$tag:getCountryCode()');
    final countryCode = await _dialogRepository.getCountryCode();
    return countryCode;
  }
}
