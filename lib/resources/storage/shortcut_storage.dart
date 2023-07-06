import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/resources/storage/base_storage.dart';

abstract class ShortcutStorage extends Storage {
  String? get selectedApplianceId;
  set setSelectedApplianceId(String? selectedApplianceId);

  String? get selectedApplianceType;
  set setSelectedApplianceType(String? selectedApplianceType);

  String? get selectedApplianceNickname;
  set setSelectedApplianceNickname(String? selectedApplianceNickname);

  String? get selectedOvenType;
  set setSelectedOvenType(String? selectedOvenType);

  String? get selectedOvenRackType;
  set setSelectedOvenRackType(String? selectedOvenRackType);

  ShortcutSetItemModel? get selectedShortcut;
  set setSelectedShortcut(ShortcutSetItemModel? selectedShortcut);

  ShortcutSetListModel? get editedShortcut;
  set setEditedShortcut(ShortcutSetListModel? editedShortcut);
}

class ShortcutStorageImpl extends ShortcutStorage {
  ShortcutStorageImpl._();

  static final ShortcutStorageImpl _instance = ShortcutStorageImpl._();

  factory ShortcutStorageImpl() {
    return _instance;
  }

  @override
  StorageType getType() {
    return StorageType.shortcut;
  }

  String? _selectedApplianceId;
  @override String? get selectedApplianceId => _selectedApplianceId;
  @override set setSelectedApplianceId(String? selectedApplianceId) => _selectedApplianceId = selectedApplianceId;

  String? _selectedApplianceType;
  @override String? get selectedApplianceType => _selectedApplianceType;
  @override set setSelectedApplianceType(String? selectedApplianceType) => _selectedApplianceType = selectedApplianceType;

  String? _selectedApplianceNickname;
  @override String? get selectedApplianceNickname => _selectedApplianceNickname;
  @override set setSelectedApplianceNickname(String? selectedApplianceNickname) => _selectedApplianceNickname = selectedApplianceNickname;

  String? _selectedOvenType;
  @override String? get selectedOvenType => _selectedOvenType;
  @override set setSelectedOvenType(String? selectedOvenType) => _selectedOvenType = selectedOvenType;

  String? _selectedOvenRackType;
  @override String? get selectedOvenRackType => _selectedOvenRackType;
  @override set setSelectedOvenRackType(String? selectedOvenRackType) => _selectedOvenRackType = selectedOvenRackType;

  ShortcutSetItemModel? _selectedShortcut;
  @override ShortcutSetItemModel? get selectedShortcut => _selectedShortcut;
  @override set setSelectedShortcut(ShortcutSetItemModel? selectedShortcut) => _selectedShortcut = selectedShortcut;

  ShortcutSetListModel? _editedShortcut;
  @override ShortcutSetListModel? get editedShortcut => _editedShortcut;
  @override set setEditedShortcut(ShortcutSetListModel? editedShortcut) => _editedShortcut = editedShortcut;
}