// file: local_data_manager.dart
// date: Nov/25/2021
// brief: A manager class to manage all storage on memory.
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:smarthq_flutter_module/resources/storage/storages.dart';

enum StorageType {
  native,
  erd,
  apiService,
  wifiCommissioning,
  bleCommissioning,
  gateway,
  dialog,
  shortcut
}

abstract class LocalDataManager {
  Storage getStorage(StorageType type);
}

class LocalDataManagerImpl extends LocalDataManager {
  LocalDataManagerImpl._();
  static final LocalDataManagerImpl _instance = LocalDataManagerImpl._();
  factory LocalDataManagerImpl(List<Storage> storages) {
    _instance._initStorages(storages);
    return _instance;
  }

  List<Storage> _storages = [];

  @override
  Storage getStorage(StorageType type) {
    final index = _storages.indexWhere((storageType) => storageType.getType() == type);
    assert(index != -1, '$type is not included in the storage list');
    return _storages[index];
  }

  void _initStorages(List<Storage> storages) {
    storages.forEach((storage) {
      _storages.add(storage);
    });
  }
}
