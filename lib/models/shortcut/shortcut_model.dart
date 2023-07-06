// file: shortcut_model.dart
// date: Oct/21/2022
// brief: Shortcut related model
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

class ShortcutListModel {
  final String? title;
  final List<ShortcutListItemModel?>? items;

  const ShortcutListModel({
    this.title,
    this.items
  });
}

class ShortcutListItemModel {
  final String imagePath;
  final String? title;
  final String? routePath;
  final String? option;

  const ShortcutListItemModel({
    required this.imagePath,
    required this.title,
    this.routePath,
    this.option
  });
}

class ShortcutSetListModel {
  String? shortcutId;
  ShortcutSetItemModel? item;

  ShortcutSetListModel({
    required this.shortcutId,
    required this.item
  });

  ShortcutSetListModel.fromJson(Map<String, dynamic> json) {
    shortcutId = json['shortcutId'];
    item = ShortcutSetItemModel.fromJson(json['item']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shortcutId'] = this.shortcutId;
    data['item'] = this.item?.toJson();

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'shortcutId': this.shortcutId,
      'item': this.item
    };
  }

  static dynamic getListMap(List<dynamic> items) {
    List<Map<String, dynamic>> list = [];
    items.forEach((element) {
      list.add(element.toMap());
    });
    return list;
  }
}

class ShortcutSetItemModel {
  String? jid;
  String? nickname;
  String? shortcutName;
  String? shortcutType;
  String? applianceType;
  String? ovenRackType;
  String? mode;
  String? tempUnit;
  String? temp;
  String? fan;

  ShortcutSetItemModel({
    required this.jid,
    required this.nickname,
    required this.shortcutName,
    required this.shortcutType,
    required this.applianceType,
    this.ovenRackType,
    required this.mode,
    this.tempUnit,
    this.temp,
    this.fan
  });

  ShortcutSetItemModel.fromJson(Map<String, dynamic> json) {
    jid = json['jid'];
    nickname = json['nickname'];
    shortcutName = json['shortcutName'];
    shortcutType = json['shortcutType'];
    applianceType = json['applianceType'];
    ovenRackType = json['ovenRackType'];
    mode = json['mode'];
    tempUnit = json['tempUnit'];
    temp = json['temp'];
    fan = json['fan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jid'] = this.jid;
    data['nickname'] = this.nickname;
    data['shortcutName'] = this.shortcutName;
    data['shortcutType'] = this.shortcutType;
    data['applianceType'] = this.applianceType;
    data['ovenRackType'] = this.ovenRackType;
    data['mode'] = this.mode;
    data['tempUnit'] = this.tempUnit;
    data['temp'] = this.temp;
    data['fan'] = this.fan;

    return data;
  }
}