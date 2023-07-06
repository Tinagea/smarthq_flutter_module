// file: shortcut_review_cubit.dart
// date: Feb/22/2023
// brief: Shortcut review related cubit
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/resources/repositories/shortcut_service_repository.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_review_model.dart';
import 'package:smarthq_flutter_module/resources/storage/shortcut_storage.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

class ShortcutReviewCubit extends Cubit<ShortcutReviewState> {
  static const String tag = "ShortcutReviewCubit:";

  late ShortcutServiceRepository _shortcutServiceRepository;
  late ShortcutService _shortcutService;
  late LocalDataManager _localDataManager;
  late ShortcutStorage _storage;

  ShortcutReviewCubit(
      this._shortcutServiceRepository,
      this._shortcutService,
      this._localDataManager)
      : super(ShortcutReviewInitiate()) {
    geaLog.debug("ShortcutReviewCubit is called");

    _storage = _localDataManager.getStorage(StorageType.shortcut) as ShortcutStorage;
  }

  Future<ShortcutSetItemModel?> getSavedSelectedShortcut() async {
    geaLog.debug("$tag getSavedSelectedShortcut");

    // Reset the temporal saved values
    if (_storage.selectedShortcut != null) {
      return _storage.selectedShortcut;
    }

    if (_storage.editedShortcut != null) {
      return _storage.editedShortcut?.item;
    }

    return null;
  }

  Future<void> saveCurrentShortcut() async {
    geaLog.debug("$tag saveCurrentShortcut");

    // Reset the temporal saved values
    if (_storage.selectedShortcut != null) {
      await storeShortcut(null, _storage.selectedShortcut);
    }

    if (_storage.editedShortcut != null) {
      await storeShortcut(_storage.editedShortcut?.shortcutId,
          _storage.editedShortcut?.item);
    }
  }

  Future<void> storeShortcut(String? id, ShortcutSetItemModel? model) async {
    geaLog.debug("$tag storeShortcut");
    // Reset the temporal saved values
    if (_storage.selectedShortcut != null) {
      await _shortcutService.storeShortcut(id, model);
      _storage.setSelectedShortcut = null;
    }

    if (_storage.editedShortcut != null) {
      await _shortcutService.updateShortcut(id, model);
      _storage.setEditedShortcut = null;
    }

    _shortcutServiceRepository.notifyNewShortcutCreated(model);
    emit(ShortcutReviewShortcutSavingSucceeded());
  }
}