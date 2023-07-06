// file: erd_storage.dart
// date: Sep/30/2022
// brief: A storage to save the erd data on memory.
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:smarthq_flutter_module/managers/local_data_manager.dart';
import 'package:smarthq_flutter_module/resources/storage/base_storage.dart';

abstract class ErdStorage extends Storage {
  void setErdValue(String jid, String erdNumber, String erdValue);
  String? getErdValue(String jid, String erdNumber);
  void setCache(String jid, List<Map<String, String>> cache);
  List<Map<String, String>>? getCache(String jid);
}

class ErdStorageImpl extends ErdStorage {
  ErdStorageImpl._();
  static final ErdStorageImpl _instance = ErdStorageImpl._();
  factory ErdStorageImpl() {
    return _instance;
  }

  @override
  StorageType getType() {
    return StorageType.erd;
  }

  /// memory value to save the erd data
  List<Map<String, List<Map<String, String>>>> _erdData = <Map<String, List<Map<String, String>>>>[];

  @override
  String? getErdValue(String jid, String erdNumber) {
    final erdMapIndex = _erdData.indexWhere((erdMap) => erdMap[jid] != null);
    if (erdMapIndex != -1) {
      var erdMap = _erdData[erdMapIndex];
      final erdListIndex = erdMap[jid]!.indexWhere((erdList) => erdList[erdNumber] != null);
      if (erdListIndex != -1) {
        var erdList = erdMap[jid]?[erdListIndex];
        return erdList?[erdNumber];
      }
    }
    return null;
  }

  @override
  List<Map<String, String>>? getCache(String jid) {
    final erdMapIndex = _erdData.indexWhere((erdMap) => erdMap[jid] != null);
    if (erdMapIndex != -1) {
      return _erdData[erdMapIndex][jid];
    }
    return null;
  }

  @override
  void setErdValue(String jid, String erdNumber, String erdValue) {
    final erdMapIndex = _erdData.indexWhere((erdMap) => erdMap[jid] != null);
    if (erdMapIndex != -1) {
      var erdMap = _erdData[erdMapIndex];
      final erdListIndex = erdMap[jid]!.indexWhere((erdList) => erdList[erdNumber] != null);
      if (erdListIndex != -1) {
        var erdList = erdMap[jid]?[erdListIndex];
        erdList?[erdNumber] = erdValue;
      }
      else {
        erdMap[jid]?.add({erdNumber: erdValue});
      }
    }
    else {
      _erdData.add({jid: [{erdNumber: erdValue}]});
    }
  }

  @override
  void setCache(String jid, List<Map<String, String>> cache) {
    final erdMapIndex = _erdData.indexWhere((erdMap) => erdMap[jid] != null);
    if (erdMapIndex != -1) {
      _erdData[erdMapIndex][jid] = cache;
    }
    else {
      _erdData.add({jid: cache});
    }
  }
}