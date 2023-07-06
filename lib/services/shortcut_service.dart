import 'dart:convert';
import 'dart:math';

import 'package:smarthq_flutter_module/managers/shared_data_manager.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';

enum ShortcutType {
  shortcutTypeMode,
  shortcutTypeTurnOff;

  factory ShortcutType.getTypeFrom({required String name}) {
    return ShortcutType.values.firstWhere((value) => value.name == name,
        orElse: () => ShortcutType.shortcutTypeMode);
  }
}

enum OvenType {
  singleOven,
  doubleOven,
  sideBySide;

  factory OvenType.getTypeFrom({required String name}) {
    return OvenType.values.firstWhere((value) => value.name == name,
        orElse: () => OvenType.singleOven);
  }
}

enum OvenRackType {
  upperOven,
  lowerOven,
  leftOven,
  rightOven;

  factory OvenRackType.getTypeFrom({required String name}) {
    return OvenRackType.values.firstWhere((value) => value.name == name,
        orElse: () => OvenRackType.upperOven);
  }
}

abstract class BaseShortcutService {
  Future<List<ShortcutSetListModel>?> fetchStoredShortcuts();
  Future<ShortcutSetListModel?> fetchStoredShortcut(String? id);
  Future<void> storeShortcut(String? id, ShortcutSetItemModel? model);
  Future<void> removeAllShortcuts();
  Future<void> removeStoredShortcut(String? id);
  Future<String> createDefaultShortcutNickname();
}

class ShortcutService implements BaseShortcutService {
  static const String tag = "ShortcutService: ";

  late SharedDataManager _sharedDataManager;

  ShortcutService(this._sharedDataManager);

  Future<List<ShortcutSetListModel>?> fetchStoredShortcuts() async {
    geaLog.debug("$tag fetchStoredShortcuts");
    final allShortcuts = await _sharedDataManager.getStringValue(SharedDataKey.shortcutItems);

    if(allShortcuts != null) {
      if (allShortcuts.length == 0) {
        return [];
      }

      List<ShortcutSetListModel> list = (jsonDecode(allShortcuts) as List).map((data) => ShortcutSetListModel.fromJson(data)).toList();
      return list;
    }

    return null;
  }

  Future<ShortcutSetListModel?> fetchStoredShortcut(String? id) async {
    if (id == null) {
      geaLog.debug("$tag fetchStoredShortcut - no id");
      return null;
    }

    final storedShortcuts = await fetchStoredShortcuts();
    int? index = storedShortcuts?.indexWhere((item) => item.shortcutId == id);

    if (index == null) {
      return null;
    } else {
      return storedShortcuts?.elementAt(index);
    }
  }

  Future<void> storeShortcut(String? id, ShortcutSetItemModel? model) async {
    List<ShortcutSetListModel>? storedShortcuts = await fetchStoredShortcuts();

    if (model == null) {
      geaLog.debug("$tag storeShortcut: nothing to store");
      return;
    }

    ShortcutSetListModel? setItem;
    if (id != null) {
      setItem = ShortcutSetListModel(shortcutId: id, item: model);
    } else {
      final createdId = _createRandomIdNumber();
      setItem = ShortcutSetListModel(shortcutId: createdId, item: model);
    }

    if (storedShortcuts == null) {
      storedShortcuts = [setItem];
    } else {
      storedShortcuts.add(setItem);
    }

    _convertAndStore(storedShortcuts);
  }

  Future<void> updateShortcut(String? id, ShortcutSetItemModel? model) async {
    if (model == null) {
      geaLog.debug("$tag updateShortcut - no model");
      return;
    }

    List<ShortcutSetListModel>? storedShortcuts = await fetchStoredShortcuts();

    int? index = storedShortcuts?.indexWhere((item) => item.shortcutId == id);
    if (index == null) {
      geaLog.debug("$tag updateShortcut - no stored item");
    } else {

      storedShortcuts?[index] = ShortcutSetListModel(
          shortcutId: id,
          item: model);
    }

    _convertAndStore(storedShortcuts);
  }

  Future<void> removeAllShortcuts() async {
    geaLog.debug("$tag removeAllShortcuts");

    _convertAndStore(null);
  }

  Future<void> removeStoredShortcut(String? id) async {
    if (id == null) {
      geaLog.debug("$tag removeStoredShortcut - no stored shortcut to remove");
      return null;
    }

    List<ShortcutSetListModel>? storedShortcuts = await fetchStoredShortcuts();
    storedShortcuts?.removeWhere((element) => element.shortcutId == id);

    _convertAndStore(storedShortcuts);
  }

  Future<String> createDefaultShortcutNickname() async {
    final allShortcuts = await fetchStoredShortcuts();
    if (allShortcuts == null) {
      return "Shortcut 1"; // consider shortcut will be localized or not
    } else {
      return "Shortcut ${(allShortcuts.length + 1)}";
    }
  }

  // private functions
  Future<void> _convertAndStore(List<ShortcutSetListModel>? list) async {
    if (list == null) {
      await _sharedDataManager.setStringValue(SharedDataKey.shortcutItems, null);
      return;
    }

    final listMap = ShortcutSetListModel.getListMap(list);
    final string = jsonEncode(listMap);
    await _sharedDataManager.setStringValue(SharedDataKey.shortcutItems, string);
  }

  String _createRandomIdNumber() {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _random = Random();

    return String.fromCharCodes(Iterable.generate(30,
            (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));
  }
}