// file: shared_preference_manager.dart
// date: Nov/25/2021
// brief: A manager to support saving data on file.
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum TypePrefix {
  boolType, stringType, jsonType
}

extension TypePrefixExtention on TypePrefix {
  // Get a random string from - https://randstrgen.lazyig.com/
  String get value {
    switch (this) {
      case TypePrefix.boolType: return "kTQUIoZS";
      case TypePrefix.stringType: return "PwBzhxL9";
      case TypePrefix.jsonType: return "EhEOylPE";
    }
  }
}

abstract class SharedDataKey {
  static const mobileDeviceToken = "mobile_device_token";
  static const geToken = "ge_token";
  static const pushToken = "push_token";
  static const tokenReceipt = "token_receipt";
  static const recipeExecutionId = "recipe_execution_id";

  //Stand Mixer
  static const standMixerActiveStirTimestamp = "stand_mixer_active_stir_timestamp";
  static const standMixerActiveStirEnabled = "stand_mixer_active_stir_enabled";

  // Shortcuts
  static const shortcutItems = "shortcut_items";
}

abstract class SharedDataManager {

  Future<void> clearAll();
  Future<void> setBooleanValue(String key, bool? value);
  Future<bool?> getBooleanValue(String key);
  Future<void> setStringValue(String key, String? value);
  Future<String?> getStringValue(String key);
}

/// FlutterSecureStorage is used for only saving the encryption key value.
/// All data is saved by SharedPreference Package.
class SharedDataManagerImpl extends SharedDataManager {
  SharedDataManagerImpl._();
  static final SharedDataManagerImpl _instance = SharedDataManagerImpl._();
  factory SharedDataManagerImpl() {
    return _instance;
  }

  final _encryptionKey = "encryption_key";
  final _ivKey = "iv_key";
  final _secureStorage = new FlutterSecureStorage();

  @override
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<void> setBooleanValue(String key, bool? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value != null) {
      final prefixedValue = _setPrefixValue(value.toString().toLowerCase(), TypePrefix.boolType);
      final encryptedValue = await _encryptData(prefixedValue);
      await prefs.setString(key, encryptedValue!);
    }
    else {
      await prefs.remove(key);
    }
  }

  @override
  Future<bool?> getBooleanValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encryptedValue = prefs.getString(key);

    if (encryptedValue != null) {
      final prefixedValue = await _decryptData(encryptedValue);
      if (prefixedValue != null) {
        final value = _getOriginalValue(prefixedValue, TypePrefix.boolType);
        if (value != null)
          return value.toLowerCase() == true.toString();
      }
    }
    return null;
  }

  @override
  Future<void> setStringValue(String key, String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value != null) {
      final prefixedValue = _setPrefixValue(value, TypePrefix.stringType);
      final encryptedValue = await _encryptData(prefixedValue);
      await prefs.setString(key, encryptedValue!);
    }
    else {
      await prefs.remove(key);
    }
  }

  @override
  Future<String?> getStringValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encryptedValue = prefs.getString(key);

    if (encryptedValue != null) {
      final prefixedValue = await _decryptData(encryptedValue);
      if (prefixedValue != null) {
        final value = _getOriginalValue(prefixedValue, TypePrefix.stringType);
        return value;
      }
    }
    return null;
  }

  Future<String?> _obtainEncryptionKey() async {
    var storedEncryptionKey = await _secureStorage.read(key: _encryptionKey);
    if (storedEncryptionKey == null) {
      final encryptionKey = SecureRandom(32).base64;
      await _secureStorage.write(key: _encryptionKey, value: encryptionKey);
      storedEncryptionKey = encryptionKey;
    }
    return storedEncryptionKey;
  }

  Future<String?> _obtainIV() async {
    var storedIVKey = await _secureStorage.read(key: _ivKey);
    if (storedIVKey == null) {
      final iVKey = IV.fromLength(16).base64;
      await _secureStorage.write(key: _ivKey, value: iVKey);
      storedIVKey = iVKey;
    }
    return storedIVKey;
  }

  Future<String?> _encryptData(String value) async {
    final key = await _obtainEncryptionKey();
    final iv = await _obtainIV();
    if (key != null && iv != null) {
      final aesKey = Key.fromBase64(key);
      final uInt8ListValue = Uint8List.fromList(utf8.encode(value));
      final encryptedBytes = AES(aesKey).encrypt(uInt8ListValue, iv: IV.fromBase64(iv));
      return encryptedBytes.base64;
    }
    return null;
  }

  Future<String?> _decryptData(String value) async {
    final key = await _obtainEncryptionKey();
    final iv = await _obtainIV();
    if (key != null && iv != null) {
      final aesKey = Key.fromBase64(key);
      final encryptedValue = Encrypted.from64(value);
      final decryptedBytes = AES(aesKey).decrypt(encryptedValue, iv: IV.fromBase64(iv));
      return utf8.decode(decryptedBytes);
    }
    return null;
  }

  String _setPrefixValue(String value, TypePrefix type) {
    final prefixValue = type.value + value;
    return prefixValue;
  }

  String? _getOriginalValue(String value, TypePrefix type) {
    final match = value.startsWith(type.value);
    if (match) {
      final originalValue = value.split(type.value);
      return originalValue.last;
    } else {
      return null;
    }
  }
}