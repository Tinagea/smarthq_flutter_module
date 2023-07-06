import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_history_item.dart';

import 'package:smarthq_flutter_module/resources/repositories/repositories.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/models/common/notification/notification_history_model.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/push_notification_dialog.dart';

class NotificationHistoryCubit extends Cubit<NotificationHistoryState> {
  late NativeRepository _nativeRepository;
  late ApiServiceRepository _apiServiceRepository;

  NotificationHistoryCubit(
    this._nativeRepository,
    this._apiServiceRepository,
  ) : super(
      NotificationHistoryState(
          seedValue: NotificationHistoryState.originalSeedValue,
          stateType: NotificationHistoryStateType.initial,
          alertDetailsArguments: {})) {
    geaLog.debug("NotificationHistoryCubit is called");
  }

  Future<void> onInitializedScreen() async {
    emit(state.copyWith(
        stateType: NotificationHistoryStateType.loading));

    List<NotificationHistoryItem>? items;
    final applianceId = await _nativeRepository.getSelectedApplianceId();
    if (applianceId != null) {
      final deviceId = await _apiServiceRepository.getDeviceIdByUpdId(applianceId);
      if (deviceId != null) {
        items = await _apiServiceRepository.getNotificationHistoryInfo(deviceId);
        geaLog.debug(items);
      }
    }

    emit(state.copyWith(
        stateType: NotificationHistoryStateType.success,
        notificationHistoryItems: items ?? []));
  }

  Future<void> beSeenNotificationHistoryItem(int index, String deviceType, String alertType) async {

    final oldItem = state.notificationHistoryItems?[index];

    final newItem = oldItem?.copyWith(
        detailsState: NotificationHistoryDetailsButtonStatus.loading);
    state.notificationHistoryItems?[index] = newItem!;
    emit(state.copyWith(
        stateType: NotificationHistoryStateType.update));

    final languageCode = await _nativeRepository.getLanguagePreference();
    final countryCode = await _nativeRepository.getCountryCode();

    final contentItem = await _apiServiceRepository.getAlertContent(
        countryCode, languageCode, deviceType, alertType);

    if (contentItem != null) {
      final argument = PushNotificationAlertDetailsArgs(
          title: contentItem.title!,
          contentItems: contentItem.contentItems!);

      final newItem = oldItem?.copyWith(
          detailsState: NotificationHistoryDetailsButtonStatus.shouldShow);
      state.notificationHistoryItems?[index] = newItem!;
      state.alertDetailsArguments?[index] = argument;

      emit(state.copyWith(
          stateType: NotificationHistoryStateType.update));
    }
    else {
      final newItem = oldItem?.copyWith(
          detailsState: NotificationHistoryDetailsButtonStatus.shouldNotShow);
      state.notificationHistoryItems?[index] = newItem!;

      emit(state.copyWith(
          stateType: NotificationHistoryStateType.update));
    }
  }
}
